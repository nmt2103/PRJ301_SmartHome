<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${ACTION} Room Page</title>
  </head>
  <body>
    <%@ include file="Menu.jsp" %>
    <h1>${ACTION} Room</h1>
    <form action="MainController" method="POST">
      <input type="hidden" name="action" value="${ACTION == 'Add' ? 'AddRoom' : 'UpdateRoom'}">

      <c:if test="${ACTION == 'Update'}">
        <label for="roomId">Room ID:</label>
        <input type="text" name="roomId" value="${ROOM.id}" readonly>
        <br>
      </c:if>

      <c:if test="${ACTION == 'Add'}">
        <label for="homeId">Home ID:</label>
        <select id="homeId" name="homeId" required>
          <option value="" selected>Choose a home</option>

          <c:forEach items="${HOME_LIST}" var="home">
            <option value="${home.id}">${home.code}</option>
          </c:forEach>

        </select>
        <br>
      </c:if>

      <label for="name">Name:</label>
      <input type="text" name="name" value="${ROOM.name}" required>
      <br>
      <label for="floor">Floor:</label>
      <input type="number" name="floor" value="${ROOM.floor}" required>
      <br>
      <label for="type">Type:</label>
      <input type="text" name="type" value="${ROOM.type}" required>
      <br>
      <label for="status">Status</label>
      <select id="status" name="status">
        <option value="true" ${ROOM.status ? 'selected' : ''}>Active</option>
        <option value="false" ${!ROOM.status ? 'selected' : ''}>Inactive</option>
      </select>
      <br>
      <input type="submit" value="${ACTION}">
    </form>

    <c:if test="${not empty ERROR_MSG}">
      <p>${ERROR_MSG}</p>
    </c:if>

    <a href="MainController?action=SearchRoom">Go back</a>
  </body>
</html>
