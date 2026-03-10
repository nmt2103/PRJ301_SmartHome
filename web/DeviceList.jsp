<%@page import="java.util.List"%>
<%@page import="dto.DeviceDTO"%>
<%@page import="dto.RoomDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Lấy dữ liệu từ Controller gửi sang bằng code Java thuần
    List<DeviceDTO> deviceList = (List<DeviceDTO>) request.getAttribute("DEVICE_LIST");
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("ROOM_LIST");

    // Giữ lại các giá trị đang tìm kiếm để hiển thị lên form
    String paramKeyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
    String paramRoomId = request.getParameter("roomId") != null ? request.getParameter("roomId") : "0";
    String paramStatus = request.getParameter("status") != null ? request.getParameter("status") : "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Device Management - Smart Home</title>
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
                background-color: #007bff;
                color: white;
            }
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

        <h2>Device Management</h2>

        <a href="DeviceForm.jsp" class="btn btn-add">+ Add New Device</a>

        <div class="filter-box">
            <form action="deviceController" method="GET">
                <input type="hidden" name="action" value="search">

                <label>Search:</label>
                <input type="text" name="keyword" value="<%= paramKeyword%>" placeholder="Name, serial...">

                <label>Room:</label>
                <select name="roomId">
                    <option value="0">-- All Rooms --</option>
                    <%
                        if (roomList != null) {
                            for (RoomDTO room : roomList) {
                                String selected = (String.valueOf(room.getId()).equals(paramRoomId)) ? "selected" : "";
                    %>
                    <option value="<%= room.getId()%>" <%= selected%>>
                        <%= room.getName()%> (<%= room.getHomeId().getName()%>)
                    </option>
                    <%
                            }
                        }
                    %>
                </select>

                <label>Status:</label>
                <select name="status">
                    <option value="">-- All --</option>
                    <option value="Active" <%= "Active".equals(paramStatus) ? "selected" : ""%>>Active</option>
                    <option value="Inactive" <%= "Inactive".equals(paramStatus) ? "selected" : ""%>>Inactive</option>
                </select>

                <button type="submit" class="btn btn-active">Filter</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Type</th>
                    <th>Serial No</th>
                    <th>Vendor</th>
                    <th>Location (Room)</th>
                    <th>Status (Toggle)</th>
                    <th>Last Seen</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (deviceList != null && !deviceList.isEmpty()) {
                        for (DeviceDTO device : deviceList) {
                %>
                <tr>
                    <td><%= device.getId()%></td>
                    <td><strong><%= device.getType()%></strong></td>
                    <td><%= device.getSerial()%></td>
                    <td><%= device.getVendor()%></td>
                    <td><%= device.getRoomId().getName()%> <br><small>(<%= device.getRoomId().getHomeId().getName()%>)</small></td>

                    <td>
                        <a href="deviceController?action=toggle&id=<%= device.getId()%>&status=<%= device.getStatus()%>">
                            <% if ("Active".equals(device.getStatus())) { %>
                            <span class="btn btn-active">Active</span>
                            <% } else { %>
                            <span class="btn btn-inactive">Inactive</span>
                            <% }%>
                        </a>
                    </td>

                    <td><%= device.getLastSeen()%></td>

                    <td>
                        <a href="deviceController?action=edit&id=<%= device.getId()%>" class="btn btn-edit">Edit</a>
                        <a href="deviceController?action=delete&id=<%= device.getId()%>" class="btn btn-delete" 
                           onclick="return confirm('Are you sure you want to delete this device?');">Delete</a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="8" style="text-align: center; color: red;">No devices found!</td>
                </tr>
                <% }%>
            </tbody>
        </table>

    </body>
</html>