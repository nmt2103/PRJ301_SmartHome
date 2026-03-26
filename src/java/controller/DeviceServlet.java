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
            action = "SearchDevice";
        }

        DeviceDAO deviceDao = new DeviceDAO();
        RoomDAO roomDao = new RoomDAO();
        try {
            switch (action) {
                case "SearchDevice":
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

                case "DeviceForm":
                    String idStr = request.getParameter("id");
                    if (idStr != null && !idStr.isEmpty()) {
                        int editId = Integer.parseInt(idStr);
                        DeviceDTO deviceToEdit = deviceDao.getDeviceById(editId);
                        request.setAttribute("DEVICE", deviceToEdit);
                    }

                    request.setAttribute("ROOM_LIST", roomDao.getRooms("", ""));
                    request.getRequestDispatcher("DeviceForm.jsp").forward(request, response);
                    break;
                case "DeleteDevice":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    deviceDao.deleteDevice(deleteId);
                    response.sendRedirect("DeviceServlet?action=SearchDevice");
                    break;
                case "ToggleDevice":
                    int toggleId = Integer.parseInt(request.getParameter("id"));
                    boolean currentStatus = Boolean.parseBoolean(request.getParameter("currentStatus"));

                    deviceDao.toggleDeviceStatus(toggleId, !currentStatus);
                    response.sendRedirect("MainController?action=SearchDevice");
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
            String type = request.getParameter("type");
            String serialNo = request.getParameter("serialNo");
            String vendor = request.getParameter("vendor");
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String statusParam = request.getParameter("status");
            boolean isActive = "Active".equalsIgnoreCase(statusParam) || "1".equals(statusParam);

            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            RoomDTO room = new RoomDTO();
            room.setId(roomId);

            if ("AddDevice".equalsIgnoreCase(action)) {
                DeviceDTO newDevice = new DeviceDTO(0, type, serialNo, vendor, isActive, currentTimestamp, room);
                deviceDao.createDevice(newDevice);

            } else if ("UpdateDevice".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                DeviceDTO updateDevice = new DeviceDTO(id, type, serialNo, vendor, isActive, currentTimestamp, room);
                deviceDao.updateDevice(updateDevice);
            }

            response.sendRedirect("DeviceServlet?action=SearchDevice");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("DeviceServlet?action=SearchDevice");
        }
    }
}
