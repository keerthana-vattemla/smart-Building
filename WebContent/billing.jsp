<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Billing Summary</title>
</head>
<body>

<h2>Billing Details</h2>

<table border="1">
<tr>
    <th>Billing Period</th>
    <th>Total Usage</th>
    <th>Amount</th>
    <th>Payment Status</th>
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
        "SELECT billing_period, total_usage, amount, payment_status FROM BILLING"
    );

    rs = ps.executeQuery();

    while(rs.next()) {
%>
<tr>
    <td><%= rs.getString("billing_period") %></td>
    <td><%= rs.getDouble("total_usage") %></td>
    <td><%= rs.getDouble("amount") %></td>
    <td><%= rs.getString("payment_status") %></td>
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
