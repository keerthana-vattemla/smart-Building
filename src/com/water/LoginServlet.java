import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try (Connection con = DBUtil.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                "SELECT user_id FROM USER_ACCOUNT WHERE email=? AND password=?"
            );
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                res.sendRedirect("dashboard.html");
            } else {
                // ❌ Unauthorized login → Alert
                PreparedStatement alertPs = con.prepareStatement(
                    "INSERT INTO ALERTS (alert_id, meter_id, alert_type, triggered_at, status) " +
                    "VALUES (?, NULL, ?, NOW(), ?)"
                );

                alertPs.setInt(1, (int)(Math.random()*10000));
                alertPs.setString(2, "UNAUTHORIZED_LOGIN");
                alertPs.setString(3, "NEW");
                alertPs.executeUpdate();

                res.getWriter().println("Invalid Login Attempt Logged!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
