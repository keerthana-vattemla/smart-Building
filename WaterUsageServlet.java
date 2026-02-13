import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class UsageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int meterId = Integer.parseInt(req.getParameter("meter_id"));
        double usage = Double.parseDouble(req.getParameter("usage"));

        try (Connection con = DBUtil.getConnection()) {

            // Insert usage log
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO CONSUMPTION_LOG VALUES (?, ?, NOW(), ?, ?, ?)"
            );

            int logId = (int)(Math.random() * 10000);

            ps.setInt(1, logId);
            ps.setInt(2, meterId);
            ps.setDouble(3, usage);
            ps.setString(4, "SYSTEM");
            ps.setString(5, "CHK" + logId);
            ps.executeUpdate();

            // Detect unusual spike
            if (usage > 250) {
                PreparedStatement alertPs = con.prepareStatement(
                    "INSERT INTO ALERTS VALUES (?, ?, ?, NOW(), ?)"
                );

                alertPs.setInt(1, (int)(Math.random()*10000));
                alertPs.setInt(2, meterId);
                alertPs.setString(3, "HIGH_WATER_USAGE");
                alertPs.setString(4, "NEW");
                alertPs.executeUpdate();
            }

            res.getWriter().println("Usage Recorded Successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
