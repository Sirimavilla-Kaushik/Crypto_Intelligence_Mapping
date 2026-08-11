/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author trios
 */
@WebServlet("/TxCallback")
public class TxCallback extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String txHash = req.getParameter("txHash");
        int userId = Integer.parseInt(req.getParameter("userId"));

        try (Connection con = new connection.Dbconnection().getConnection()) {
            // Fetch transaction/receipt using web3j (Java) or call your node via JSON-RPC.
            // Pseudocode below; implement with web3j if available:

            // Web3j web3 = Web3j.build(new HttpService("http://127.0.0.1:8545"));
            // EthTransaction txResp = web3.ethGetTransactionByHash(txHash).send();
            // EthGetTransactionReceipt rcpResp = web3.ethGetTransactionReceipt(txHash).send();

            // Suppose we extracted:
            String sender = "...";
            String receiver = "...";
            long chainId = 1337L;
            java.math.BigInteger valueWei = new java.math.BigInteger("..."); // from tx
            java.math.BigInteger gasPriceWei = new java.math.BigInteger("...");
            java.math.BigInteger gasUsed = new java.math.BigInteger("...");
            long blockNumber = 12345L;

            double ethAmountOnChain = new java.math.BigDecimal(valueWei)
                .divide(new java.math.BigDecimal("1000000000000000000")).doubleValue();

            // Load the previously calculated ethAmount from DB (last row for user)
            double ethAmountCalc = 0.0;
            try (PreparedStatement ps = con.prepareStatement(
                "SELECT ETH_Amount FROM transactions WHERE User_Id=? ORDER BY T_Id DESC LIMIT 1")) {
                ps.setInt(1, userId);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) ethAmountCalc = rs.getDouble(1);
                }
            }

            RiskEngine.RiskResult post = RiskEngine.score(
                con, userId, sender, receiver, /*usd*/0.0, ethAmountCalc,
                chainId, java.time.Instant.now(), gasPriceWei, gasUsed, ethAmountOnChain
            );

            try (PreparedStatement ps = con.prepareStatement(
                "UPDATE transactions SET Tx_Hash=?, ChainId=?, GasPrice_WEI=?, GasUsed=?, BlockNumber=?, Risk_Score=?, Risk_Reasons=?, Flagged=? WHERE User_Id=? ORDER BY Txn_Id DESC LIMIT 1")) {
                ps.setString(1, txHash);
                ps.setLong(2, chainId);
                ps.setBigDecimal(3, new java.math.BigDecimal(gasPriceWei));
                ps.setLong(4, gasUsed.longValue());
                ps.setLong(5, blockNumber);
                ps.setInt(6, post.score);
                ps.setString(7, String.join("; ", post.reasons));
                ps.setInt(8, post.flagged() ? 1 : 0);
                ps.setInt(9, userId);
                ps.executeUpdate();
            }

            resp.setStatus(200);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, e.getMessage());
        }
    }
}
