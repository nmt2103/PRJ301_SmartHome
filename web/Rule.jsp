<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="dto.RuleDTO"%>
<%@page import="dao.RuleDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rule Management - Smart Home</title>
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
                align-items: center;
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

            /* CSS làm đẹp cho thông báo Lỗi / Thành công */
            .alert {
                padding: 10px 15px;
                border-radius: 8px;
                margin-bottom: 15px;
                font-weight: bold;
                font-family: 'Nunito', sans-serif;
            }
            .alert-success {
                background-color: #D4EDDA;
                color: #155724;
                border: 1px solid #C3E6CB;
            }
            .alert-error {
                background-color: #F8D7DA;
                color: #721C24;
                border: 1px solid #F5C6CB;
            }
        </style>
    </head>
    <body>
        <%@ include file="Menu.jsp" %>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="color: #6C4F3D; font-weight: 800; margin: 0;">
                Rule Management
            </h2>
            <a href="MainController?action=FormRule" class="btn btn-add">+ Add New Rule</a>
        </div>

        <c:if test="${not empty SUCCESS_MSG}">
            <div class="alert alert-success">${SUCCESS_MSG}</div>
        </c:if>
        <c:if test="${not empty ERROR_MSG}">
            <div class="alert alert-error">${ERROR_MSG}</div>
        </c:if>

        <div class="filter-box">
            <form action="MainController" method="GET" style="display: flex; align-items: center; gap: 15px; margin: 0;">
                <input type="hidden" name="action" value="SearchRule">

                <label>Search:</label>
                <input type="text" name="searchName" value="${param.searchName}" placeholder="Enter rule name...">

                <label>Type:</label>
                <select name="filterStatus">
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
                    <th>STT</th>
                    <th>Name</th>
                    <th>Home ID</th>
                    <th>Type</th>
                    <th>Priority</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty RULE_LIST}">
                        <c:forEach items="${RULE_LIST}" var="rule" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td><strong>${rule.name}</strong></td>
                                <td>${rule.homeId}</td>
                                <td>${rule.triggerType}</td>
                                <td>${rule.priority}</td>

                                <td>
                                    <span class="btn ${rule.status ? 'btn-active' : 'btn-inactive'}" style="padding: 4px 10px; cursor: default;">
                                        ${rule.status ? 'Active' : 'Inactive'}
                                    </span>
                                </td>

                                <td>
                                    <div class="action-forms" style="display: flex; gap: 5px;">
                                        <a href="MainController?action=FormRule&ruleId=${rule.id}" class="btn btn-edit">Edit</a>

                                        <a href="MainController?action=DeleteRule&ruleId=${rule.id}" class="btn btn-delete" 
                                           onclick="return confirm('Are you sure you want to delete this rule permanently?');">Delete</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" style="text-align: center; color: #E76F51; font-weight: bold; padding: 20px;">No rules found!</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

    </main>
</div>
</body>
</html>