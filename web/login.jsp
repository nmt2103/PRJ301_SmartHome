<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
  </head>
  <body>
    <h1>Login</h1>

    <form action="LoginServlet" method="POST">
      <label for="username">Username:</label>
      <input type="text" name="username" placeholder="Enter username..." required>
      <br>
      <label for="password">Password:</label>
      <input type="password" name="password" placeholder="Enter password..." required>
      <br>
      <input type="submit" value="Login">
    </form>

    <p>
      <%=request.getAttribute("ERROR_MSG") != null ? request.getAttribute(
              "ERROR_MSG") : ""%>
    </p>
  </body>
</html>
