/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import connection.Dbconnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author trios
 */
@WebServlet("/CheckFlagServlet")
public class CheckFlagServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection con =new Dbconnection().getConnection()) {
            int userId = Integer.parseInt(request.getParameter("User_Id"));
            
            PreparedStatement ps = con.prepareStatement(
                "SELECT flagged FROM user_registration WHERE U_ID=?"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next() && rs.getInt("flagged") == 1) {
                response.getWriter().write("FLAGGED");
            } else {
                response.getWriter().write("SAFE");
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("ERROR");
        }
    }}
