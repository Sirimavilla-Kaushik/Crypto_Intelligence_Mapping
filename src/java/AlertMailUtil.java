/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author user
 */
import java.sql.*;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;

public class AlertMailUtil {

    public static void sendFlaggedAlert(Connection conn, String flaggedAddress) {

        try {
            // Fetch all users
            PreparedStatement psUsers = conn.prepareStatement(
                "SELECT User_Name, Email FROM user_registration"
            );
            ResultSet rsUsers = psUsers.executeQuery();

            while (rsUsers.next()) {
                sendMail(
                    rsUsers.getString("Email"),
                    rsUsers.getString("User_Name"),
                    flaggedAddress
                );
            }

            rsUsers.close();
            psUsers.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void sendMail(String to, String userName, String flaggedAddress) throws Exception {

        final String from = "javatrios07@gmail.com";
        final String password = "ncwbjzphrjztfupn";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, password);
                }
            });
try{
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from, "Crypto Analysis"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject("Security Alert: Flagged Wallet Detected");

        message.setText(
            "Hello " + userName + ",\n\n" +
            "A wallet has been flagged as malicious:\n\n" +
            flaggedAddress + "\n\n" +
            "Please avoid transactions with this address.\n\n" +
            "Crypto Analysis Security Team"
        );
System.out.println("Alert email sent successfully to " + to);
        Transport.send(message);
    }catch (Exception e) {
            throw new ServletException("Error sending alert email: " + e.getMessage(), e);
        }
    }
}
