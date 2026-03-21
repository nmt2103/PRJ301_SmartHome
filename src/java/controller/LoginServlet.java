package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

  private static final String LOGIN_PAGE = "Login.jsp";
  private static final String ADMIN_PAGE = "MainController?action=DashboardAdmin";
  private static final String OWNER_PAGE = "MainController?action=DashboardOwner";
  private static final String TECHNICIAN_PAGE = "MainController?action=DashboardTECH";
  private static final String VIEWER_PAGE = "MainController?action=DashboardViewer";

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

    String url = LOGIN_PAGE;
    boolean isRedirect = false;

    try {

      if (request.getMethod().equalsIgnoreCase("GET")) {
        request.setAttribute("MSG", "Logged out.");
        request.getRequestDispatcher("Login.jsp").forward(request, response);

      } else {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        UserDTO loginUser = userDAO.checkLogin(user, pass);

        if (loginUser != null) {
          HttpSession session = request.getSession();
          session.setAttribute("LOGIN_USER", loginUser);

          String role = loginUser.getRole();
          switch (role) {
            case "Admin":
              url = ADMIN_PAGE;
              isRedirect = true;
              break;

            case "Home Owner":
              url = OWNER_PAGE;
              isRedirect = true;
              break;

            case "Technician":
              url = TECHNICIAN_PAGE;
              isRedirect = true;
              break;

            case "Viewer":
              url = VIEWER_PAGE;
              isRedirect = true;
            default:
              request.setAttribute("ERROR_MSG", "Invalid user role!");
              isRedirect = false;
          }
        } else {
          request.setAttribute("ERROR_MSG", "Invalid username or password.");
          isRedirect = false;
        }

      }
    } catch (Exception e) {
      log("Error at LoginController:" + e.toString());
      request.setAttribute("ERROR_MSG", "System error while login process.");
      isRedirect = false;
    } finally {
      if (isRedirect) {
        response.sendRedirect(url);
      } else {
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
        return "Short description";
    }// </editor-fold>

}
