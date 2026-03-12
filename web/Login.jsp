<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
      <input type="submit" name="action" value="Login">
    </form>

    <c:if test="${not empty MSG}">
      <p>${MSG}</p>
    </c:if>
    <c:if test="${not empty ERROR_MSG}">
      <p>${ERROR_MSG}</p>
    </c:if>

  </body>
</html>
