<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - Smart Home</title>
    <style>
      /* Import font Nunito */
      @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap');

      body, html {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: 'Nunito', sans-serif;
      }

      .login-wrapper {
        position: relative;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
      }

      .login-wrapper::before {
        content: "";
        position: absolute;
        top: -10px;
        left: -10px;
        right: -10px;
        bottom: -10px;

        background-image: url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
        background-size: cover;
        background-position: center;

        filter: blur(8px);
        opacity: 0.7;
        z-index: -1;
      }

      .login-wrapper::after {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(250, 247, 242, 0.4);
        z-index: -1;
      }

      .login-card {
        background: rgba(255, 255, 255, 0.95);
        padding: 40px 50px;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(108, 79, 61, 0.2);
        width: 100%;
        max-width: 380px;
        text-align: center;
        border: 1px solid rgba(255, 255, 255, 0.8);
        z-index: 1;
      }

      .login-card h2 {
        color: #6C4F3D;
        font-size: 28px;
        font-weight: 800;
        margin-top: 0;
        margin-bottom: 5px;
      }

      .login-card p {
        color: #A9927D;
        font-weight: 600;
        margin-bottom: 30px;
        font-size: 15px;
      }

      /* Định dạng Form và Input */
      .form-group {
        text-align: left;
        margin-bottom: 20px;
      }

      .form-group label {
        display: block;
        color: #6C4F3D;
        font-weight: 700;
        margin-bottom: 8px;
        font-size: 14px;
      }

      .form-group input[type="text"],
      .form-group input[type="password"] {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #E6D5B8;
        border-radius: 10px;
        font-family: 'Nunito', sans-serif;
        font-size: 15px;
        color: #4A3324;
        box-sizing: border-box;
        outline: none;
        transition: border-color 0.3s;
      }

      .form-group input[type="text"]:focus,
      .form-group input[type="password"]:focus {
        border-color: #D4A373;
        background-color: #FDFBF7;
      }

      .btn-login {
        background-color: #82A284;
        color: white;
        border: none;
        padding: 14px;
        width: 100%;
        border-radius: 10px;
        font-family: 'Nunito', sans-serif;
        font-size: 16px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 10px;
      }

      .btn-login:hover {
        background-color: #6C8C6E;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(130, 162, 132, 0.4);
      }

      .msg {
        padding: 10px;
        border-radius: 8px;
        margin-top: 20px;
        font-size: 14px;
        font-weight: 700;
      }
      .msg-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
      }
      .msg-error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
      }
    </style>
  </head>
  <body>

    <div class="login-wrapper">
      <div class="login-card">
        <h2>Welcome to Smart Home </h2>
        <p>Sign in to your Smart Home</p>

        <form action="MainController" method="POST">
          <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter your username..." required>
          </div>

          <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password..." required>
          </div>

          <button type="submit" name="action" value="Login" class="btn-login">Login</button>
        </form>

        <c:if test="${not empty MSG}">
          <div class="msg msg-success">✅ ${MSG}</div>
        </c:if>
        <c:if test="${not empty ERROR_MSG}">
          <div class="msg msg-error">❌ ${ERROR_MSG}</div>
        </c:if>
      </div>
    </div>

  </body>
</html>
