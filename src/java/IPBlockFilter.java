import connection.Dbconnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/*") // Applies to all URLs
public class IPBlockFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String userIP = req.getRemoteAddr();

        try (Connection con = new Dbconnection().connection;
             PreparedStatement ps = con.prepareStatement("SELECT 1 FROM block WHERE ip = ? LIMIT 1")) {

            ps.setString(1, userIP);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) { // IP is blocked
                // Redirect to block page
                res.sendRedirect(req.getContextPath() + "/IP_Block.jsp");
                return; // Stop further processing
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        chain.doFilter(request, response); // allow access if IP not blocked
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}
