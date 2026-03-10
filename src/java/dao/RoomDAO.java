/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.HomeDTO;
import dto.RoomDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DBUtils;

/**
 *
 * @author DELL
 */
public class RoomDAO {

    public ArrayList<RoomDTO> searchRoomByName(String searchValue) {
        ArrayList<RoomDTO> list = new ArrayList<>();
        // Câu lệnh SQL có INNER JOIN
        String query = "SELECT r.ID, r.NAME, r.FLOOR, r.TYPE, r.STATUS, r.HOME_ID, h.NAME AS HOME_NAME "
                + "FROM ROOM r "
                + "INNER JOIN HOME h ON r.HOME_ID = h.ID "
                + "WHERE r.NAME LIKE ?";
        
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + searchValue + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("ID");
                String name = rs.getString("NAME");
                int floor = rs.getInt("FLOOR");
                String type = rs.getString("TYPE");
                String status = rs.getString("STATUS");

                //Collect information from Home
                int homeId = rs.getInt("HOME_ID");
                String homeName = rs.getString("HOME_NAME");
                
                //Pack Home's information to HomeDTO
                HomeDTO home = new HomeDTO();
                home.setId(homeId);
                home.setName(homeName);
                
                RoomDTO room = new RoomDTO(id, name, floor, type, status, home);
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
