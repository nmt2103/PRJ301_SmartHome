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
    <form action="MainController">
      <input type="submit" name="action" value="Logout">
    </form>

    <h1>Homes</h1>

    <form action="MainController">
      <input type="hidden" name="action" value="SearchHome">

      <div>
        <label for="searchName">Search:</label>
        <input type="text" name="searchName" value="${param.searchName}" placeholder="Enter home name...">
      </div>

      <div>
        <label for="filterStatus">Status:</label>
        <select id="filterStatus" name="filterStatus">
          <option value="" selected>Choose a status</option>
          <option value="active">Active</option>
          <option value="inactive">Inactive</option>
        </select>
      </div>

      <div>
        <input type="submit" value="Search">
      </div>
    </form>

    <c:if test="${not empty ERROR_MSG}">
      <p>${ERROR_MSG}</p>
    </c:if>

    <c:if test="${LOGIN_USER.role != 'USER'}">
      <form action="MainController">
        <input type="hidden" name="action" value="FormHome">
        <input type="submit" value="Add">
      </form>
    </c:if>

    <c:if test="${not empty HOME_LIST}">
      <table>
        <thead>
          <tr>
            <th>Code</th>
            <th>Name</th>
            <th>Address</th>
            <th>Status</th>

            <c:if test="${LOGIN_USER.role != 'USER'}">
              <th>Action</th>
              </c:if>

          </tr>
        </thead>
        <tbody>

          <c:forEach items="${HOME_LIST}" var="home">
            <tr>
              <td>${home.code}</td>
              <td>${home.name}</td>
              <td>${home.address}</td>
              <td>${home.status}</td>

              <c:if test="${LOGIN_USER.role != 'USER'}">
                <td>
                  <form action="MainController">
                    <input type="hidden" name="action" value="FormHome">
                    <input type="hidden" name="homeId" value="${home.id}">
                    <input type="submit" value="Update">
                  </form>
                  <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="DeleteHome">
                    <input type="hidden" name="homeId" value="${home.id}">
                    <input type="submit" value="Delete">
                  </form>
                </td>
              </c:if>

            </tr>
          </c:forEach>

        </tbody>
      </table>
    </c:if>

    <c:if test="${empty HOME_LIST}">
      <p>No home found!</p>
    </c:if>

    <a href="MainController?action=SearchRoom">Room Page</a>
    <br>
    <a href="MainController?action=SearchRule">Rule Page</a>
  </body>
</html>
