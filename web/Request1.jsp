<%-- 
    Document   : Request1
    Created on : 28 Aug, 2025, 6:25:53 PM
    
--%>

<%@page import="connection.Dbconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%
            String U_Id=request.getParameter("U_Id");
            Dbconnection db1=new Dbconnection();
            String query="update crypto_transaction.user_registration set Status='Approved' where U_Id='"+U_Id+"'";
            int i=db1.update(query);
            if(i>0)
            {
                session.setAttribute("msg", "Approved Sucessfully!!");
                response.sendRedirect("User_Approval.jsp");
            }
        %>
    </body>
</html>
