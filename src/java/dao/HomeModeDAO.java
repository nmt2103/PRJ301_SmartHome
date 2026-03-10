/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.HomeDTO;
import dto.HomeModeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DBUtils;

/**
 *
 * @author DELL
 */
public class HomeModeDAO {

    public ArrayList<HomeModeDTO> searchHomeMode(String value, int homeId, String status) {
        ArrayList<HomeModeDTO> list = new ArrayList<>();
        String query = "SELECT m.ID, m.NAME, m.ACTIVE_FROM, m.ACTIVE_TO, m.IS_ACTIVE, m.HOME_ID, h.NAME AS HOME_NAME"
                + "FROM HOMEMODE m"
                + "INNER JOIN HOME h ON m.HOME_ID = h.ID"
                + "WHERE m.NAME LIKE ?"
                + "AND (? = 0 OR m.HOME_ID = ?)";
        if ("1".equalsIgnoreCase(status)) {
            query += "AND m.IS_ACTIVE = 1";
        } else if ("0".equalsIgnoreCase(status)) {
            query += "AND m.IS_ACTIVE = 0";
        }

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + value + "%");
            stmt.setInt(2, homeId);
            stmt.setInt(3, homeId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                HomeDTO home = new HomeDTO();
                home.setId(rs.getInt("HOME_ID"));
                home.setName(rs.getString("HOME_NAME"));

                HomeModeDTO hm = new HomeModeDTO();
                hm.setId(rs.getInt("ID"));
                hm.setName(rs.getString("NAME"));
                hm.setAct_fr(rs.getTime("ACTIVE_FROM"));
                hm.setAct_to(rs.getTime("ACTIVE_TO"));
                hm.setIs_act(rs.getBoolean("IS_ACTIVE"));
                hm.setHomeId(home);

                list.add(hm);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean createHomeMode(HomeModeDTO hm) {
        boolean check = false;
        String query = "INSERT INTO HOMEMODE (NAME, ACTIVE_FROM, ACTIVE_TO, IS_ACTIVE, HOME_ID) VALUES (?,?,?,?,?)";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, hm.getName());
            stmt.setTime(2, hm.getAct_fr());
            stmt.setTime(3, hm.getAct_to());
            stmt.setBoolean(4, hm.isIs_act());
            stmt.setInt(5, hm.getHomeId().getId());

            if (stmt.executeUpdate() > 0) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean updateHomeMode(HomeModeDTO hm) {
        boolean check = false;
        String query = "UPDATE HOMEMODE SET NAME=?, ACTIVE_FROM=?, ACTIVE_TO=?, HOME_ID=?, WHERE ID=?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, hm.getName());
            stmt.setTime(2, hm.getAct_fr());
            stmt.setTime(3, hm.getAct_to());
            stmt.setBoolean(4, hm.isIs_act());
            stmt.setInt(5, hm.getHomeId().getId());
            stmt.setInt(6, hm.getId());

            if (stmt.executeUpdate() > 0) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public HomeModeDTO getHomeModeByID(int id) {
        HomeModeDTO hm = null;
        String query = "SELECT * FROM HOMEMODE WHERE ID =?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HomeDTO home = new HomeDTO();
                home.setId(rs.getInt("HOME_ID"));

                hm = new HomeModeDTO(rs.getInt("ID"),
                        rs.getString("NAME"),
                        rs.getTime("ACTIVE_FROM"),
                        rs.getTime("ACTIVE_TO"),
                        rs.getBoolean("IS_ACTIVE"),
                        home);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return hm;
    }

    public boolean deleteHomeMode(int id) {
        boolean check = false;
        String query = "DELETE FROM HOMEMODE WHERE ID =?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            if (stmt.executeUpdate() > 0) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean toggleHomeModeStatus(int hmId, boolean status) {
        boolean check = false;
        boolean newStatus = !status;

        String query = "UPDATE HOMEMODE SET IS_ACTIVE = ? WHERE ID = ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setBoolean(1, newStatus);
            stmt.setInt(2, hmId);

            if (stmt.executeUpdate() > 0) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
}
