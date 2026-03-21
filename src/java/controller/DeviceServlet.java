/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DeviceDAO;
import dao.RoomDAO;
import dto.DeviceDTO;
import dto.RoomDTO;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
@WebServlet(name = "DeviceServlet", urlPatterns = {"/DeviceServlet"})
public class DeviceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "search";
        }
        action = action.toLowerCase();

        DeviceDAO deviceDao = new DeviceDAO();
        RoomDAO roomDao = new RoomDAO();
        try {
            switch (action) {
                case "search":
                    String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
                    String roomIdStr = request.getParameter("roomId");
                    String status = request.getParameter("status") != null ? request.getParameter("status") : "";

                    int roomId = 0;
                    if (roomIdStr != null && !roomIdStr.isEmpty()) {
                        roomId = Integer.parseInt(roomIdStr);
                    }

                    List<DeviceDTO> deviceList = deviceDao.searchDevices(keyword, roomId, status);
                    List<RoomDTO> roomList = roomDao.getRooms("", "");

                    request.setAttribute("DEVICE_LIST", deviceList);
                    request.setAttribute("ROOM_LIST", roomList);
                    request.getRequestDispatcher("DeviceList.jsp").forward(request, response);
                    break;

                case "create":
                    request.setAttribute("ROOM_LIST", roomDao.getRooms("", ""));
                    request.getRequestDispatcher("DeviceForm.jsp").forward(request, response);
                    break;

                case "edit":
                    int editId = Integer.parseInt(request.getParameter("id"));
                    DeviceDTO deviceToEdit = deviceDao.getDeviceById(editId);

                    request.setAttribute("DEVICE", deviceToEdit);
                    request.setAttribute("ROOM_LIST", roomDao.getRooms("", ""));
                    request.getRequestDispatcher("DeviceForm.jsp").forward(request, response);
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    deviceDao.deleteDevice(deleteId);
                    response.sendRedirect("DeviceServlet?action=search");
                    break;
                case "toggle":
                    int toggleId = Integer.parseInt(request.getParameter("id"));
                    String currentStatus = request.getParameter("status");

                    String newStatus = "Active".equalsIgnoreCase(currentStatus) ? "Inactive" : "Active";

                    deviceDao.toggleDeviceStatus(toggleId, newStatus);
                    response.sendRedirect("DeviceServlet?action=search");
                    break;

            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("System error: ", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        DeviceDAO deviceDao = new DeviceDAO();

        try {
            // --- XỬ LÝ RIÊNG CHO CHỨC NĂNG TOGGLE ---
            if ("toggle".equalsIgnoreCase(action)) {
                int toggleId = Integer.parseInt(request.getParameter("id"));
                // Hứng đúng tên biến currentStatus từ file JSP gửi lên
                String currentStatus = request.getParameter("currentStatus");

                // Đảo trạng thái
                String newStatus = "Active".equalsIgnoreCase(currentStatus) ? "Inactive" : "Active";

                deviceDao.toggleDeviceStatus(toggleId, newStatus);
                response.sendRedirect("DeviceServlet?action=search");
                return; // Kết thúc luôn tại đây, không chạy xuống phần dưới nữa
            }
            // ----------------------------------------

            // 1. Lấy thông tin từ Form (Dành cho Insert/Update)
            String type = request.getParameter("type");
            String serialNo = request.getParameter("serialNo");
            String vendor = request.getParameter("vendor");
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String status = request.getParameter("status");

            if (status == null) {
                status = "";
            }

            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            RoomDTO room = new RoomDTO();
            room.setId(roomId);

            if ("insert".equalsIgnoreCase(action)) {
                DeviceDTO newDevice = new DeviceDTO(0, type, serialNo, vendor, status, currentTimestamp, room);
                deviceDao.createDevice(newDevice);

            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                DeviceDTO updateDevice = new DeviceDTO(id, type, serialNo, vendor, status, currentTimestamp, room);
                deviceDao.updateDevice(updateDevice);
            }

            // 3. Cập nhật xong thì quay về trang danh sách
            response.sendRedirect("DeviceServlet?action=search");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("DeviceServlet?action=search");
        }
    }
}
