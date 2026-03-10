<%@page import="java.util.List"%>
<%@page import="dto.HomeModeDTO"%>
<%@page import="dto.HomeDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Nhận dữ liệu từ Controller
    List<HomeModeDTO> modeList = (List<HomeModeDTO>) request.getAttribute("MODE_LIST");
    List<HomeDTO> homeList = (List<HomeDTO>) request.getAttribute("HOME_LIST");

    // Giữ lại trạng thái của bộ lọc
    String paramKeyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
    String paramHomeId = request.getParameter("homeId") != null ? request.getParameter("homeId") : "0";
    String paramStatus = request.getParameter("activeStatus") != null ? request.getParameter("activeStatus") : "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Mode Management - Smart Home</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            .filter-box {
                background: #f9f9f9;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #6f42c1;
                color: white;
            } /* Đổi màu tím cho khác với Device */
            .btn {
                padding: 6px 12px;
                text-decoration: none;
                border-radius: 4px;
                color: white;
                border: none;
                cursor: pointer;
            }
            .btn-add {
                background-color: #28a745;
                margin-bottom: 10px;
                display: inline-block;
            }
            .btn-edit {
                background-color: #ffc107;
                color: black;
            }
            .btn-delete {
                background-color: #dc3545;
            }
            .btn-active {
                background-color: #28a745;
            }
            .btn-inactive {
                background-color: #6c757d;
            }
        </style>
    </head>
    <body>

        <h2>Home Mode Management</h2>

        <a href="homeModeController?action=create" class="btn btn-add">+ Add New Mode</a>
        <div class="filter-box">
            <form action="homeModeController" method="GET">
                <input type="hidden" name="action" value="search">

                <label>Search:</label>
                <input type="text" name="keyword" value="<%= paramKeyword%>" placeholder="Mode name...">

                <label>Home:</label>
                <select name="homeId">
                    <option value="0">-- All Homes --</option>
                    <%
                        if (homeList != null) {
                            for (HomeDTO home : homeList) {
                                String selected = (String.valueOf(home.getId()).equals(paramHomeId)) ? "selected" : "";
                    %>
                    <option value="<%= home.getId()%>" <%= selected%>><%= home.getName()%></option>
                    <%
                            }
                        }
                    %>
                </select>

                <label>Status:</label>
                <select name="activeStatus">
                    <option value="">-- All --</option>
                    <option value="1" <%= "1".equals(paramStatus) ? "selected" : ""%>>Active</option>
                    <option value="0" <%= "0".equals(paramStatus) ? "selected" : ""%>>Inactive</option>
                </select>

                <button type="submit" class="btn btn-active">Filter</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Mode Name</th>
                    <th>Active From</th>
                    <th>Active To</th>
                    <th>Assigned Home</th>
                    <th>Status (Toggle)</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (modeList != null && !modeList.isEmpty()) {
                        for (HomeModeDTO mode : modeList) {
                %>
                <tr>
                    <td><%= mode.getId()%></td>
                    <td><strong><%= mode.getName()%></strong></td>
                    <td><%= mode.getAct_fr()%></td>
                    <td><%= mode.getAct_to()%></td>
                    <td><%= mode.getHomeId().getName()%></td>

                    <td>
                        <a href="homeModeController?action=toggle&id=<%= mode.getId()%>&currentStatus=<%= mode.isIs_act()%>">
                            <% if (mode.isIs_act()) { %>
                            <span class="btn btn-active">Active</span>
                            <% } else { %>
                            <span class="btn btn-inactive">Inactive</span>
                            <% }%>
                        </a>
                    </td>

                    <td>
                        <a href="homeModeController?action=edit&id=<%= mode.getId()%>" class="btn btn-edit">Edit</a>
                        <a href="homeModeController?action=delete&id=<%= mode.getId()%>" class="btn btn-delete" 
                           onclick="return confirm('Are you sure you want to delete this mode permanently?');">Delete</a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="7" style="text-align: center; color: red;">No home modes found!</td>
                </tr>
                <% }%>
            </tbody>
        </table>

    </body>
</html>