<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="dto.RoomDTO"%>
<%@page import="dao.RoomDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Room Page</title>
  </head>
  <body>
    <h1>Rooms</h1>

    <form action="RoomServlet">
      <label for="searchName">Search:</label>
      <input type="text" name="searchName" placeholder="Enter room name...">
      <br>
      <label for="filterStatus">Status:</label>
      <select id="filterStatus" name="filterStatus">
        <option value="" selected>Choose a status</option>
        <option value="active">Active</option>
        <option value="inactive">Inactive</option>
      </select>
      <br>
      <input type="submit" name="action" value="Search">
    </form>

    <c:if test="${not empty SUCCESS_MSG}">
      <p>${SUCCESS_MSG}</p>
    </c:if>
    <c:if test="${not empty ERROR_MSG}">
      <p>${ERROR_MSG}</p>
    </c:if>

    <form action="RoomServlet">
      <input type="submit" name="action" value="Add">
    </form>

    <table border="1" cellpadding="1">
      <thead>
        <tr>
          <th>Home ID</th>
          <th>Name</th>
          <th>Floor</th>
          <th>Type</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>

        <c:forEach items="${ROOM_LIST}" var="room">

          <tr>
            <td>${room.homeId}</td>
            <td>${room.name}</td>
            <td>${room.floor}</td>
            <td>${room.type}</td>
            <td>${room.status}</td>
            <td>
              <form action="RoomServlet">
                <input type="submit" name="action" value="Update">
                <input type="hidden" name="roomId" value="${room.id}">
              </form>
              <form action="RoomServlet" method="POST">
                <input type="submit" name="action" value="Delete">
                <input type="hidden" name="roomId" value="${room.id}">
              </form>
            </td>
          </tr>

        </c:forEach>

      </tbody>
    </table>
    <a href="HomeServlet">Home Page</a>
  </body>
</html>
