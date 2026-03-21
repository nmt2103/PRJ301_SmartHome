<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="Menu.jsp" %>

<style>
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    .stat-card {
        background: var(--card-bg);
        padding: 20px;
        border-radius: 20px;
        box-shadow: 0 8px 20px rgba(139, 69, 19, 0.04);
        border: 1px solid rgba(255,255,255,0.8);
    }
    .stat-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }
    .stat-icon {
        width: 40px;
        height: 40px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
    }
    .stat-badge {
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 700;
    }
    .stat-value {
        font-size: 32px;
        font-weight: 800;
        margin: 0;
    }
    .stat-label {
        color: var(--text-muted);
        font-size: 14px;
        font-weight: 600;
        margin: 5px 0 0 0;
    }
    .section-title {
        font-size: 20px;
        font-weight: 800;
        margin-bottom: 15px;
    }
    .rooms-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
    }
    .room-card {
        background: var(--card-bg);
        padding: 20px;
        border-radius: 20px;
        box-shadow: 0 8px 20px rgba(139, 69, 19, 0.04);
        transition: 0.3s;
        cursor: pointer;
    }
    .room-card:hover {
        transform: translateY(-3px);
        border-color: var(--accent-color);
    }
    .room-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    .room-icon {
        font-size: 24px;
        color: #6C4F3D;
    }
    .room-name {
        font-size: 18px;
        font-weight: 700;
        margin: 0;
    }
    .room-info {
        color: var(--text-muted);
        font-size: 13px;
        font-weight: 600;
        margin: 5px 0 0 0;
    }
    .room-bottom {
        display: flex;
        justify-content: space-between;
        margin-top: 15px;
        font-weight: 700;
        color: var(--accent-color);
    }
</style>

<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-header"><div class="stat-icon" style="background: #FFF4E6; color: var(--accent-color);"><i class="fas fa-microchip"></i></div><div class="stat-badge" style="background: #E8F5E9; color: var(--active-green);">• Hoạt động</div></div>
        <h3 class="stat-value">12</h3><p class="stat-label">Thiết bị đang bật</p>
    </div>
    <div class="stat-card">
        <div class="stat-header"><div class="stat-icon" style="color: #E76F51; background: #FFEDEA;"><i class="fas fa-temperature-high"></i></div><div class="stat-badge" style="background: #FFEDEA; color: #E76F51;">Ổn định</div></div>
        <h3 class="stat-value">28°C</h3><p class="stat-label">Nhiệt độ phòng khách</p>
    </div>
    <div class="stat-card">
        <div class="stat-header"><div class="stat-icon" style="color: #457B9D; background: #E1F0FA;"><i class="fas fa-wind"></i></div><div class="stat-badge" style="background: #E1F0FA; color: #457B9D;">Trong lành</div></div>
        <h3 class="stat-value">60%</h3><p class="stat-label">Chất lượng không khí</p>
    </div>
    <div class="stat-card">
        <div class="stat-header"><div class="stat-icon" style="color: #6C4F3D; background: #F0E6D2;"><i class="fas fa-magic"></i></div></div>
        <h3 class="stat-value" style="font-size: 24px; padding-top: 8px;">Thư giãn</h3><p class="stat-label">Chế độ đang kích hoạt</p>
    </div>
</div>

<h2 class="section-title">Phòng trong nhà</h2>
<div class="rooms-grid">
    <div class="room-card"><div class="room-header"><i class="fas fa-tv room-icon"></i><span class="stat-badge" style="background: #E8F5E9; color: var(--active-green);">• Bật</span></div><h3 class="room-name">Phòng khách</h3><p class="room-info">4 thiết bị</p><div class="room-bottom"><span>Mát mẻ</span> <span>24°C</span></div></div>
    <div class="room-card"><div class="room-header"><i class="fas fa-utensils room-icon"></i><span class="stat-badge" style="background: #E8F5E9; color: var(--active-green);">• Bật</span></div><h3 class="room-name">Bếp</h3><p class="room-info">3 thiết bị</p><div class="room-bottom"><span>Đang nấu</span> <span>26°C</span></div></div>
    <div class="room-card"><div class="room-header"><i class="fas fa-bed room-icon"></i><span class="stat-badge" style="background: #F0E6D2; color: var(--text-muted)">• Tắt</span></div><h3 class="room-name">Phòng ngủ</h3><p class="room-info">2 thiết bị</p><div class="room-bottom" style="color: var(--text-muted)"><span>Chế độ ngủ</span> <span>23°C</span></div></div>
</div>

</main>
</div>
</body>
</html>