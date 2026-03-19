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
    RuleDAO ruleDAO = new RuleDAO();

    if (request.getMethod().equalsIgnoreCase("GET")) {

      if (action == null || action.isEmpty()) {
        List<RuleDTO> rules = ruleDAO.getRules("", "");

        request.setAttribute("RULE_LIST", rules);
        request.getRequestDispatcher("Rule.jsp").forward(request, response);

      } else if (action.equalsIgnoreCase("search")) {
        String searchName = request.getParameter("searchName");
        String filterType = request.getParameter("filterType");

        List<RuleDTO> rules = ruleDAO.getRules(searchName, filterType);

        if (rules == null | rules.isEmpty()) {
          rules = ruleDAO.getRules("", "");

          request.setAttribute("ERROR_MSG", "Rules not found! Showing all rules.");
        }

        request.setAttribute("RULE_LIST", rules);
        request.getRequestDispatcher("Rule.jsp").forward(request, response);

      } else if (action.equalsIgnoreCase("add")) {
        HomeDAO homeDAO = new HomeDAO();
        List<HomeDTO> homes = homeDAO.getHomes("", "ACTIVE");

        request.setAttribute("ACTION", action);
        request.setAttribute("HOME_LIST", homes);
        request.getRequestDispatcher("ModifyRule.jsp").forward(request, response);

      } else if (action.equalsIgnoreCase("update")) {
        String ruleId = request.getParameter("ruleId");

        RuleDTO rule = ruleDAO.getRuleById(ruleId);

        request.setAttribute("ACTION", action);
        request.setAttribute("RULE", rule);
        request.getRequestDispatcher("ModifyRule.jsp").forward(request, response);

      }
    } else {

      if (action.equalsIgnoreCase("add")) {
        int homeId = Integer.parseInt(request.getParameter("homeId"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        int priority = Integer.parseInt(request.getParameter("priority"));
        int active = Integer.parseInt(request.getParameter("active"));

        RuleDTO addRule = new RuleDTO(homeId, name, type, priority, active);

        boolean isDuplicate = ruleDAO.checkDuplicateName(name, homeId, addRule.getId());
        if (isDuplicate) {
          request.setAttribute("ERROR_MSG", "Duplicate rule in home - Home ID: " + homeId);
          request.getRequestDispatcher("ModifyRule.jsp").forward(request, response);
        }

        boolean isSuccess = ruleDAO.insertRule(addRule);
        if (isSuccess) {
          request.setAttribute("SUCCESS_MSG", "Rule added successfully.");
          response.sendRedirect("RuleServlet");
        } else {
          request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
          request.getRequestDispatcher("ModifyRule.jsp").forward(request, response);
        }

      } else if (action.equalsIgnoreCase("update")) {
        int homeId = Integer.parseInt(request.getParameter("homeId"));
        int id = Integer.parseInt(request.getParameter("ruleId"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        int priority = Integer.parseInt(request.getParameter("priority"));
        int active = Integer.parseInt(request.getParameter("active"));

        RuleDTO updRule = new RuleDTO(name, id, type, priority, active);
        boolean isDuplicate = ruleDAO.checkDuplicateName(name, homeId, id);
        if (isDuplicate) {
          request.setAttribute("ERROR_MSG", "Duplicate rule in home - " + homeId);
          request.getRequestDispatcher("ModifyRule.jsp").forward(request, response);
        }

        boolean isSuccess = ruleDAO.updateRule(updRule);
        if (isSuccess) {
          request.setAttribute("SUCCESS_MSG", "Rule updated successfully.");
          response.sendRedirect("RuleServlet");
        } else {
          request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
          request.getRequestDispatcher("ModifyRule.jsp").forward(request, response);
        }

      } else if (action.equalsIgnoreCase("delete")) {
        int id = Integer.parseInt(request.getParameter("ruleId"));

        boolean isSuccess = ruleDAO.deleteRule(id);
        if (isSuccess) {
          request.setAttribute("SUCCESS_MSG", "Rule deleted successfully.");
          response.sendRedirect("RuleServlet");
        } else {
          request.setAttribute("ERROR_MSG", "Error! Something wrong happened.");
          request.getRequestDispatcher("Rule.jsp").forward(request, response);
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
