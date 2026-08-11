/*
 * Transaction Servlet (clean version)
 */
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import connection.Dbconnection;
import static java.lang.System.out;

@WebServlet("/Transaction")
public class Transaction extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String txHash = request.getParameter("TxnHash");

        try (Connection con = new Dbconnection().getConnection()) {

            int userId = Integer.parseInt(request.getParameter("User_Id"));
            String sender = request.getParameter("sender");
            String receiver = request.getParameter("receiver");

            PreparedStatement psCheck = con.prepareStatement(
                    "SELECT flagged FROM user_registration WHERE U_ID = ?"
            );
            psCheck.setInt(1, userId);
            ResultSet rsCheck = psCheck.executeQuery();

            if (rsCheck.next() && rsCheck.getInt("flagged") == 1) {
                session.setAttribute("msg", "User is flagged as phishing! Transactions not allowed.");
                response.sendRedirect("Transaction.jsp");
                return; // IMPORTANT: stop execution here
            }
            rsCheck.close();
            psCheck.close();

            // Check if this sender/receiver already has a pending transaction
            boolean exists = previousRowExists(con, userId, sender, receiver);

            if (!exists) {
                // ----------- 1. INSERT NEW TRANSACTION (Pre-risk) -----------
                String username = request.getParameter("Username");
                String email = request.getParameter("Email");
                String contact = request.getParameter("Contact");
                double usdAmount = Double.parseDouble(request.getParameter("usdAmount"));
                double ethAmount = Double.parseDouble(request.getParameter("ethAmount"));
                double gasFeeEstEth = Double.parseDouble(request.getParameter("gasFee"));
                String purpose = request.getParameter("purpose");
                String txnDateTime = request.getParameter("DateTime");

                // If TxHash not yet from MetaMask, generate a temp one
                if (txHash == null || txHash.isEmpty()) {
                    txHash = java.util.UUID.randomUUID().toString();
                }

                // Run pre-risk scoring
                RiskEngine.RiskResult pre = RiskEngine.score(
                        con, userId, sender, receiver, usdAmount, ethAmount,
                        null, java.time.Instant.now(), null, null, null);

                String sql = "INSERT INTO transactions "
                        + "(User_Id, Username, Email, Contact, Sender_Address, Receiver_Address, "
                        + "USD_Amount, ETH_Amount, Gas_Fee, Purpose, Date_Time, "
                        + "Risk_Score, Risk_Reasons, Flagged, Tx_Hash, Status) "
                        + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, userId);
                    ps.setString(2, username);
                    ps.setString(3, email);
                    ps.setString(4, contact);
                    ps.setString(5, sender);
                    ps.setString(6, receiver);
                    ps.setDouble(7, usdAmount);
                    ps.setDouble(8, ethAmount);
                    ps.setDouble(9, gasFeeEstEth);
                    ps.setString(10, purpose);
                    ps.setString(11, txnDateTime);
                    ps.setInt(12, pre.score);
                    ps.setString(13, String.join("; ", pre.reasons));
                    ps.setInt(14, pre.flagged() ? 1 : 0);
                    ps.setString(15, txHash);
                    ps.setString(16, "PENDING"); // status column: PENDING/CONFIRMED
                    ps.executeUpdate();
                }

//                if (pre.flagged()) {
//                    session.setAttribute("msg", "Transaction flagged as risky and blocked.");
//                    response.sendRedirect("transaction_blocked.jsp");
//                } 
if (pre.flagged()) {

    // 🔔 SEND ALERT AUTOMATICALLY
    AlertMailUtil.sendFlaggedAlert(con, sender);

    session.setAttribute("msg", "Transaction flagged as risky and blocked.");
    response.sendRedirect("transaction_blocked.jsp");
}else {
                    session.setAttribute("msg", "Transaction recorded. Awaiting blockchain confirmation.");
                    response.sendRedirect("Transaction.jsp");
                }

            } else {
                // ----------- 2. INSERT A CONFIRMATION ROW (Post-risk) -----------
                // Simulated blockchain data
                long chainId = 1337L;
                java.math.BigInteger gasPriceWei = java.math.BigInteger.valueOf(20000000000L);
                java.math.BigInteger gasUsed = java.math.BigInteger.valueOf(21000);
                long blockNumber = 12345L;
                double ethAmountOnChain = 0.01;

                // Fetch last transaction row
                double prevUsd = 0.0, prevEth = 0.0;
                int prevScore = 0;
                String prevReasons = "";
                boolean prevFlagged = false;

                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT USD_Amount, ETH_Amount, Risk_Score, Risk_Reasons, Flagged "
                        + "FROM transactions WHERE User_Id=? AND Sender_Address=? AND Receiver_Address=? "
                        + "ORDER BY T_Id DESC LIMIT 1")) {
                    ps.setInt(1, userId);
                    ps.setString(2, sender);
                    ps.setString(3, receiver);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            prevUsd = rs.getDouble("USD_Amount");
                            prevEth = rs.getDouble("ETH_Amount");
                            prevScore = rs.getInt("Risk_Score");
                            prevReasons = rs.getString("Risk_Reasons");
                            prevFlagged = rs.getInt("Flagged") == 1;
                        }
                    }
                }

                // Post-risk scoring
                RiskEngine.RiskResult post = RiskEngine.score(
                        con, userId, null, null,
                        0.0, prevEth,
                        chainId, java.time.Instant.now(),
                        gasPriceWei, gasUsed, ethAmountOnChain);

                // Total risk
                int totalScore = prevScore + post.score;
                String totalReasons = prevReasons + "; " + String.join("; ", post.reasons);
                boolean totalFlagged = totalScore > 100 || prevFlagged;

//                if (totalFlagged) {
//                    // Block the user in users table
//                    PreparedStatement ps2 = con.prepareStatement(
//                            "UPDATE user_registration SET Flagged = 1 WHERE U_Id = ?"
//                    );
//                    ps2.setInt(1, userId);  // sender is the Username
//                    ps2.executeUpdate();
//                    ps2.close();
//                }
if (totalFlagged) {

    // Block user
    PreparedStatement ps2 = con.prepareStatement(
        "UPDATE user_registration SET Flagged = 1 WHERE U_Id = ?"
    );
    ps2.setInt(1, userId);
    ps2.executeUpdate();
    ps2.close();

    // 🔔 AUTO EMAIL ALERT
    AlertMailUtil.sendFlaggedAlert(con, sender);
}

                // Insert confirmation row (instead of update)
                String upd = "INSERT INTO transactions "
                        + "(User_Id, Username, Email, Contact, Sender_Address, Receiver_Address, "
                        + "USD_Amount, ETH_Amount, Gas_Fee, Purpose, Date_Time, "
                        + "Tx_Hash, ChainId, GasPrice_WEI, GasUsed, BlockNumber, "
                        + "Risk_Score, Risk_Reasons, Flagged, Status) "
                        + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

                try (PreparedStatement ps = con.prepareStatement(upd)) {
                    ps.setInt(1, userId);
                    ps.setString(2, request.getParameter("Username"));
                    ps.setString(3, request.getParameter("Email"));
                    ps.setString(4, request.getParameter("Contact"));
                    ps.setString(5, sender);
                    ps.setString(6, receiver);
                    ps.setDouble(7, prevUsd);
                    ps.setDouble(8, prevEth + ethAmountOnChain);
                    ps.setDouble(9, Double.parseDouble(request.getParameter("gasFee")));
                    ps.setString(10, request.getParameter("purpose"));
                    ps.setString(11, request.getParameter("DateTime"));
                    ps.setString(12, txHash);
                    ps.setLong(13, chainId);
                    ps.setBigDecimal(14, new java.math.BigDecimal(gasPriceWei));
                    ps.setLong(15, gasUsed.longValue());
                    ps.setLong(16, blockNumber);
                    ps.setInt(17, totalScore);
                    ps.setString(18, totalReasons);
                    ps.setInt(19, totalFlagged ? 1 : 0);
                    ps.setString(20, "CONFIRMED");

                    ps.executeUpdate();
                }

                session.setAttribute("msg", "Transaction confirmed on blockchain. Hash saved: " + txHash);
                response.sendRedirect("Transaction.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Error: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }

    // Checks if sender/receiver already has at least one row
    private boolean previousRowExists(Connection con, int userId, String sender, String receiver) throws Exception {
        String sql = "SELECT T_Id FROM transactions WHERE User_Id=? AND Sender_Address=? AND Receiver_Address=? LIMIT 1";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, sender);
            ps.setString(3, receiver);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}
