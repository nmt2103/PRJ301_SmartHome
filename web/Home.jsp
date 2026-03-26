<%@page import="java.util.List"%>
<%@page import="dto.HomeDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ include file="Menu.jsp" %>

<style>
  .filter-box {
    background: #FFFFFF;
    padding: 15px 20px;
    border: 1px solid #E6D5B8;
    border-radius: 12px;
    margin-bottom: 20px;
    box-shadow: 0 4px 12px rgba(139, 69, 19, 0.05);
    display: flex;
    align-items: center;
    gap: 15px;
  }
  .filter-box form {
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 0;
  }
  .filter-box input[type="text"], .filter-box select {
    padding: 8px 12px;
    border: 1px solid #D4A373;
    border-radius: 8px;
    font-family: 'Nunito', sans-serif;
    color: #4A3324;
    outline: none;
  }
  table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    background-color: #FFFFFF;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(139, 69, 19, 0.05);
  }
  th, td {
    padding: 14px 15px;
    text-align: left;
    border-bottom: 1px solid #F0E6D2;
  }
  th {
    background-color: #D4A373;
    color: white;
    font-weight: 600;
    letter-spacing: 0.5px;
  }
  tbody tr:hover {
    background-color: #FDFBF7;
  }
  tbody tr:last-child td {
    border-bottom: none;
  }
  .btn {
    padding: 8px 16px;
    text-decoration: none;
    border-radius: 8px;
    color: white;
    border: none;
    cursor: pointer;
    font-weight: 600;
    font-family: 'Nunito', sans-serif;
    transition: all 0.2s ease;
    display: inline-block;
    font-size: 14px;
  }
  .btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }
  .btn-add {
    background-color: #82A284;
  }
  .btn-add:hover {
    background-color: #6C8C6E;
  }
  .btn-edit {
    background-color: #E9C46A;
    color: #4A3324;
  }
  .btn-edit:hover {
    background-color: #D4B055;
  }
  .btn-delete {
    background-color: #E76F51;
  }
  .btn-delete:hover {
    background-color: #D05D43;
  }
  .btn-active {
    background-color: #82A284;
  }
  .btn-inactive {
    background-color: #A9927D;
  }
  .msg {
    padding: 10px;
    border-radius: 8px;
    margin-bottom: 15px;
    font-weight: bold;
  }
  .msg-success {
    background-color: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
  }
  .msg-error {
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
  }
  .action-forms {
    display: flex;
    gap: 5px;
  }
  .action-forms form {
    margin: 0;
  }
</style>

<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
  <h2 style="color: #6C4F3D; font-weight: 800; margin: 0;">Home Management</h2>
  <form action="MainController" style="margin: 0;">
    <input type="hidden" name="action" value="FormHome">
    <button type="submit" class="btn btn-add">+ Add New Home</button>
  </form>
</div>

<%  String successMsg = (String) request.getAttribute("SUCCESS_MSG");
  String errorMsg = (String) request.getAttribute("ERROR_MSG");
  if (successMsg != null && !successMsg.isEmpty()) {
    out.print("<div class='msg msg-success'>✅ " + successMsg + "</div>");
  }
  if (errorMsg != null && !errorMsg.isEmpty()) {
    out.print("<div class='msg msg-error'>❌ " + errorMsg + "</div>");
  }
%>

<%
  String searchName = request.getParameter("searchName");
  String filterStatus = request.getParameter("filterStatus");
  if (searchName == null)
    searchName = "";
%>
<div class="filter-box">
  <form action="MainController">
    <input type="hidden" name="action" value="SearchHome">
    <label for="searchName">Search:</label>
    <input type="text" name="searchName" placeholder="Enter home name..." value="<%= searchName%>">
    <label for="filterStatus">Status:</label>
    <select name="filterStatus">
      <option value="" <%= (filterStatus == null || filterStatus.isEmpty()) ? "selected" : ""%>>-- All Status --</option>
      <option value="1" <%= "1".equals(filterStatus) ? "selected" : ""%>>Active</option>
      <option value="0" <%= "0".equals(filterStatus) ? "selected" : ""%>>Inactive</option>
    </select>
    <button type="submit" class="btn btn-active">Filter</button>
  </form>
</div>

<table>
  <thead>
    <tr>
      <th>Code</th>
      <th>Name</th>
      <th>Address</th>
      <th>Status</th>
      <th>Actions</th>
    </tr>
  </thead>
  <tbody>
    <%
      List<HomeDTO> homeList = (List<HomeDTO>) request.getAttribute("HOME_LIST");
      if (homeList != null && !homeList.isEmpty()) {
        for (HomeDTO home : homeList) {
          String statusClass = home.isStatus() ? "btn-active" : "btn-inactive";
    %>
    <tr>
      <td><strong><%= home.getCode()%></strong></td>
      <td><%= home.getName()%></td>
      <td><%= home.getAddress()%></td>
      <td>
        <span class="btn <%= statusClass%>" style="cursor: default; padding: 4px 10px;">
          <%= home.isStatus() ? "Active" : "Inactive"%>
        </span>
      </td>
      <td>
        <div class="action-forms">
          <form action="MainController">
            <input type="hidden" name="action" value="FormHome">
            <input type="hidden" name="homeId" value="<%= home.getId()%>">
            <button type="submit" class="btn btn-edit">Edit</button>
          </form>
          <form action="MainController" method="POST" onsubmit="return confirm('Are you sure you want to delete this home?');">
            <input type="hidden" name="action" value="DeleteHome">
            <input type="hidden" name="homeId" value="<%= home.getId()%>">
            <button type="submit" class="btn btn-delete">Delete</button>
          </form>
        </div>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="5" style="text-align: center; padding: 20px; color: #E76F51; font-weight: bold;">No homes found!</td>
    </tr>
    <%  }%>
  </tbody>
</table>

</main>
</div>
</body>
</html>
