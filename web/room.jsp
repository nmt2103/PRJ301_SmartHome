<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="dto.RoomDTO"%>
<%@page import="dao.RoomDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
  RoomDAO roomDAO = new RoomDAO();

  List<RoomDTO> rooms = roomDAO.getRooms("", "");
  if (request.getAttribute("ROOMS_LIST") != null) {
    rooms = (List<RoomDTO>) request.getAttribute("ROOM_LIST");
  }
%>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Room Page</title>
  </head>
  <body>
    <h1>Rooms</h1>

    <form action="RoomServlet">
      <input type="text" name="searchName" placeholder="Enter room name...">
      <br>
      <select name="filterStatus">
        <option value="active">Active</option>
        <option value="inactive">Inactive</option>
      </select>
      <br>
      <input type="submit" value="Search">
    </form>

    <table border="1" cellpadding="1">
      <thead>
        <tr>
          <th>Name</th>
          <th>Floor</th>
          <th>Type</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>

        <% for (RoomDTO room : rooms) {%>
        <tr>
          <td><%= room.getName()%></td>
          <td><%= room.getFloor()%></td>
          <td><%= room.getType()%></td>
          <td><%= room.getStatus()%></td>
          <td>
            <form action="RoomServlet" method="POST">
              <input type="submit" value="Update">
              <input type="hidden" name="homeId" value="<%= room.getId()%>">
            </form>
            <form action="RoomServlet" method="POST">
              <input type="submit" value="Delete">
              <input type="hidden" name="homeId" value="<%= room.getId()%>">
            </form>
          </td>
        </tr>
        <%}%>
      </tbody>
    </table>
    <a href="HomeServlet">Home Page</a>
  </body>
</html>
