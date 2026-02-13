<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Alerts</title>
</head>
<body>

<h2>System Alerts</h2>

<table border="1">
<tr>
    <th>Alert Time</th>
    <th>Meter ID</th>
    <th>Alert Type</th>
    <th>Status</th>
</tr>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/waterdb","root","password");

    ps = con.prepareStatement(
        "SELECT triggered_at, meter_id, alert_type, status FROM ALERTS"
    );

    rs = ps.executeQuery();

    while(rs.next()) {
%>
<tr>
    <td><%= rs.getTimestamp("triggered_at") %></td>
    <td><%= rs.getInt("meter_id") %></td>
    <td><%= rs.getString("alert_type") %></td>
    <td><%= rs.getString("status") %></td>
</tr>
<%
    }
} catch(Exception e) {
    out.println(e);
}
%>

</table>

</body>
</html>
