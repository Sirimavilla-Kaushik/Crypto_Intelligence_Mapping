/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author user
 */
import java.io.IOException;
import java.sql.*;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Send_Mail")
public class Send_Mail extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        PreparedStatement psUsers = null;
        PreparedStatement psFlagged = null;
        ResultSet rsUsers = null;
        ResultSet rsFlagged = null;

        try {
            // 1. Connect to your database
       Class.forName("com.mysql.jdbc.Driver");
     conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/crypto_transaction","root","admin");

            // 2. Get all flagged addresses
            String sqlFlagged = "SELECT DISTINCT Sender_Address FROM transactions WHERE Flagged = 1";
            psFlagged = conn.prepareStatement(sqlFlagged);
            rsFlagged = psFlagged.executeQuery();

            StringBuilder flaggedAddresses = new StringBuilder();
            while (rsFlagged.next()) {
                flaggedAddresses.append(rsFlagged.getString("Sender_Address")).append(", ");
            }

            if (flaggedAddresses.length() > 0) {
                flaggedAddresses.setLength(flaggedAddresses.length() - 2); // remove last comma
            }

            // 3. Get all users in database
            String sqlUsers = "SELECT User_Name, Email FROM user_registration";
            psUsers = conn.prepareStatement(sqlUsers);
            rsUsers = psUsers.executeQuery();

            // 4. Send alert email to all users
            while (rsUsers.next()) {
                String email = rsUsers.getString("Email");
                String userName = rsUsers.getString("User_Name");

                sendAlertEmail(email, userName, flaggedAddresses.toString());
            }

            request.getSession().setAttribute("msg", "Alert emails sent successfully to all users.");
            response.sendRedirect("View_Transaction.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "Failed to send alert emails: " + e.getMessage());
            response.sendRedirect("View_Transaction.jsp");
        } finally {
            try { if (rsUsers != null) rsUsers.close(); } catch(Exception e) {}
            try { if (rsFlagged != null) rsFlagged.close(); } catch(Exception e) {}
            try { if (psUsers != null) psUsers.close(); } catch(Exception e) {}
            try { if (psFlagged != null) psFlagged.close(); } catch(Exception e) {}
            try { if (conn != null) conn.close(); } catch(Exception e) {}
        }
    }

    private void sendAlertEmail(String recipient, String userName, String flaggedAddresses) throws ServletException {
        String host = "smtp.gmail.com"; // SMTP host
        final String from = "javatrios07@gmail.com"; // your email
        final String password = "ncwbjzphrjztfupn"; // app password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

       try {
    Message message = new MimeMessage(session);
    message.setFrom(new InternetAddress(from, "Crypto Analysis")); // sender name
    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
    message.setSubject("Alert: Do Not Transact With Flagged Accounts");

    String msgContent = "Hello " + userName + ",\n\n" +
            "Our system, 'Crypto Analysis', has detected a wallet flagged as suspicious:\n\n" +
            flaggedAddresses + "\n\n" +
            "This tool is designed to trace cryptocurrency transaction trails and visualize them using spider maps. " +
            "Please avoid transacting with this address to ensure the safety of your funds.\n\n" +
            "Stay secure,\nCrypto Analysis Team";

    message.setText(msgContent);
    Transport.send(message);

    System.out.println("Alert email sent successfully to " + recipient);

} catch (Exception e) {
    e.printStackTrace();
}

    }
}
