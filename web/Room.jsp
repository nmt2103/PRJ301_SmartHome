<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="dto.RoomDTO"%>
<%@page import="dao.RoomDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Room Management - Smart Home</title>
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap');

      body {
        font-family: 'Nunito', sans-serif;
        background-color: #FAF7F2;
        color: #4A3324;
        padding: 20px;
        margin: 0;
      }

      h2 {
        color: #6C4F3D;
        font-weight: 700;
        margin-bottom: 20px;
      }

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
        margin-bottom: 15px;
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
  </head>
  <body>
    <%@ include file="Menu.jsp" %>

    <c:if test="${not empty SUCCESS_MSG}">
      <div class="msg msg-success">✅ ${SUCCESS_MSG}</div>
    </c:if>
    <c:if test="${not empty ERROR_MSG}">
      <div class="msg msg-error">❌ ${ERROR_MSG}</div>
    </c:if>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
      <h2 style="color: #6C4F3D; font-weight: 800; margin: 0;">
        Room Management
      </h2>

      <form action="MainController" style="margin: 0;">
        <input type="hidden" name="action" value="FormRoom">
        <button type="submit" class="btn btn-add">+ Add New Room</button>
      </form>
    </div>

    <div class="filter-box">
      <form action="MainController">
        <input type="hidden" name="action" value="SearchRoom">

        <label for="searchName">Search:</label>
        <input type="text" name="searchName" placeholder="Enter room name..." value="${param.searchName}">

        <label for="filterStatus">Status:</label>
        <select id="filterStatus" name="filterStatus">
          <option value="" ${empty param.filterStatus ? 'selected' : ''}>-- All Status --</option>
          <option value="1" ${param.filterStatus == '1' ? 'selected' : ''}>Active</option>
          <option value="0" ${param.filterStatus == '0' ? 'selected' : ''}>Inactive</option>
        </select>

        <button type="submit" class="btn btn-active">Filter</button>
      </form>
    </div>

    <table>
      <thead>
        <tr>
          <th>Home ID</th>
          <th>Name</th>
          <th>Floor</th>
          <th>Type</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${ROOM_LIST}" var="room">
          <tr>
            <td><strong>${room.homeId}</strong></td>
            <td>${room.name}</td>
            <td>${room.floor}</td>
            <td>${room.type}</td>
            <td>
              <span class="btn ${room.status ? 'btn-active' : 'btn-inactive'}" style="cursor: default; padding: 4px 10px;">
                ${room.status ? "Active" :"Inactive"}
              </span>
            </td>
            <td>
              <div class="action-forms">
                <form action="MainController">
                  <input type="hidden" name="action" value="FormRoom">
                  <input type="hidden" name="roomId" value="${room.id}">
                  <button type="submit" class="btn btn-edit">Edit</button>
                </form>
                <form action="MainController" method="POST" onsubmit="return confirm('Are you sure you want to delete this room?');">
                  <input type="hidden" name="action" value="DeleteRoom">
                  <input type="hidden" name="roomId" value="${room.id}">
                  <button type="submit" class="btn btn-delete">Delete</button>
                </form>
              </div>
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty ROOM_LIST}">
          <tr>
            <td colspan="6" style="text-align: center; padding: 20px; color: #E76F51;">No rooms found!</td>
          </tr>
        </c:if>
      </tbody>
    </table>

  </body>
</html>
