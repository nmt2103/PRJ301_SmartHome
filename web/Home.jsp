<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.HomeDAO"%>
<%@page import="dto.HomeDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home Page</title>
  </head>
  <body>
    <form action="LoginServlet">
      <input type="submit" name="action" value="Logout">
    </form>

    <h1>Homes</h1>

    <form action="HomeServlet">
      <label for="searchName">Search:</label>
      <input type="text" name="searchName" placeholder="Enter home name...">
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

    <form action="HomeServlet">
      <input type="submit" name="action" value="Add">
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

        <c:forEach items="${HOME_LIST}" var="home">

          <tr>
            <td>${home.code}</td>
            <td>${home.name}</td>
            <td>${home.address}</td>
            <td>${home.status}</td>
            <td>
              <form action="HomeServlet">
                <input type="submit" name="action" value="Update">
                <input type="hidden" name="homeId" value="${home.id}">
              </form>
              <form action="HomeServlet" method="POST">
                <input type="submit" name="action" value="Delete">
                <input type="hidden" name="homeId" value="${home.id}">
              </form>
            </td>
          </tr>

        </c:forEach>

      </tbody>
    </table>
    <a href="RoomServlet">Room Page</a>
  </body>
</html>
