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
            /* Import font Nunito cho đồng bộ với Menu */
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap');

            body {
                font-family: 'Nunito', sans-serif;
                background-color: #FAF7F2; /* Nền trang màu kem sáng ấm áp */
                color: #4A3324; /* Chữ màu nâu sẫm */
                padding: 20px;
            }

            h2 {
                color: #6C4F3D;
                font-weight: 700;
                margin-bottom: 20px;
                align-items: center;
            }

            /* Định dạng Box Lọc (Filter) */
            .filter-box {
                background: #FFFFFF;
                padding: 15px 20px;
                border: 1px solid #E6D5B8; /* Viền màu Latte */
                border-radius: 12px; /* Bo góc mềm mại */
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

            /* Định dạng Bảng (Table) */
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background-color: #FFFFFF;
                border-radius: 12px; /* Bo góc toàn bộ bảng */
                overflow: hidden; /* Giữ cho góc bo không bị trào ra */
                box-shadow: 0 4px 12px rgba(139, 69, 19, 0.05);
            }

            th, td {
                padding: 14px 15px;
                text-align: left;
                border-bottom: 1px solid #F0E6D2;
            }

            th {
                background-color: #D4A373; /* Tiêu đề bảng màu Caramel */
                color: white;
                font-weight: 600;
                letter-spacing: 0.5px;
            }

            tbody tr:hover {
                background-color: #FDFBF7; /* Highlight nền kem nhẹ khi rẽ chuột */
            }

            tbody tr:last-child td {
                border-bottom: none; /* Xóa viền dòng cuối cùng cho đẹp */
            }

            /* Định dạng Nút Bấm (Buttons) */
            .btn {
                padding: 8px 16px;
                text-decoration: none;
                border-radius: 8px; /* Bo tròn viên thuốc */
                color: white;
                border: none;
                cursor: pointer;
                font-weight: 600;
                font-family: 'Nunito', sans-serif;
                transition: all 0.2s ease;
                display: inline-block;
            }

            .btn:hover {
                transform: translateY(-2px); /* Hiệu ứng nảy nhẹ */
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            /* Bảng màu Cozy cho từng loại nút */
            .btn-add {
                background-color: #82A284;
                margin-bottom: 15px;
            } /* Xanh Sage Green */
            .btn-add:hover {
                background-color: #6C8C6E;
            }

            .btn-edit {
                background-color: #E9C46A;
                color: #4A3324;
            } /* Vàng Mustard */
            .btn-edit:hover {
                background-color: #D4B055;
            }

            .btn-delete {
                background-color: #E76F51;
            } /* Đỏ Terracotta */
            .btn-delete:hover {
                background-color: #D05D43;
            }

            .btn-active {
                background-color: #82A284;
            } /* Xanh Sage */
            .btn-inactive {
                background-color: #A9927D;
            } /* Nâu xám nhẹ */
        </style>
    </head>
    <body>
        <%@ include file="Menu.jsp" %>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="color: #6C4F3D; font-weight: 800; margin: 0;">
                Home Mode Management
            </h2>
            <a href="HomeModeServlet?action=create" class="btn btn-add">+ Add New Mode</a>
        </div>
        <div class="filter-box">
            <form action="HomeModeServlet" method="GET">
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
                        <a href="HomeModeServlet?action=toggle&id=<%= mode.getId()%>&currentStatus=<%= mode.isIs_act()%>">
                            <% if (mode.isIs_act()) { %>
                            <span class="btn btn-active">Active</span>
                            <% } else { %>
                            <span class="btn btn-inactive">Inactive</span>
                            <% }%>
                        </a>
                    </td>

                    <td>
                        <a href="HomeModeServlet?action=edit&id=<%= mode.getId()%>" class="btn btn-edit">Edit</a>
                        <a href="HomeModeSetvlet?action=delete&id=<%= mode.getId()%>" class="btn btn-delete" 
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