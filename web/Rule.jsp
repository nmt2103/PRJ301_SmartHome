<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="dto.RuleDTO"%>
<%@page import="dao.RuleDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Rule Page</title>
  </head>
  <body>
    <h1>Rules</h1>

    <form action="RuleServlet">
      <label for="searchName">Search:</label>
      <input type="text" name="searchName" placeholder="Enter rule name...">
      <br>
      <label for="filterType">Type:</label>
      <select id="filterType" name="filterType">
        <option value="" selected>Choose a status</option>
        <option value="">Active</option>
        <option value="">Inactive</option>
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

    <c:if test="${LOGIN_USER.role != 'USER'}">
      <form action="RuleServlet">
        <input type="submit" name="action" value="Add">
      </form>
    </c:if>

    <table border="1" cellpadding="1">
      <thead>
        <tr>
          <th>Home ID</th>
          <th>Name</th>
          <th>Type</th>
          <th>Priority</th>

          <c:if test="${LOGIN_USER.role != 'USER'}">
            <th>Action</th>
            </c:if>

        </tr>
      </thead>
      <tbody>

        <c:forEach items="${RULE_LIST}" var="rule">
          <tr>
            <td>${rule.homeId}</td>
            <td>${rule.name}</td>
            <td>${rule.triggerType}</td>
            <td>${rule.priority}</td>

            <c:if test="${LOGIN_USER.role != 'USER'}">
              <td>
                <form action="RuleServlet">
                  <input type="submit" name="action" value="Update">
                  <input type="hidden" name="ruleId" value="${rule.id}">
                </form>
                <form action="RuleServlet" method="POST">
                  <input type="submit" name="action" value="Delete">
                  <input type="hidden" name="ruleId" value="${rule.id}">
                </form>
              </td>
            </c:if>

          </tr>
        </c:forEach>

      </tbody>
    </table>
    <a href="HomeServlet">Home Page</a>
  </body>
</html>
