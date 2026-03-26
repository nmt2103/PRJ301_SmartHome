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

  private static final String ERROR_PAGE = "Error.jsp";
  private static final String ROOM_PAGE = "Room.jsp";
  private static final String FORM_PAGE = "ModifyRoom.jsp";

  private static final String SEARCH_ACTION = "MainController?action=SearchRoom";

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");

    String url = ERROR_PAGE;
    boolean isRedirect = false;

    try {
      String action = request.getParameter("action");

      RoomDAO roomDAO = new RoomDAO();

      if (request.getMethod().equalsIgnoreCase("GET")) {

        if (action.equals("SearchRoom")) {
          String searchName = request.getParameter("searchName");
          String filterStatus = request.getParameter("filterStatus");

          List<RoomDTO> rooms = roomDAO.getRooms(searchName, filterStatus);

          if (rooms == null || rooms.isEmpty()) {
            rooms = roomDAO.getRooms("", "");

            request.setAttribute("ERROR_MSG", "Room not found! Showing all rooms.");
          }

          request.setAttribute("ROOM_LIST", rooms);
          url = ROOM_PAGE;

        } else if (action.equals("FormRoom")) {
          RoomDTO room = null;
          HomeDAO homeDAO = new HomeDAO();
          List<HomeDTO> homes = homeDAO.getHomes("", "1");

          if (request.getParameter("roomId") != null) {
            String roomId = request.getParameter("roomId");

            room = roomDAO.getRoomById(roomId);

            request.setAttribute("ROOM", room);
          }

          request.setAttribute("ACTION", room == null ? "Add" : "Update");
          request.setAttribute("HOME_LIST", homes);
          url = FORM_PAGE;
        }
      } else {

        if (action.equals("AddRoom")) {
          int homeId = Integer.parseInt(request.getParameter("homeId"));
          String name = request.getParameter("name");
          int floor = Integer.parseInt(request.getParameter("floor"));
          String type = request.getParameter("type");
          boolean status = Boolean.parseBoolean(request.getParameter("status"));

          RoomDTO addRoom = new RoomDTO(homeId, floor, name, type, status);
          boolean isSucces = roomDAO.insertRoom(addRoom);
          if (isSucces) {
            url = SEARCH_ACTION;
            isRedirect = true;
          } else {
            request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
            url = FORM_PAGE;
            isRedirect = false;
          }

        } else if (action.equals("UpdateRoom")) {
          int id = Integer.parseInt(request.getParameter("roomId"));
          String name = request.getParameter("name");
          int floor = Integer.parseInt(request.getParameter("floor"));
          String type = request.getParameter("type");
          boolean status = Boolean.parseBoolean(request.getParameter("status"));

          RoomDTO updRoom = new RoomDTO(id, name, floor, type, status);
          boolean isSuccess = roomDAO.updateRoom(updRoom);
          if (isSuccess) {
            url = SEARCH_ACTION;
            isRedirect = true;
          } else {
            request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
            url = FORM_PAGE;
            isRedirect = false;
          }

        } else if (action.equals("DeleteRoom")) {
          int id = Integer.parseInt(request.getParameter("roomId"));

          boolean isSuccess = roomDAO.deleteRoom(id);
          if (isSuccess) {
            url = SEARCH_ACTION;
            isRedirect = true;
          } else {
            request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
            url = ROOM_PAGE;
            isRedirect = false;
          }

        }
      }
    } catch (Exception e) {
      log("Error at RoomServlet: " + e.toString());
      request.setAttribute("ERROR_MSG", "Business error at Room: " + e.toString());;
      isRedirect = false;
    } finally {
      if (isRedirect) {
        response.sendRedirect(url);
      } else {
        request.getRequestDispatcher(url).forward(request, response);
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
