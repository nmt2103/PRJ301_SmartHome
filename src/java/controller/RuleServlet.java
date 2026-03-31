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

    // =========================================================
    // LUỒNG GET: CHUYÊN HIỂN THỊ GIAO DIỆN, XÓA & TOGGLE
    // =========================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "SearchRule";
        }

        RuleDAO ruleDAO = new RuleDAO();

        try {
            switch (action) {
                case "SearchRule":
                    String searchName = request.getParameter("searchName");
                    String filterStatus = request.getParameter("filterStatus");

                    List<RuleDTO> rules = ruleDAO.getRules(searchName, filterStatus);

                    if (rules == null || rules.isEmpty()) {
                        rules = ruleDAO.getRules("", "");
                        request.setAttribute("ERROR_MSG", "Rules not found! Showing all rules.");
                    }

                    request.setAttribute("RULE_LIST", rules);
                    request.getRequestDispatcher(RULE_PAGE).forward(request, response);
                    break;

                case "FormRule":
                    RuleDTO rule = null;
                    HomeDAO homeDAO = new HomeDAO();
                    List<HomeDTO> homes = homeDAO.getHomes("", "1"); // Lấy danh sách nhà đang Active

                    String ruleIdStr = request.getParameter("ruleId");
                    if (ruleIdStr != null && !ruleIdStr.isEmpty()) {
                        rule = ruleDAO.getRuleById(ruleIdStr);
                        request.setAttribute("RULE", rule);
                    }

                    request.setAttribute("ACTION", rule == null ? "Add" : "Update");
                    request.setAttribute("HOME_LIST", homes);
                    request.getRequestDispatcher(FORM_PAGE).forward(request, response);
                    break;

                case "DeleteRule":
                    int delId = Integer.parseInt(request.getParameter("ruleId"));
                    boolean isSuccess = ruleDAO.deleteRule(delId);

                    if (isSuccess) {
                        response.sendRedirect(SEARCH_ACTION);
                    } else {
                        request.setAttribute("ERROR_MSG", "Error! Cannot delete this rule.");
                        request.getRequestDispatcher(RULE_PAGE).forward(request, response);
                    }
                    break;

                // ---> ĐÃ THÊM CHỨC NĂNG TOGGLE RULE Ở ĐÂY <---
                case "ToggleRule":
                    int toggleId = Integer.parseInt(request.getParameter("ruleId"));
                    boolean currentStatus = Boolean.parseBoolean(request.getParameter("currentStatus"));

                    // Gọi hàm đổi trạng thái (đảo ngược currentStatus bằng dấu !)
                    ruleDAO.toggleRuleStatus(toggleId, !currentStatus);

                    // Xong thì load lại trang Search
                    response.sendRedirect(SEARCH_ACTION);
                    break;

                default:
                    request.getRequestDispatcher(ERROR_PAGE).forward(request, response);
            }
        } catch (Exception e) {
            log("Error at RuleServlet doGet: " + e.toString());
            request.setAttribute("ERROR_MSG", "System error: " + e.toString());
            request.getRequestDispatcher(ERROR_PAGE).forward(request, response);
        }
    }

    // =========================================================
    // LUỒNG POST: CHUYÊN XỬ LÝ LƯU (THÊM / SỬA) TỪ FORM
    // =========================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        RuleDAO ruleDAO = new RuleDAO();
        HomeDAO homeDAO = new HomeDAO();

        try {
            switch (action) {
                case "AddRule": {
                    int homeId = Integer.parseInt(request.getParameter("homeId"));
                    String name = request.getParameter("name");
                    String type = request.getParameter("type");
                    int priority = Integer.parseInt(request.getParameter("priority"));
                    boolean status = Boolean.parseBoolean(request.getParameter("status"));

                    RuleDTO addRule = new RuleDTO(homeId, name, type, priority, status);
                    boolean isDuplicate = ruleDAO.checkDuplicateName(name, homeId, addRule.getId());

                    if (isDuplicate) {
                        request.setAttribute("ERROR_MSG", "Duplicate rule in home - Home ID: " + homeId);
                        request.setAttribute("HOME_LIST", homeDAO.getHomes("", "1"));
                        request.setAttribute("ACTION", "Add");
                        request.getRequestDispatcher(FORM_PAGE).forward(request, response);
                        return;
                    }

                    ruleDAO.insertRule(addRule);
                    response.sendRedirect(SEARCH_ACTION);
                    break;
                }

                case "UpdateRule": {
                    int homeId = Integer.parseInt(request.getParameter("homeId"));
                    int id = Integer.parseInt(request.getParameter("ruleId"));
                    String name = request.getParameter("name");
                    String type = request.getParameter("type");
                    int priority = Integer.parseInt(request.getParameter("priority"));
                    boolean status = Boolean.parseBoolean(request.getParameter("status"));

                    RuleDTO updRule = new RuleDTO(name, id, type, priority, status);
                    boolean isDuplicate = ruleDAO.checkDuplicateName(name, homeId, id);

                    if (isDuplicate) {
                        request.setAttribute("ERROR_MSG", "Duplicate rule in home - Home ID: " + homeId);
                        request.setAttribute("HOME_LIST", homeDAO.getHomes("", "1"));
                        request.setAttribute("RULE", updRule);
                        request.setAttribute("ACTION", "Update");
                        request.getRequestDispatcher(FORM_PAGE).forward(request, response);
                        return;
                    }

                    ruleDAO.updateRule(updRule);
                    response.sendRedirect(SEARCH_ACTION);
                    break;
                }
            }
        } catch (Exception e) {
            log("Error at RuleServlet doPost: " + e.toString());
            request.setAttribute("ERROR_MSG", "System error: " + e.toString());
            request.getRequestDispatcher(ERROR_PAGE).forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Rule Management Servlet";
    }
}
