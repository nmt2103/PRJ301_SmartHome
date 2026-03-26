<%@page import="java.util.List"%>
<%@page import="dto.DeviceDTO"%>
<%@page import="dto.RoomDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<DeviceDTO> deviceList = (List<DeviceDTO>) request.getAttribute("DEVICE_LIST");
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("ROOM_LIST");

    String paramKeyword = request.getParameter("keyword") != null ? request.getParameter(
            "keyword") : "";
    String paramRoomId = request.getParameter("roomId") != null ? request.getParameter(
            "roomId") : "0";
    String paramStatus = request.getParameter("status") != null ? request.getParameter(
            "status") : "";
%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Device Management - Smart Home</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap');

            body {
                font-family: 'Nunito', sans-serif;
                background-color: #FAF7F2;
                color: #4A3324;
                padding: 20px;
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

            .filter-box input, .filter-box select {
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
        </style>
    </head>
    <body>
        <%@ include file="Menu.jsp" %>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="color: #6C4F3D; font-weight: 800; margin: 0;">
                Device Management
            </h2>
            <a href="MainController?action=DeviceForm" class="btn btn-add">+ Add New Device</a>
        </div>
        <div class="filter-box">
            <form action="MainController" method="GET">
                <input type="hidden" name="action" value="SearchDevice">

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
                        <%= room.getName()%> (<%= room.getHomeId()%>)
                    </option>
                    <%
                            }
                        }
                    %>
                </select>

                <label>Status:</label>
                <select name="status">
                    <option value="" <%= "".equals(paramStatus) ? "selected" : ""%>>-- All --</option>
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
                    <th>Status</th>
                    <th>Last Seen</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (deviceList != null && !deviceList.isEmpty()) {
                        int stt = 1;
                        for (DeviceDTO device : deviceList) {
                            boolean isActive = device.isStatus();

                            String toggleClass = isActive ? "btn-active" : "btn-inactive";
                            String toggleText = isActive ? "Active" : "Inactive";
                %>
                <tr>
                    <td><%= stt++%></td>
                    <td><strong><%= device.getType()%></strong></td>
                    <td><%= device.getSerial()%></td>
                    <td><%= device.getVendor()%></td>
                    <td><%= device.getRoomId().getName()%></td>

                    <td>
                        <a href="MainController?action=ToggleDevice&id=<%= device.getId()%>&currentStatus=<%= isActive%>"
                           class="btn <%= toggleClass%>" style="padding: 4px 10px; text-decoration: none;">
                            <%= toggleText%>
                        </a>
                    </td>

                    <td><%= device.getLastSeen()%></td>

                    <td>
                        <div class="action-forms" style="display: flex; gap: 5px;">
                            <a href="MainController?action=DeviceForm&id=<%= device.getId()%>" class="btn btn-edit">Edit</a>

                            <a href="MainController?action=DeleteDevice&id=<%= device.getId()%>" class="btn btn-delete" 
                               onclick="return confirm('Are you sure you want to delete this device?');">Delete</a>
                        </div>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="8" style="text-align: center; color: #E76F51; font-weight: bold; padding: 20px;">No devices found!</td>
                </tr>
                <% }%>
            </tbody>
        </table>

    </body>
</html>