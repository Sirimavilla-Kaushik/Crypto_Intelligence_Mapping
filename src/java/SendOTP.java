import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SendOTP")
public class SendOTP extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        if (email == null || email.isEmpty()) {
            throw new ServletException("Email parameter is missing or empty.");
        }

        // Generate 6-digit OTP
        int otp = (int)(Math.random() * 900000) + 100000;

        // Store OTP and email in session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);

        // Send OTP to email
        sendEmail(email, otp);

        // Redirect back to login page or to an OTP verification page
       session.setAttribute("email", email);
        response.sendRedirect("User_Login.jsp");
    }

    private void sendEmail(String recipient, int otp) throws ServletException {
        String host = "smtp.gmail.com"; // Or your SMTP host
        final String from = "javatrios07@gmail.com"; // Replace with your email
        final String password = "ncwbjzphrjztfupn"; // Replace with your email password

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            message.setSubject("Your OTP Code");
            message.setText("Hello User Your OTP is: " + otp);

            Transport.send(message);
            System.out.println("OTP sent successfully.");
            System.out.println("Your OTP is: " + otp);
        } catch (MessagingException mex) {
            System.err.println("Failed to send OTP. Error: " + mex.getMessage());
            throw new ServletException("Error sending OTP email.", mex);
        }
    }
}
