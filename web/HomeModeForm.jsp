<%@page import="java.util.List"%>
<%@page import="dto.HomeDTO"%>
<%@page import="dto.HomeModeDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HomeModeDTO mode = (HomeModeDTO) request.getAttribute("MODE");
    List<HomeDTO> homeList = (List<HomeDTO>) request.getAttribute("HOME_LIST");

    boolean isEdit = (mode != null);
    String actionType = isEdit ? "update" : "insert";
    String pageTitle = isEdit ? "Edit Home Mode" : "Add New Home Mode";

    int modeId = isEdit ? mode.getId() : 0;
    String name = isEdit ? mode.getName() : "";
    int currentHomeId = (isEdit && mode.getHomeId() != null) ? mode.getHomeId().getId() : 0;
    boolean isActive = isEdit ? mode.isIs_act() : true; // Mặc định là true khi thêm mới

    String activeFromStr = (isEdit && mode.getAct_fr() != null) ? mode.getAct_fr().toString().substring(0, 5) : "00:00";
    String activeToStr = (isEdit && mode.getAct_to() != null) ? mode.getAct_to().toString().substring(0, 5) : "23:59";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= pageTitle%></title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
                background-color: #f4f7f6;
            }
            .form-container {
                background: white;
                padding: 20px 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                max-width: 500px;
                margin: auto;
            }
            h2 {
                text-align: center;
                color: #333;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }
            input[type="text"], input[type="time"], select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            .btn-submit {
                background-color: #6f42c1;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                margin-top: 10px;
            }
            .btn-submit:hover {
                background-color: #5a32a3;
            }
            .btn-cancel {
                background-color: #E76F51;
                display: block;
                padding: 9px 0px;
                text-align: center;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                margin-top: 5px;
                color: white;
                width: 100%;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%@ include file="Menu.jsp" %>
        <div class="form-container">
            <h2><%= pageTitle%></h2>

            <form action="HomeModeServlet" method="POST">
                <input type="hidden" name="action" value="<%= actionType%>">
                <input type="hidden" name="id" value="<%= modeId%>">

                <div class="form-group">
                    <label>Mode Name:</label>
                    <input type="text" name="name" value="<%= name%>" placeholder="e.g., Sleep Mode, Party..." required>
                </div>

                <div class="form-group">
                    <label>Active From (Time):</label>
                    <input type="time" name="activeFrom" value="<%= activeFromStr%>" required>
                </div>

                <div class="form-group">
                    <label>Active To (Time):</label>
                    <input type="time" name="activeTo" value="<%= activeToStr%>" required>
                </div>

                <div class="form-group">
                    <label>Assign to Home:</label>
                    <select name="homeId" required>
                        <option value="">-- Select Home --</option>
                        <%
                            if (homeList != null) {
                                for (HomeDTO home : homeList) {
                                    String selected = (home.getId() == currentHomeId) ? "selected" : "";
                        %>
                        <option value="<%= home.getId()%>" <%= selected%>>
                            <%= home.getName()%>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Status:</label>
                    <select name="isActive" required>
                        <option value="true" <%= isActive ? "selected" : ""%>>Active (ON)</option>
                        <option value="false" <%= !isActive ? "selected" : ""%>>Inactive (OFF)</option>
                    </select>
                </div>

                <button type="submit" class="btn-submit">Save Mode</button>
                <a href="HomeModeServlet?action=search" class="btn-cancel">Cancel / Go Back</a>
            </form>
        </div>

    </body>
</html>