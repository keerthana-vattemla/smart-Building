<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Smart Water Monitoring - Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="login-container">
    <h2>Login</h2>

    <form action="LoginServlet" method="post">
        <label>Username:</label><br>
        <input type="text" name="username" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <input type="submit" value="Login">
    </form>

    <% 
        String error = request.getParameter("error");
        if(error != null){
    %>
        <p style="color:red;">Invalid Username or Password</p>
    <% } %>

</div>

</body>
</html>
