<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${device == null ? 'Add new device' : 'Update device'}</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background-color: #f4f7f6; }
        .form-container { background: white; padding: 20px 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 500px; margin: auto; }
        h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; }
        input[type="text"], select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; width: 100%; font-size: 16px; margin-top: 10px;}
        .btn-submit:hover { background-color: #0056b3; }
        .btn-cancel { display: block; text-align: center; margin-top: 10px; color: #dc3545; text-decoration: none; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>${device == null ? 'Add new device' : 'Update device'}</h2>

    <form action="deviceController" method="POST">
        <input type="hidden" name="action" value="${device == null ? 'insert' : 'update'}">
        <input type="hidden" name="id" value="${device.id}">

        <div class="form-group">
            <label>Type:</label>
            <input type="text" name="type" value="${device.type}" placeholder="VD: Smart Lock, Light..." required>
        </div>

        <div class="form-group">
            <label>Serial No:</label>
            <input type="text" name="serialNo" value="${device.serialNo}" placeholder="VD: SL-LL-1234..." required>
        </div>

        <div class="form-group">
            <label>Vendor:</label>
            <input type="text" name="vendor" value="${device.vendor}" placeholder="VD: Lock n Lock, Xiaomi..." required>
        </div>

        <div class="form-group">
            <label>Room:</label>
            <select name="roomId" required>
                <option value="">-- Choose room to install --</option>
                <c:forEach items="${ROOM_LIST}" var="room">
                    <option value="${room.id}" ${device != null && device.room.id == room.id ? 'selected' : ''}>
                        ${room.name} (from: ${room.home.name})
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>Current status:</label>
            <select name="status" required>
                <option value="Active" ${device.status == 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${device.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>
        </div>

        <button type="submit" class="btn-submit">Save information</button>
        <a href="deviceController?action=search" class="btn-cancel">Cancel / Return</a>
    </form>
</div>
</body>
</html>