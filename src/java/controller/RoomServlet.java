package controller;

import dao.HomeDAO;
import dao.RoomDAO;
import dto.HomeDTO;
import dto.RoomDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RoomServlet", urlPatterns = {"/RoomServlet"})
public class RoomServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        RoomDAO roomDAO = new RoomDAO();

        if (request.getMethod().equalsIgnoreCase("GET")) {

            if (action == null || action.isEmpty()) {
                List<RoomDTO> rooms = roomDAO.getRooms("", "");

                request.setAttribute("ROOM_LIST", rooms);
                request.getRequestDispatcher("Room.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("search")) {
                String searchName = request.getParameter("searchName");
                String filterStatus = request.getParameter("filterStatus");

                List<RoomDTO> rooms = roomDAO.getRooms(searchName, filterStatus);

                if (rooms == null | rooms.isEmpty()) {
                    rooms = roomDAO.getRooms("", "");

                    request.setAttribute("ERROR_MSG", "Room not found! Showing all rooms.");
                }

                request.setAttribute("ROOM_LIST", rooms);
                request.getRequestDispatcher("Room.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("add")) {
                HomeDAO homeDAO = new HomeDAO();
                List<HomeDTO> homes = homeDAO.getHomes("", "ACTIVE");

                request.setAttribute("ACTION", action);
                request.setAttribute("HOME_LIST", homes);
                request.getRequestDispatcher("ModifyRoom.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("update")) {
                String roomId = request.getParameter("roomId");

                RoomDTO room = roomDAO.getRoomById(roomId);

                request.setAttribute("ACTION", action);
                request.setAttribute("ROOM", room);
                request.getRequestDispatcher("ModifyRoom.jsp").forward(request, response);

            }
        } else {

            if (action.equalsIgnoreCase("add")) {
                int homeId = Integer.parseInt(request.getParameter("homeId"));
                String name = request.getParameter("name");
                int floor = Integer.parseInt(request.getParameter("floor"));
                String type = request.getParameter("type");
                String status = request.getParameter("status").toUpperCase();

                RoomDTO addRoom = new RoomDTO(homeId, floor, name, type, status);
                boolean isSucces = roomDAO.insertRoom(addRoom);
                if (isSucces) {
                    request.setAttribute("SUCCESS_MSG", "Room added successfully.");
                    response.sendRedirect("RoomServlet");
                } else {
                    request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
                    request.getRequestDispatcher("ModifyRoom.jsp").forward(request, response);
                }

            } else if (action.equalsIgnoreCase("update")) {
                int id = Integer.parseInt(request.getParameter("roomId"));
                String name = request.getParameter("name");
                int floor = Integer.parseInt(request.getParameter("floor"));
                String type = request.getParameter("type");
                String status = request.getParameter("status").toUpperCase();

                RoomDTO updRoom = new RoomDTO(id, name, floor, type, status);
                boolean isSuccess = roomDAO.updateRoom(updRoom);
                if (isSuccess) {
                    request.setAttribute("SUCCESS_MSG", "Room updated successfully.");
                    response.sendRedirect("RoomServlet");
                } else {
                    request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
                    request.getRequestDispatcher("ModifyRoom.jsp").forward(request, response);
                }

            } else if (action.equalsIgnoreCase("delete")) {
                int id = Integer.parseInt(request.getParameter("roomId"));

                boolean isSuccess = roomDAO.deleteRoom(id);
                if (isSuccess) {
                    request.setAttribute("SUCCESS_MSG", "Room deleted successfully.");
                    response.sendRedirect("RoomServlet");
                } else {
                    request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
                    request.getRequestDispatcher("Room.jsp").forward(request, response);
                }

            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
