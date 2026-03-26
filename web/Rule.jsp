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
    <%@ include file="Menu.jsp" %>
    <h1>Rules</h1>

    <form action="MainController">
      <input type="hidden" name="action" value="SearchRule">

      <label for="searchName">Search:</label>
      <input type="text" name="searchName" placeholder="Enter rule name...">
      <br>
      <label for="filterStatus">Type:</label>
      <select id="filterStatus" name="filterStatus">
        <option value="" ${empty param.filterStatus ? 'selected' : ''}>-- All Status --</option>
        <option value="1" ${param.filterStatus == '1' ? 'selected' : ''}>Active</option>
        <option value="0" ${param.filterStatus == '0' ? 'selected' : ''}>Inactive</option>
      </select>
      <br>
      <input type="submit" value="Search">
    </form>

    <c:if test="${not empty SUCCESS_MSG}">
      <p>${SUCCESS_MSG}</p>
    </c:if>
    <c:if test="${not empty ERROR_MSG}">
      <p>${ERROR_MSG}</p>
    </c:if>

    <form action="MainController">
      <input type="hidden" name="action" value="FormRule">
      <input type="submit" value="Add New Rule">
    </form>

    <table>
      <thead>
        <tr>
          <th>Home ID</th>
          <th>Name</th>
          <th>Type</th>
          <th>Priority</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${RULE_LIST}" var="rule">
          <tr>
            <td>${rule.homeId}</td>
            <td>${rule.name}</td>
            <td>${rule.triggerType}</td>
            <td>${rule.priority}</td>
            <td>${rule.status ? 'Active' : 'Inactive'}</td>
            <td>
              <form action="MainController">
                <input type="hidden" name="action" value="FormRule">
                <input type="hidden" name="ruleId" value="${rule.id}">
                <input type="submit" value="Edit">
              </form>
              <form action="MainController" method="POST">
                <input type="hidden" name="action" value="DeleteRule">
                <input type="hidden" name="ruleId" value="${rule.id}">
                <input type="submit" value="Delete">
              </form>
            </td>
          </tr>
        </c:forEach>

      </tbody>
    </table>

  </body>
</html>
