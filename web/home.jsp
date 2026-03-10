<%@page import="dao.HomeDAO"%>
<%@page import="dto.HomeDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
  HomeDAO homeDAO = new HomeDAO();

  List<HomeDTO> homes = homeDAO.getHomes("", "");
  if (request.getAttribute("HOME_LIST") != null) {
    homes = (List<HomeDTO>) request.getAttribute("HOME_LIST");
  }
%>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home Page</title>
  </head>
  <body>
    <h1>Homes</h1>

    <form action="HomeServlet">
      <input type="text" name="searchName" placeholder="Enter home name...">
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
          <th>Code</th>
          <th>Name</th>
          <th>Address</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>

        <% for (HomeDTO home : homes) {%>
        <tr>
          <td><%= home.getCode()%></td>
          <td><%= home.getName()%></td>
          <td><%= home.getAddress()%></td>
          <td><%= home.getStatus()%></td>
          <td>
            <form action="HomeServlet" method="POST">
              <input type="submit" value="Update">
              <input type="hidden" name="homeId" value="<%= home.getId()%>">
            </form>
            <form action="HomeServlet" method="POST">
              <input type="submit" value="Delete">
              <input type="hidden" name="homeId" value="<%= home.getId()%>">
            </form>
          </td>
        </tr>
        <%}%>

      </tbody>
    </table>
    <a href="room.jsp">Room Page</a>
  </body>
</html>
