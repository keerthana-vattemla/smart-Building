<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Usage Logs</title>
</head>
<body>

<h2>Water Usage Logs</h2>

<table border="1">
<tr>
    <th>Date & Time</th>
    <th>Meter ID</th>
    <th>Volume Used</th>
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
        "SELECT timestamp, meter_id, usage_liters FROM CONSUMPTION_LOG"
    );

    rs = ps.executeQuery();

    while(rs.next()) {
        double usage = rs.getDouble("usage_liters");
        String status = (usage > 250) ? "ABNORMAL" : "NORMAL";
%>
<tr>
    <td><%= rs.getTimestamp("timestamp") %></td>
    <td><%= rs.getInt("meter_id") %></td>
    <td><%= usage %></td>
    <td><%= status %></td>
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
