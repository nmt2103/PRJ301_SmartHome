<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
  :root {
    --bg-color: #FAF7F2;
    --sidebar-bg: #FFFFFF;
    --text-main: #4A3324;
    --text-muted: #A9927D;
    --accent-color: #D4A373;
    --active-green: #82A284;
    --card-bg: #FFFFFF;
    --border-color: #F0E6D2;
  }
  body, html {
    margin: 0;
    padding: 0;
    font-family: 'Nunito', sans-serif;
    background-color: var(--bg-color);
    color: var(--text-main);
    height: 100vh;
    overflow: hidden;
  }
  .app-layout {
    display: flex;
    height: 100%;
  }

  .sidebar {
    width: 250px;
    background-color: var(--sidebar-bg);
    border-right: 1px solid var(--border-color);
    display: flex;
    flex-direction: column;
    padding: 20px 0;
    box-shadow: 2px 0 10px rgba(139, 69, 19, 0.03);
    z-index: 10;
    flex-shrink:0;
  }
  .brand {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 0 25px 30px 25px;
  }
  .brand i {
    font-size: 28px;
    color: var(--accent-color);
  }
  .brand-text h2 {
    margin: 0;
    font-size: 20px;
    font-weight: 800;
    color: var(--accent-color);
  }
  .brand-text span {
    font-size: 12px;
    color: var(--text-muted);
  }
  .nav-menu {
    list-style: none;
    padding: 0;
    margin: 0;
    flex-grow: 1;
  }
  .nav-item {
    padding: 5px 20px;
  }
  .nav-link {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 12px 20px;
    text-decoration: none;
    color: var(--text-muted);
    font-weight: 600;
    border-radius: 12px;
    transition: all 0.3s ease;
  }
  .nav-link i {
    font-size: 18px;
    width: 20px;
    text-align: center;
  }
  .nav-link:hover {
    background-color: #FFF9F2;
    color: var(--accent-color);
  }

  .main-content {
    flex-grow: 1;
    padding: 30px 40px;
    overflow-y: auto;
  }

  .header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 30px;
  }
  .greeting h1 {
    margin: 0;
    font-size: 28px;
    font-weight: 800;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .greeting p {
    margin: 5px 0 0 0;
    color: var(--text-muted);
    font-weight: 600;
  }
  .header-actions {
    display: flex;
    gap: 15px;
    align-items: center;
  }
  .btn-circle {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    border: 1px solid var(--border-color);
    background: var(--card-bg);
    color: var(--text-muted);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: 0.3s;
    text-decoration: none;
  }
  .btn-circle:hover {
    color: var(--accent-color);
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
  }
</style>

<div class="app-layout">
  <aside class="sidebar">
    <div class="brand"><i class="fas fa-home"></i><div class="brand-text"><h2>My Home</h2><span>Smart Management</span></div></div>
    <ul class="nav-menu">
      <li class="nav-item"><a href="DashBoard.jsp" class="nav-link"><i class="fas fa-th-large"></i> Main menu </a></li>
      <li class="nav-item"><a href="MainController?action=SearchHome" class="nav-link"><i class="fas fa-building"></i> Home </a></li>
      <li class="nav-item"><a href="MainController?action=SearchRoom" class="nav-link"><i class="fas fa-couch"></i> Room </a></li>
      <li class="nav-item"><a href="MainController?action=SearchDevice" class="nav-link"><i class="fas fa-lightbulb"></i> Device </a></li>
      <li class="nav-item"><a href="MainController?action=SearchHomeMode" class="nav-link"><i class="fas fa-moon"></i> Modes </a></li>
      <li class="nav-item"><a href="MainController?action=SearchRule" class="nav-link"><i class="fas fa-cogs"></i> Rule </a></li>
    </ul>
  </aside>

  <main class="main-content">
    <header class="header">
      <div class="greeting">
        <%
          String userName = (String) ((UserDTO) session.getAttribute("LOGIN_USER")).getFullName();
          if (userName == null)
            userName = "bạn";
        %>
        <h1>Welcome, <%= userName%>! ⛅</h1>
        <p>Today is a beautiful day to relax.</p>
      </div>
      <div class="header-actions">
        <div class="btn-circle" title="Weather"><i class="fas fa-cloud-sun"></i></div>
        <div class="btn-circle" title="Notification"><i class="fas fa-bell"></i></div>
        <form action="MainController" style="margin:0;">
          <input type="hidden" name="action" value="Logout">
          <button type="submit" class="btn-circle" style="background: var(--accent-color); color: white;" title="Logout"><i class="fas fa-power-off"></i></button>
        </form>
      </div>
    </header>