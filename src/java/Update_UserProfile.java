

import connection.Dbconnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateUserProfile")
public class Update_UserProfile extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        int userId = Integer.parseInt(request.getParameter("U_Id"));
        String userName = request.getParameter("User_Name");
        String email = request.getParameter("Email");
        String password = request.getParameter("Password");
         String Address = request.getParameter("Address");
         String Mobile = request.getParameter("Mobile");
        

        try {
            Dbconnection db = new Dbconnection();
            Connection con = db.getConnection();

            String query = "UPDATE user_registration SET User_Name=?, Email=?, Password=?, Address=?, Mobile_Number=? WHERE U_Id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, userName);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, Address);
            ps.setString(5, Mobile);
            ps.setInt(6, userId);

            int row = ps.executeUpdate();
            if (row > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("msg", "Profile Updated Successfully!");
                response.sendRedirect("User_Profile.jsp");
            } else {
                out.println("<script>alert('Update Failed!');window.location='User_Profile.jsp';</script>");
            }

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
}
