import connection.Dbconnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/User_Login"})
public class User_Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Dbconnection dbConnection = new Dbconnection();
            con = dbConnection.getConnection();

        
            String email = request.getParameter("Email");
            String password = request.getParameter("password");
            String enteredOtp = request.getParameter("otp");

            // Retrieve OTP from session and validate
            Object otpObj = session.getAttribute("otp");
            if (otpObj == null) {
                session.setAttribute("msg", "OTP not found. Please request a new one.");
                response.sendRedirect("User_Login.jsp");
                return;
            }
         int sessionOtp = (Integer) otpObj; 
         
if (enteredOtp != null && Integer.parseInt(enteredOtp) == sessionOtp) {
    

    Integer hitsCount = (Integer) session.getAttribute("hitCounter");
    if (hitsCount == null) hitsCount = 0;

    String query = "SELECT * FROM user_registration WHERE Email=? AND Password=?";
    pst = con.prepareStatement(query);
    pst.setString(1, email);
    pst.setString(2, password);
    rs = pst.executeQuery();

    if (rs.next()) {
        String status = rs.getString("status");

        if ("Rejected".equalsIgnoreCase(status)) {
            session.setAttribute("msg", "YOUR ACCOUNT IS REJECTED!");
            response.sendRedirect("User_Login.jsp");

        } else if ("No".equalsIgnoreCase(status)) {
            session.setAttribute("msg", "Approval is required before login.");
            response.sendRedirect("User_Login.jsp");

        } else {
            int id = rs.getInt("U_Id");
            session.setAttribute("msg", "Successfully Logged In");
            session.setAttribute("id", id);
            session.setAttribute("Email", email);
            session.removeAttribute("otp");
            session.removeAttribute("hitCounter");
            // ✅ Redirect to home page
            response.sendRedirect("User_Home.jsp");
        }
    } else {
        // Invalid password
        hitsCount++;
        session.setAttribute("hitCounter", hitsCount);
        session.setAttribute("msg", "ID or password does not match!");

        if (hitsCount > 3) {
            String ip = InetAddress.getLocalHost().getHostAddress();
            String blockQuery = "INSERT INTO block VALUES (?, ?)";
            try (PreparedStatement blockStmt = con.prepareStatement(blockQuery)) {
                blockStmt.setInt(1, 0);
                blockStmt.setString(2, ip);
                blockStmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
            session.setAttribute("msg", "Too many failed attempts. Access blocked.");
            response.sendRedirect("IP_Block.jsp");
        } else {
            response.sendRedirect("User_Login.jsp");
        }
    }

} else {
  
    session.setAttribute("msg", "Incorrect OTP. Please try again.");
    response.sendRedirect("User_Login.jsp");
}


        } catch (Exception ex) {
            out.println("Exception: " + ex);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Customer login handler with admin approval check and IP blocking.";
    }
}
