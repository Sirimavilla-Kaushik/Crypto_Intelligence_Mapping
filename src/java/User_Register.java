import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

/**
 *
 * @author trios
 */
@WebServlet(urlPatterns = {"/User_Register"})
public class User_Register extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
          PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);
       try {
            String User_Name = "" ,Email="",Password="",Gender = "", Mobile_Number = "",State="", City="",Current_Location="",lat="",lon="", IP_Address="";
            String saveFile = "";

            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(4012);

            ServletFileUpload upload = new ServletFileUpload(factory);

           List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
            byte[] data = null;
            String fileName = null;
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    String value = item.getString();

                  if (name.equalsIgnoreCase("User_Name")) {
                        User_Name = value;
                    }
                  
                   else if (name.equalsIgnoreCase("Email")) {
                        Email = value;
                    }
                    else if (name.equalsIgnoreCase("Password")) {
                        Password = value;
                    }
                    
                     else if (name.equalsIgnoreCase("Contact")) {
                        Mobile_Number = value;
                    }
                  
                    else if (name.equalsIgnoreCase("Gender")) {
                        Gender = value;
                    }
                    
                    
                    else if (name.equalsIgnoreCase("State")) {
                        State = value;
                    }                                        
                    
                    else if (name.equalsIgnoreCase("City")) {
                        City = value;
                    }  
                    
                    else if (name.equalsIgnoreCase("address")) {
                        Current_Location = value;
                    }
                     else if (name.equalsIgnoreCase("lat")) {
                        lat = value;
                    }
                  else if (name.equalsIgnoreCase("long")) {
                        lon = value;
                    }
                  else if (name.equalsIgnoreCase("ipaddress")) {
                        IP_Address = value;
                    }
                } else {
                    data = item.get();
                    fileName = item.getName();
                }
            }

            if (fileName != null && !fileName.isEmpty()) {
                String path1 = request.getSession().getServletContext().getRealPath("/");
                String strPath1 = path1 + File.separator + fileName;
                File file = new File(strPath1);
                FileOutputStream fileOut = new FileOutputStream(file);
                fileOut.write(data, 0, data.length);
                fileOut.flush();
                fileOut.close();

                FileInputStream fis = new FileInputStream(file);
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/crypto_transaction", "root", "admin");

                String query = "SELECT * FROM user_registration WHERE Email=?";
                PreparedStatement st = con.prepareStatement(query);
                st.setString(1, Email);

                ResultSet rs = st.executeQuery();

                if (rs.next()) {
                    session.setAttribute("msg", "User already exists. Please choose a different username or email.");
                    response.sendRedirect("User_Register.jsp");
                } else {
                    PreparedStatement stInsert = con.prepareStatement("INSERT INTO user_registration VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,'NO','0')");
                    stInsert.setInt(1, 0);
                    stInsert.setString(2, User_Name);
                     stInsert.setString(3, Email);                  
                    stInsert.setString(4, Password);
                    stInsert.setString(5, Gender);
                    stInsert.setString(6, Mobile_Number);
                    stInsert.setString(7, State);
                    stInsert.setString(8, City);
                    stInsert.setString(9, Current_Location);                   
                    stInsert.setString(10, lat);                   
                    stInsert.setString(11, lon);
                    stInsert.setString(12, IP_Address);
                    

                    stInsert.setBinaryStream(13, fis, (int) file.length());
                    int result = stInsert.executeUpdate();

                    fis.close();
                    file.delete(); // Delete the temporary uploaded file
                    if (result > 0) {
                        session.setAttribute("msg", "Successfully registered. Please log in.");
                        response.sendRedirect("User_Login.jsp"); // Redirect to login page
                    }
                }
            } else {
                session.setAttribute("msg", "Please upload a file.");
                response.sendRedirect("User_Register.jsp");
            }
        } catch (Exception e) {
            out.println(e);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
