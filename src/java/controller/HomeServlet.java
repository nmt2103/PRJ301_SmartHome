package controller;

import dao.HomeDAO;
import dto.HomeDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeServlet", urlPatterns = {"/HomeServlet"})
public class HomeServlet extends HttpServlet {

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

    String action = request.getParameter("action");
    HomeDAO homeDAO = new HomeDAO();

    if (request.getMethod().equalsIgnoreCase("GET")) {

      if (action == null || action.isEmpty()) {
        List<HomeDTO> homes = homeDAO.getHomes("", "");

        request.setAttribute("HOME_LIST", homes);
        request.getRequestDispatcher("Home.jsp").forward(request, response);

      } else if (action.equalsIgnoreCase("search")) {
        String searchName = request.getParameter("searchName");
        String filterStatus = request.getParameter("filterStatus");

        List<HomeDTO> homes = homeDAO.getHomes(searchName, filterStatus);

        if (homes == null || homes.isEmpty()) {
          homes = homeDAO.getHomes("", "");

          request.setAttribute("ERROR_MSG", "Home not found! Showing all homes.");
        }

        request.setAttribute("HOME_LIST", homes);
        request.getRequestDispatcher("Home.jsp").forward(request, response);

      } else if (action.equalsIgnoreCase("add")) {
        request.setAttribute("ACTION", action);
        request.getRequestDispatcher("ModifyHome.jsp").forward(request, response);

      } else if (action.equalsIgnoreCase("update")) {
        String homeId = request.getParameter("homeId");

        HomeDTO home = homeDAO.getHomeById(homeId);

        request.setAttribute("ACTION", action);
        request.setAttribute("HOME", home);
        request.getRequestDispatcher("ModifyHome.jsp").forward(request, response);

      }
    } else {

      if (action.equalsIgnoreCase("add")) {
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String status = request.getParameter("status").toUpperCase();

        HomeDTO addHome = new HomeDTO(code, name, address, status);
        boolean isSuccess = homeDAO.insertHome(addHome);
        if (isSuccess) {
          request.setAttribute("SUCCESS_MSG", "Home added successfully.");
          response.sendRedirect("HomeServlet");
        } else {
          request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
          request.getRequestDispatcher("ModifyHome.jsp").forward(request, response);
        }

      } else if (action.equalsIgnoreCase("update")) {
        int id = Integer.parseInt(request.getParameter("homeId"));
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String status = request.getParameter("status").toUpperCase();

        HomeDTO updHome = new HomeDTO(id, code, name, address, status);
        boolean isSuccess = homeDAO.updateHome(updHome);
        if (isSuccess) {
          request.setAttribute("SUCCESS_MSG", "Home updated successfully.");
          response.sendRedirect("HomeServlet");
        } else {
          request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
          request.getRequestDispatcher("ModifyHome.jsp").forward(request, response);
        }

      } else if (action.equalsIgnoreCase("delete")) {
        int id = Integer.parseInt(request.getParameter("homeId"));

        boolean isSuccess = homeDAO.deleteHome(id);
        if (isSuccess) {
          request.setAttribute("SUCCESS_MSG", "Home deleted successfully.");
          response.sendRedirect("HomeServlet");
        } else {
          request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
          request.getRequestDispatcher("Home.jsp").forward(request, response);
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
