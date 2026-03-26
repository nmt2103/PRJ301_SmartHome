package controller;

import dao.HomeDAO;
import dao.RuleDAO;
import dto.HomeDTO;
import dto.RuleDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RuleServlet", urlPatterns = {"/RuleServlet"})
public class RuleServlet extends HttpServlet {

  private static final String ERROR_PAGE = "Error.jsp";
  private static final String RULE_PAGE = "Rule.jsp";
  private static final String FORM_PAGE = "ModifyRule.jsp";

  private static final String SEARCH_ACTION = "MainController?action=SearchRule";

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

      RuleDAO ruleDAO = new RuleDAO();

      if (request.getMethod().equalsIgnoreCase("GET")) {

        if (action.equals("SearchRule")) {
          String searchName = request.getParameter("searchName");
          String filterStatus = request.getParameter("filterStatus");

          List<RuleDTO> rules = ruleDAO.getRules(searchName, filterStatus);

          if (rules == null || rules.isEmpty()) {
            rules = ruleDAO.getRules("", "");

            request.setAttribute("ERROR_MSG", "Rules not found! Showing all rules.");
          }

          request.setAttribute("RULE_LIST", rules);
          url = RULE_PAGE;

        } else if (action.equals("FormRule")) {
          RuleDTO rule = null;
          HomeDAO homeDAO = new HomeDAO();
          List<HomeDTO> homes = homeDAO.getHomes("", "1");

          if (request.getParameter("ruleId") != null) {
            String ruleId = request.getParameter("ruleId");

            rule = ruleDAO.getRuleById(ruleId);

            request.setAttribute("RULE", rule);
          }

          request.setAttribute("ACTION", rule == null ? "Add" : "Update");
          request.setAttribute("HOME_LIST", homes);
          url = FORM_PAGE;
        }
      } else {

        if (action.equals("AddRule")) {
          int homeId = Integer.parseInt(request.getParameter("homeId"));
          String name = request.getParameter("name");
          String type = request.getParameter("type");
          int priority = Integer.parseInt(request.getParameter("priority"));
          boolean status = Boolean.parseBoolean(request.getParameter("status"));

          RuleDTO addRule = new RuleDTO(homeId, name, type, priority, status);
          boolean isDuplicate = ruleDAO.checkDuplicateName(name, homeId, addRule.getId());
          if (isDuplicate) {
            request.setAttribute("ERROR_MSG",
                    "Duplicate rule in home - Home ID: " + homeId);
            url = FORM_PAGE;
            isRedirect = false;
          }

          boolean isSuccess = ruleDAO.insertRule(addRule);
          if (isSuccess) {
            url = SEARCH_ACTION;
            isRedirect = true;
          } else {
            request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
            url = FORM_PAGE;
            isRedirect = false;
          }

        } else if (action.equals("UpdateRule")) {
          int homeId = Integer.parseInt(request.getParameter("homeId"));
          int id = Integer.parseInt(request.getParameter("ruleId"));
          String name = request.getParameter("name");
          String type = request.getParameter("type");
          int priority = Integer.parseInt(request.getParameter("priority"));
          boolean status = Boolean.parseBoolean(request.getParameter("status"));

          RuleDTO updRule = new RuleDTO(name, id, type, priority, status);
          boolean isDuplicate = ruleDAO.checkDuplicateName(name, homeId, id);
          if (isDuplicate) {
            request.setAttribute("ERROR_MSG", "Duplicate rule in home - " + homeId);
            url = FORM_PAGE;
            isRedirect = false;
          }

          boolean isSuccess = ruleDAO.updateRule(updRule);
          if (isSuccess) {
            url = SEARCH_ACTION;
            isRedirect = true;
          } else {
            request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
            url = FORM_PAGE;
            isRedirect = false;
          }

        } else if (action.equals("DeleteRule")) {
          int id = Integer.parseInt(request.getParameter("ruleId"));

          boolean isSuccess = ruleDAO.deleteRule(id);
          if (isSuccess) {
            url = SEARCH_ACTION;
            isRedirect = true;
          } else {
            request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
            url = RULE_PAGE;
            isRedirect = false;
          }

        }
      }
    } catch (Exception e) {
      log("Error at RuleServlet: " + e.toString());
      request.setAttribute("ERROR_MSG", "Business error at Rule: " + e.toString());;
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
