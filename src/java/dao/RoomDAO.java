package dao;

import dto.HomeDTO;
import dto.RoomDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.DBUtils;

public class RoomDAO {

    public boolean insertRoom(RoomDTO room) {
        String sql = "INSERT INTO ROOM (HOME_ID, NAME, FLOOR, TYPE, STATUS) VALUES (?, ?, ?, ?, ?)";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ptm = conn.prepareStatement(sql)) {

            ptm.setInt(1, room.getHomeId());
            ptm.setString(2, room.getName());
            ptm.setInt(3, room.getFloor());
            ptm.setString(4, room.getType());
            ptm.setBoolean(5, room.isStatus());

            return ptm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<RoomDTO> getRooms(String name, String status) {
        List<RoomDTO> searchedList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM ROOM WHERE 1=1");
        List<Object> parameters = new ArrayList<>();

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND NAME LIKE ?");
            parameters.add("%" + name + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND STATUS = ?");
            parameters.add(status);
        }

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ptm = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ptm.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                HomeDTO home = new HomeDTO();
                home.setId(rs.getInt("HOME_ID"));
                home.setName(name);
                searchedList.add(new RoomDTO(
                        rs.getInt("ID"), rs.getInt("HOME_ID"),
                        rs.getString("NAME"), rs.getInt("FLOOR"),
                        rs.getString("TYPE"), rs.getBoolean("STATUS")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return searchedList;
    }

    public RoomDTO getRoomById(String id) {
        RoomDTO room = null;
        String sql = "SELECT * FROM ROOM WHERE ID=?";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ptm = conn.prepareStatement(sql)) {

            ptm.setString(1, id);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                room = new RoomDTO(rs.getInt("ID"), rs.getInt("HOME_ID"),
                        rs.getString("NAME"), rs.getInt("FLOOR"),
                        rs.getString("TYPE"), rs.getBoolean("STATUS"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    public boolean updateRoom(RoomDTO room) {
        String sql = "UPDATE ROOM SET NAME=?, FLOOR=?, TYPE=?, STATUS=? WHERE ID=?";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ptm = conn.prepareStatement(sql)) {

            ptm.setString(1, room.getName());
            ptm.setInt(2, room.getFloor());
            ptm.setString(3, room.getType());
            ptm.setBoolean(4, room.isStatus());
            ptm.setInt(5, room.getId());

            return ptm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteRoom(int id) {
        String sql = "DELETE FROM ROOM WHERE ID=?";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ptm = conn.prepareStatement(sql)) {

            ptm.setInt(1, id);

            return ptm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean toggleRoomStatus(int roomId, boolean status) {
        boolean check = false;
        String query = "UPDATE ROOM SET STATUS = ? WHERE ID = ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setBoolean(1, status);
            stmt.setInt(2, roomId);

            if (stmt.executeUpdate() > 0) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
}
