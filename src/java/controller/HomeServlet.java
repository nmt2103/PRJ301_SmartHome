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

  private static final String ERROR_PAGE = "Error.jsp";
  private static final String HOME_PAGE = "Home.jsp";
  private static final String FORM_PAGE = "ModifyHome.jsp";

  private static final String SEARCH_ACTION = "MainController?action=SearchHome";

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

      HomeDAO homeDAO = new HomeDAO();

      if (request.getMethod().equalsIgnoreCase("GET")) {

        if (action.equals("SearchHome")) {
          String searchName = request.getParameter("searchName");
          String filterStatus = request.getParameter("filterStatus");

          List<HomeDTO> homes = homeDAO.getHomes(searchName, filterStatus);

          if (homes == null || homes.isEmpty()) {
            homes = homeDAO.getHomes("", "");

            request.setAttribute("ERROR_MSG", "Home not found! Showing all homes.");
          }

          request.setAttribute("HOME_LIST", homes);
          url = HOME_PAGE;

        } else if (action.equals("FormHome")) {
          HomeDTO home = null;

          if (request.getParameter("homeId") != null) {
            String homeId = request.getParameter("homeId");

            home = homeDAO.getHomeById(homeId);

            request.setAttribute("HOME", home);
          }

          request.setAttribute("ACTION", home == null ? "Add" : "Update");
          url = FORM_PAGE;

        }
      } else {

        if (action.equals("AddHome")) {
          String code = request.getParameter("code");
          String name = request.getParameter("name");
          String address = request.getParameter("address");
          boolean status = Boolean.parseBoolean(request.getParameter("status"));

          HomeDTO addHome = new HomeDTO(code, name, address, status);
          boolean isSuccess = homeDAO.insertHome(addHome);
          if (isSuccess) {
            url = SEARCH_ACTION;
            isRedirect = true;
          } else {
            request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
            url = FORM_PAGE;
            isRedirect = false;
          }

        } else if (action.equals("UpdateHome")) {
          int id = Integer.parseInt(request.getParameter("homeId"));
          String code = request.getParameter("code");
          String name = request.getParameter("name");
          String address = request.getParameter("address");
          boolean status = Boolean.parseBoolean(request.getParameter("status"));

          HomeDTO updHome = new HomeDTO(id, code, name, address, status);
          boolean isSuccess = homeDAO.updateHome(updHome);
          if (isSuccess) {
            url = SEARCH_ACTION;
            isRedirect = true;
          } else {
            request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
            url = FORM_PAGE;
            isRedirect = false;
          }

        } else if (action.equals("DeleteHome")) {
          int id = Integer.parseInt(request.getParameter("homeId"));

          boolean isSuccess = homeDAO.deleteHome(id);
          if (isSuccess) {
            url = SEARCH_ACTION;
            isRedirect = true;
          } else {
            request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
            url = HOME_PAGE;
            isRedirect = false;
          }
        }
      }
    } catch (Exception e) {
      log("Error at HomeServlet: " + e.toString());
      request.setAttribute("ERROR_MSG", "Bussiness error at Home: " + e.toString());
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
