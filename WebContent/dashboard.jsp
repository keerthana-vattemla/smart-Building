<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Session validation
    if(session.getAttribute("username") == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Smart Water Monitoring - Dashboard</title>
    <link rel="stylesheet" href="css/style.css">

    <script>
        // Auto update every 5 seconds
        function loadUsage(){
            fetch('usage')
            .then(response => response.text())
            .then(data => {
                document.getElementById("liveData").innerHTML = data;
            });
        }

        setInterval(loadUsage, 5000);
        window.onload = loadUsage;
    </script>
</head>

<body>

<div class="header">
    <h2>Welcome, <%= session.getAttribute("username") %></h2>
    <a href="logout.jsp">Logout</a>
</div>

<div class="nav">
    <a href="logs.jsp">View Logs</a> |
    <a href="billing.jsp">Billing</a> |
    <a href="alerts.jsp">Alerts</a>
</div>

<div class="dashboard-c
