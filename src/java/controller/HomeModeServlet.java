package controller;

import dao.HomeDAO;
import dao.HomeModeDAO;
import dto.HomeDTO;
import dto.HomeModeDTO;
import java.io.IOException;
import java.sql.Time;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeModeServlet", urlPatterns = {"/HomeModeServlet"})
public class HomeModeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "SearchHomeMode";
        }

        HomeModeDAO modeDao = new HomeModeDAO();
        HomeDAO homeDao = new HomeDAO();

        try {
            switch (action) {
                case "SearchHomeMode":
                    String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
                    String status = request.getParameter("activeStatus") != null ? request.getParameter("activeStatus") : "";
                    String homeIdStr = request.getParameter("homeId");
                    int homeId = 0;
                    if (homeIdStr != null && !homeIdStr.trim().isEmpty()) {
                        homeId = Integer.parseInt(homeIdStr);
                    }

                    List<HomeModeDTO> modeList = modeDao.searchHomeMode(keyword, homeId, status);

                    List<HomeDTO> homeList = homeDao.getHomes("", "");

                    request.setAttribute("MODE_LIST", modeList);
                    request.setAttribute("HOME_LIST", homeList);
                    request.getRequestDispatcher("HomeModeList.jsp").forward(request, response);
                    break;

                case "HomeModeForm":
                    String idStr = request.getParameter("id");
                    if (idStr != null && !idStr.isEmpty()) {
                        int editId = Integer.parseInt(idStr);
                        HomeModeDTO modeToEdit = modeDao.getHomeModeByID(editId);
                        request.setAttribute("MODE", modeToEdit);
                    }
                    request.setAttribute("HOME_LIST", homeDao.getHomes("", ""));
                    request.getRequestDispatcher("HomeModeForm.jsp").forward(request, response);
                    break;

                case "DeleteHomeMode":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    modeDao.deleteHomeMode(deleteId);
                    response.sendRedirect("MainController?action=SearchHomeMode");
                    break;

                case "ToggleHomeMode":
                    int toggleId = Integer.parseInt(request.getParameter("id"));
                    boolean currentStatus = Boolean.parseBoolean(request.getParameter("currentStatus"));

                    modeDao.toggleHomeModeStatus(toggleId, !currentStatus);
                    response.sendRedirect("MainController?action=SearchHomeMode");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi hệ thống ở HomeModeServlet luồng GET: ", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        HomeModeDAO modeDao = new HomeModeDAO();

        try {
            String name = request.getParameter("name");
            int homeId = Integer.parseInt(request.getParameter("homeId"));
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

            String timeFromInput = request.getParameter("activeFrom");
            String timeToInput = request.getParameter("activeTo");
            Time activeFrom = Time.valueOf(timeFromInput + ":00");
            Time activeTo = Time.valueOf(timeToInput + ":00");

            HomeDTO home = new HomeDTO();
            home.setId(homeId);

            if ("AddHomeMode".equals(action)) {
                HomeModeDTO newMode = new HomeModeDTO(0, name, activeFrom, activeTo, isActive, home);
                modeDao.createHomeMode(newMode);

            } else if ("UpdateHomeMode".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                HomeModeDTO updateMode = new HomeModeDTO(id, name, activeFrom, activeTo, isActive, home);
                modeDao.updateHomeMode(updateMode);
            }

            response.sendRedirect("HomeModeServlet?action=SearchHomeMode");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi hệ thống ở HomeModeServlet luồng POST: ", e);
        }
    }
}
