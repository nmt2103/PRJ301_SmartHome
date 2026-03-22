package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

  private static final String LOGIN_PAGE = "Login.jsp";
  private static final String ERROR_PAGE = "Error.jsp";

  private static final String LOGIN_SERVLET = "LoginServlet";
  private static final String LOGOUT_SERVLET = "LogoutServlet";
  private static final String HOME_SERVLET = "HomeServlet";
  private static final String ROOM_SERVLET = "RoomServlet";
  private static final String RULE_SERVLET = "RuleServlet";

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
    try {
      String action = request.getParameter("action");

      if (action == null) {
        url = LOGIN_PAGE;

      } else {
        switch (action) {
          case "Login":
            url = LOGIN_SERVLET;
            break;

          case "Logout":
            url = LOGOUT_SERVLET;
            break;

          case "AddHome":
          case "SearchHome":
          case "UpdateHome":
          case "DeleteHome":
          case "FormHome":
            url = HOME_SERVLET;
            break;

          case "AddRoom":
          case "SearchRoom":
          case "UpdateRoom":
          case "DeleteRoom":
          case "FormRoom":
            url = ROOM_SERVLET;
            break;

          case "AddRule":
          case "SearchRule":
          case "UpdateRule":
          case "DeleteRule":
          case "FormRule":
            url = RULE_SERVLET;
            break;

          default:
            request.setAttribute("ERROR_MSG", "Invalid action.");
            url = ERROR_PAGE;
            break;
        }
      }
    } catch (Exception e) {
      log("Error at MainController: " + e.toString());
      request.setAttribute("ERROR_MSG", "System error:" + e.toString());
    } finally {
      request.getRequestDispatcher(url).forward(request, response);
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
    return "Main Controller of Smart Home";
  }// </editor-fold>

}
