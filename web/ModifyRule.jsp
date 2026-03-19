<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${ACTION} Rule Page</title>
  </head>
  <body>
    <h1>${ACTION} Rule</h1>
    <form action="RuleServlet" method="POST">

      <c:if test="${ACTION == 'Update'}">
        <label for="ruleId">Rule ID:</label>
        <input type="text" name="ruleId" value="${RULE.id}" readonly>
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
      <input type="text" name="name" value="${RULE.name}" required>
      <br>
      <label for="type">Type:</label>
      <input type="text" name="type" value="${RULE.triggerType}" required>
      <br>
      <label for="priority">Priority:</label>
      <input type="number" name="priority" value="${RULE.priority}" required>
      <br>
      <label for="active">Active:</label>
      <select id="active" name="active">
        <option value="1" ${RULE.active == 1 ? 'selected' : ''}>Active</option>
        <option value="0" ${RULE.active == 0 ? 'selected' : ''}>Inactive</option>
      </select>
      <br>
      <input type="submit" name="action" value="${ACTION}">
    </form>

    <c:if test="${not empty ERROR_MSG}">
      <p>${ERROR_MSG}</p>
    </c:if>

    <a href="RuleServlet">Go back</a>
  </body>
</html>
