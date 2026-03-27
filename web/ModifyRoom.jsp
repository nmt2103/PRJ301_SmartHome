<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${ACTION == 'Add' ? 'Add New Room' : 'Update Room'} - Smart Home</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap');

            body {
                font-family: 'Nunito', sans-serif;
                padding: 20px;
                background-color: #FAF7F2;
            }
            .form-container {
                background: white;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(139, 69, 19, 0.05);
                max-width: 500px;
                margin: auto;
                border: 1px solid #E6D5B8;
            }
            h2 {
                text-align: center;
                color: #6C4F3D;
                font-weight: 800;
                margin-bottom: 25px;
            }
            .form-group {
                margin-bottom: 18px;
            }
            label {
                display: block;
                font-weight: bold;
                margin-bottom: 8px;
                color: #4A3324;
            }
            input[type="text"], input[type="number"], select {
                width: 100%;
                padding: 12px;
                border: 1px solid #D4A373;
                border-radius: 8px;
                box-sizing: border-box;
                font-family: 'Nunito', sans-serif;
                font-size: 15px;
                outline: none;
                transition: border 0.3s ease;
            }
            input:focus, select:focus {
                border-color: #82A284;
            }
            input[readonly] {
                background-color: #FDFBF7;
                color: #A9927D;
                cursor: not-allowed;
                border: 1px solid #E6D5B8;
            }
            .btn-submit {
                background-color: #6C5CE7;
                color: white;
                padding: 12px 15px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                font-weight: 700;
                margin-top: 20px;
                transition: background-color 0.3s ease;
            }
            .btn-submit:hover {
                background-color: #5A4BCE;
            }
            .btn-cancel {
                display: block;
                text-align: center;
                background-color: #E76F51;
                color: white;
                padding: 12px 15px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 700;
                font-size: 16px;
                margin-top: 10px;
                width: 100%;
                box-sizing: border-box;
                transition: background-color 0.3s ease;
            }
            .btn-cancel:hover {
                background-color: #D05D43;
                text-decoration: none;
            }
            .alert-error {
                background-color: #F8D7DA;
                color: #721C24;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 20px;
                text-align: center;
                border: 1px solid #F5C6CB;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%@ include file="Menu.jsp" %>

        <div class="form-container">
            <h2>${ACTION == 'Add' ? 'Add New Room' : 'Update Room'}</h2>

            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="${ACTION == 'Add' ? 'AddRoom' : 'UpdateRoom'}">

                <c:if test="${not empty ERROR_MSG}">
                    <div class="alert-error">${ERROR_MSG}</div>
                </c:if>

                <c:if test="${ACTION == 'Update'}">
                    <div class="form-group">
                        <label>Room ID:</label>
                        <input type="text" name="roomId" value="${ROOM.id}" readonly>
                    </div>
                </c:if>

                <c:if test="${ACTION == 'Add'}">
                    <div class="form-group">
                        <label>Home:</label>
                        <select name="homeId" required>
                            <option value="" selected>-- Choose a home --</option>
                            <c:forEach items="${HOME_LIST}" var="home">
                                <option value="${home.id}">${home.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>

                <div class="form-group">
                    <label>Name:</label>
                    <input type="text" name="name" value="${ROOM.name}" placeholder="VD: Living Room, Bed Room..." required>
                </div>

                <div class="form-group">
                    <label>Floor:</label>
                    <input type="number" name="floor" value="${ROOM.floor}" placeholder="VD: 1, 2, 3..." required>
                </div>

                <div class="form-group">
                    <label>Type:</label>
                    <input type="text" name="type" value="${ROOM.type}" placeholder="VD: Bedroom, Kitchen..." required>
                </div>

                <div class="form-group">
                    <label>Status:</label>
                    <select name="status" required>
                        <option value="true" ${ROOM.status ? 'selected' : ''}>Active</option>
                        <option value="false" ${!ROOM.status ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>

                <button type="submit" class="btn-submit">Save information</button>
                <a href="MainController?action=SearchRoom" class="btn-cancel">Cancel / Return</a>
            </form>
        </div>

    </main>
</div>
</body>
</html>