<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Home Page</title>
  </head>
  <body>
    <h1>${ACTION} Home</h1>
    <form action="HomeServlet" method="POST">
      <c:if test="${ACTION == 'Update'}">
        <label for="homeId">Home ID:</label>
        <input type="text" name="homeId" value="${HOME.id}" readonly>
        <br>
      </c:if>
      <label for="code">Code:</label>
      <input type="text" name="code" value="${HOME.code}" required>
      <br>
      <label for="name">Name:</label>
      <input type="text" name="name" value="${HOME.name}" required>
      <br>
      <label for="address">Address:</label>
      <input type="text" name="address" value="${HOME.address}" required>
      <br>
      <label for="status">Status</label>
      <select id="status" name="status">
        <option value="active" ${HOME.status == 'active' ? 'selected' : ''}>Active</option>
        <option value="inactive" ${HOME.status == 'inactive' ? 'selected' : ''}>Inactive</option>
      </select>
      <br>
      <input type="submit" name="action" value="${ACTION}">
    </form>

    <c:if test="${not empty ERROR_MSG}">
      <p>${ERROR_MSG}</p>
    </c:if>

    <a href="HomeServlet">Go back</a>
  </body>
</html>
