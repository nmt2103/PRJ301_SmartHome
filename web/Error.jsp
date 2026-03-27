<%@ page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<%
    // Tự động bắt mã lỗi từ Server (404, 500...)
    Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
    if (statusCode == null) {
        statusCode = 404; // Mặc định để test
    }

    // Tự động bắt cái đường link bị gõ sai (vd: /SmartHome/trash.jsp)
    String errorUri = (String) request.getAttribute("javax.servlet.error.request_uri");
    if (errorUri == null) {
        errorUri = "the requested page";
    }

    // Tạo câu thông báo chi tiết
    String errorMessage = (String) request.getAttribute("javax.servlet.error.message");
    if (errorMessage == null || errorMessage.trim().isEmpty()) {
        if (statusCode == 404) {
            errorMessage = "JSP file [" + errorUri + "] not found";
        } else if (statusCode == 500) {
            errorMessage = "Internal server error occurred while processing [" + errorUri + "]";
        } else {
            errorMessage = "An unexpected error occurred.";
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error <%= statusCode%> - Smart Home</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;800&display=swap');

            body {
                font-family: 'Nunito', sans-serif;
                background-color: #FAF7F2; /* Màu nền kem */
                margin: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                color: #4A3324;
            }

            .error-box {
                background: #FFFFFF;
                padding: 40px 50px 50px 50px;
                border-radius: 20px;
                text-align: center;
                box-shadow: 0 10px 30px rgba(139, 69, 19, 0.08);
                border: 1px solid #E6D5B8;
                max-width: 500px;
                width: 90%;
            }

            .robot-icon {
                margin-bottom: 20px;
            }

            .error-code {
                font-size: 55px;
                font-weight: 800;
                color: #E76F51; /* Màu đỏ Terracotta */
                margin: 0 0 10px 0;
                line-height: 1;
                letter-spacing: 2px;
            }

            .error-title {
                font-size: 24px;
                font-weight: 800;
                color: #6C4F3D;
                margin: 0 0 15px 0;
            }

            .error-message {
                color: #A9927D;
                font-size: 15px;
                margin-bottom: 35px;
                font-weight: 600;
            }

            .btn-home {
                display: inline-block;
                padding: 12px 30px;
                background-color: #82A284; /* Xanh Sage Green */
                color: white;
                text-decoration: none;
                border-radius: 10px;
                font-weight: 700;
                font-size: 16px;
                transition: all 0.3s ease;
            }

            .btn-home:hover {
                background-color: #6C8C6E;
                transform: translateY(-3px);
                box-shadow: 0 6px 15px rgba(130, 162, 132, 0.3);
            }
        </style>
    </head>
    <body>
        <div class="error-box">
            <div class="robot-icon">
                <svg viewBox="0 0 120 120" width="160" height="160" xmlns="http://www.w3.org/2000/svg">
                <path d="M 35 65 L 20 55 M 35 75 L 15 75 M 85 65 L 100 55 M 85 75 L 105 75" stroke="#E9C46A" stroke-width="3" stroke-linecap="round"/>
                <path d="M 50 65 L 60 85 M 70 65 L 50 85" stroke="#A9927D" stroke-width="4" stroke-linecap="round"/>
                <rect x="30" y="20" width="60" height="45" rx="10" fill="#82A284" />
                <line x1="60" y1="20" x2="60" y2="5" stroke="#82A284" stroke-width="4" stroke-linecap="round"/>
                <circle cx="60" cy="5" r="5" fill="#E76F51" />
                <path d="M 40 35 L 50 45 M 50 35 L 40 45" stroke="#FAF7F2" stroke-width="4" stroke-linecap="round"/>
                <path d="M 70 35 L 80 45 M 80 35 L 70 45" stroke="#FAF7F2" stroke-width="4" stroke-linecap="round"/>
                <path d="M 45 55 Q 60 48 75 55" fill="none" stroke="#FAF7F2" stroke-width="4" stroke-linecap="round"/>
                <path d="M 40 85 L 80 85 C 90 85 95 95 95 110 L 25 110 C 25 95 30 85 40 85 Z" fill="#A9927D" />
                </svg>
            </div>

            <h1 class="error-code">ERROR <%= statusCode%></h1>

            <h2 class="error-title">Something went wrong!</h2>

            <p class="error-message"><%= errorMessage%></p>

            <a href="MainController?action=Dashboard" class="btn-home">Return to Home</a>
        </div>
    </body>
</html>