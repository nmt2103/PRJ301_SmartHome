<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
    <style>
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f7f6; /* Màu nền xám nhạt */
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh; /* Chiều cao bằng 100% màn hình */
      }

      /* 2. Khung chứa Form (Card) */
      .login-container {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 8px; /* Bo góc */
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
        width: 100%;
        max-width: 350px;
      }

      /* 3. Tiêu đề */
      .login-container h1 {
        text-align: center;
        color: #333333;
        margin-top: 0;
        margin-bottom: 25px;
      }

      /* 4. Nhóm nhập liệu (Thay thế cho thẻ <br>) */
      .form-group {
        margin-bottom: 15px;
      }

      .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #555555;
        font-size: 14px;
      }

      /* 5. Ô nhập liệu Text/Password */
      .form-group input[type="text"],
      .form-group input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #cccccc;
        border-radius: 4px;
        box-sizing: border-box; /* Đảm bảo padding không làm tràn width */
        font-size: 14px;
      }

      /* Hiệu ứng khi click vào ô nhập liệu */
      .form-group input[type="text"]:focus,
      .form-group input[type="password"]:focus {
        border-color: #007bff;
        outline: none;
      }

      /* 6. Nút Đăng nhập */
      .btn-submit {
        width: 100%;
        padding: 12px;
        background-color: #007bff; /* Màu xanh nước biển */
        color: #ffffff;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
        transition: background-color 0.3s;
      }

      /* Hiệu ứng khi di chuột qua nút */
      .btn-submit:hover {
        background-color: #0056b3;
      }

      /* 7. Khung Thông báo Thành công / Lỗi */
      .msg-box {
        padding: 10px;
        border-radius: 4px;
        text-align: center;
        margin-top: 20px;
        font-size: 14px;
      }

      .success-msg {
        color: #155724;
        background-color: #d4edda;
        border: 1px solid #c3e6cb;
      }

      .error-msg {
        color: #721c24;
        background-color: #f8d7da;
        border: 1px solid #f5c6cb;
      }
    </style>
  </head>
  <body>
    <div class="login-container">
      <h1>Login</h1>

      <form action="MainController" method="POST">
        <div class="form-group">
          <label for="username">Username:</label>
          <input type="text" name="username" id="username" placeholder="Enter username..." required>
        </div>

        <div class="form-group">
          <label for="password">Password:</label>
          <input type="password" name="password" id="password" placeholder="Enter password..." required>
        </div>
        <input type="submit" name="action" value="Login" class="btn-submit">
      </form>

      <c:if test="${not empty MSG}">
        <div class="msg-box success-msg">${MSG}</div>
      </c:if>
      <c:if test="${not empty ERROR_MSG}">
        <div class="msg-box errxor-msg">${ERROR_MSG}</div>
      </c:if>

    </div>
  </body>
</html>
