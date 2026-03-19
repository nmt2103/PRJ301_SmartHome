<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${ACTION} Home Page</title>
  </head>
  <body>
    <h1>${ACTION} Home</h1>
    <form action="MainController" method="POST">
      <input type="hidden" name="action" value="${ACTION}Home">

      <c:if test="${ACTION == 'Update'}">
        <div>
          <label for="homeId">Home ID:</label>
          <input type="text" name="homeId" value="${HOME.id}" readonly>
        </div>
      </c:if>

      <div>
        <label for="code">Code:</label>
        <input type="text" name="code" value="${HOME.code}" required>
      </div>

      <div>
        <label for="name">Name:</label>
        <input type="text" name="name" value="${HOME.name}" required>
      </div>

      <div>
        <label for="address">Address:</label>
        <input type="text" name="address" value="${HOME.address}" required>
      </div>

      <div>
        <label for="status">Status</label>
        <select id="status" name="status">
          <option value="active" ${HOME.status == 'active' ? 'selected' : ''}>Active</option>
          <option value="inactive" ${HOME.status == 'inactive' ? 'selected' : ''}>Inactive</option>
        </select>
      </div>

      <div>
        <input type="submit" value="${ACTION}">
      </div>
    </form>

    <c:if test="${not empty ERROR_MSG}">
      <p>${ERROR_MSG}</p>
    </c:if>

    <a href="MainController?action=SearchHome"><button>Cancel</button></a>
  </body>
</html>
