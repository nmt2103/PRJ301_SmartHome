<%@page import="java.util.List"%>
<%@page import="dto.RoomDTO"%>
<%@page import="dto.DeviceDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DeviceDTO device = (DeviceDTO) request.getAttribute("DEVICE");
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("ROOM_LIST");

    boolean isEdit = (device != null);
    String actionType = isEdit ? "UpdateDevice" : "AddDevice";
    String pageTitle = isEdit ? "Update Device" : "Add New Device";

    int deviceId = isEdit ? device.getId() : 0;
    String type = isEdit ? device.getType() : "";
    String serialNo = isEdit ? device.getSerial() : "";
    String vendor = isEdit ? device.getVendor() : "";
    int currentRoomId = (isEdit && device.getRoomId() != null) ? device.getRoomId().getId() : 0;
    boolean isActive = isEdit ? device.isStatus() : true;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= pageTitle%></title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap');
            body {
                font-family: 'Nunito', sans-serif;
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
                color: #6C4F3D;
                font-weight: 700;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }
            input[type="text"], select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-family: 'Nunito', sans-serif;
            }
            .btn-submit {
                background-color: #82A284;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                font-weight: 600;
                margin-top: 10px;
            }
            .btn-submit:hover {
                background-color: #6C8C6E;
            }
            .btn-cancel {
                display: block;
                text-align: center;
                margin-top: 15px;
                color: #E76F51;
                text-decoration: none;
                font-weight: bold;
            }
            .btn-cancel:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <%@ include file="Menu.jsp" %>

        <div class="form-container">
            <h2><%= pageTitle%></h2>

            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="<%= actionType%>">
                <input type="hidden" name="id" value="<%= deviceId%>">

                <div class="form-group">
                    <label>Type:</label>
                    <input type="text" name="type" value="<%= type%>" placeholder="VD: Smart Lock, Light..." required>
                </div>

                <div class="form-group">
                    <label>Serial No:</label>
                    <input type="text" name="serialNo" value="<%= serialNo%>" placeholder="VD: SL-LL-1234..." required>
                </div>

                <div class="form-group">
                    <label>Vendor:</label>
                    <input type="text" name="vendor" value="<%= vendor%>" placeholder="VD: Lock n Lock, Xiaomi..." required>
                </div>

                <div class="form-group">
                    <label>Room:</label>
                    <select name="roomId" required>
                        <option value="">-- Choose room to install --</option>
                        <%
                            if (roomList != null) {
                                for (RoomDTO room : roomList) {
                                    String selected = (room.getId() == currentRoomId) ? "selected" : "";
                        %>
                        <option value="<%= room.getId()%>" <%= selected%>>
                            <%= room.getName()%>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Current status:</label>
                    <select name="status" required>
                        <option value="Active" <%= isActive ? "selected" : ""%>>Active</option>
                        <option value="Inactive" <%= !isActive ? "selected" : ""%>>Inactive</option>
                    </select>
                </div>

                <button type="submit" class="btn-submit">Save information</button>
                <a href="MainController?action=SearchDevice" class="btn-cancel">Cancel / Return</a>
            </form>
        </div>

    </main>
</div>
</body>
</html>