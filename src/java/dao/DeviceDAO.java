package dao;

import dto.DeviceDTO;
import dto.HomeDTO;
import dto.RoomDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import util.DBUtils;

public class DeviceDAO {

    public ArrayList<DeviceDTO> searchDevices(String value, int roomId, String status) {
        ArrayList<DeviceDTO> list = new ArrayList<>();
        String query = "SELECT d.ID, d.TYPE, d.SERIAL_NO, d.VENDOR, d.STATUS, d.LAST_SEEN_ST, "
                + "r.ID AS ROOM_ID, r.NAME AS ROOM_NAME, "
                + "h.ID AS HOME_ID, h.NAME AS HOME_NAME "
                + "FROM DEVICE d "
                + "INNER JOIN ROOM r ON d.ROOM_ID = r.ID "
                + "INNER JOIN HOME h ON r.HOME_ID = h.ID "
                + "WHERE (d.SERIAL_NO LIKE ? OR d.TYPE LIKE ?) "
                + "AND (? = 0 OR d.ROOM_ID = ?)"
                + " AND (? = '' OR d.STATUS = ?)";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, "%" + value + "%");
            stmt.setString(2, "%" + value + "%");

            stmt.setInt(3, roomId);
            stmt.setInt(4, roomId);

            stmt.setString(5, status);
            stmt.setString(6, status);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                HomeDTO home = new HomeDTO();
                home.setId(rs.getInt("HOME_ID"));
                home.setName(rs.getString("HOME_NAME"));

                RoomDTO room = new RoomDTO();
                room.setId(rs.getInt("ROOM_ID"));
                room.setName(rs.getString("ROOM_NAME"));
                room.setHomeId(home);

                int id = rs.getInt("ID");
                String type = rs.getString("TYPE");
                String serial = rs.getString("SERIAL_NO");
                String vendor = rs.getString("VENDOR");
                String devStatus = rs.getString("STATUS");
                Timestamp lastseen = rs.getTimestamp("LAST_SEEN_ST");

                DeviceDTO dev = new DeviceDTO(id, type, serial, vendor, devStatus, lastseen, room);
                list.add(dev);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    return list;
  }

  public boolean createDevice(DeviceDTO dev) {
    boolean check = false;
    String query = "INSERT INTO DEVICE (TYPE, SERIAL_NO, VENDOR, STATUS, LAST_SEEN_ST, ROOM_ID) VALUES (?,?,?,?,?,?)";

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
      stmt.setString(1, dev.getType());
      stmt.setString(2, dev.getSerial());
      stmt.setString(3, dev.getVendor());
      stmt.setString(4, dev.getStatus());
      stmt.setTimestamp(5, dev.getLastSeen());
      stmt.setInt(6, dev.getRoomId().getId());

      if (stmt.executeUpdate() > 0) {
        check = true;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return check;
  }

  public boolean updateDevice(DeviceDTO dev) {
    boolean check = false;
    String query = "UPDATE DEVICE"
            + "SET TYPE = ?, SERIAL_NO = ?, VENDOR = ?, STATUS = ?, LAST_SEEN_ST = ?, ROOM_ID = ?"
            + "WHERE ID = ?";
    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
      stmt.setString(1, dev.getType());
      stmt.setString(2, dev.getSerial());
      stmt.setString(3, dev.getVendor());
      stmt.setString(4, dev.getStatus());
      stmt.setTimestamp(5, dev.getLastSeen());
      stmt.setInt(6, dev.getRoomId().getId());
      stmt.setInt(7, dev.getId());

      if (stmt.executeUpdate() > 0) {
        check = true;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return check;
  }

  public boolean deleteDevice(int deviceId) {
    boolean check = false;
    String query = "UPDATE DEVICE SET STATUS = 'Removed' WHERE ID = ?";
    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

      stmt.setInt(1, deviceId);
      if (stmt.executeUpdate() > 0) {
        check = true;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return check;
  }

  public DeviceDTO getDeviceById(int id) {
    DeviceDTO dev = null;
    String query = "SELECT * FROM DEVICE WHERE ID = ?";
    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
      stmt.setInt(1, id);

      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        int devId = rs.getInt("ID");
        String type = rs.getString("TYPE");
        String serial = rs.getString("SERIAL_NO");
        String vendor = rs.getString("VENDOR");
        String status = rs.getString("STATUS");
        Timestamp lastSeen = rs.getTimestamp("LAST_SEEN_ST");

        int roomId = rs.getInt("ROOM_ID");
        RoomDTO room = new RoomDTO();
        room.setId(roomId);

        dev = new DeviceDTO(id, type, serial, vendor, status, lastSeen, room);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return dev;
  }

  public boolean toggleDeviceStatus(int devId, String status) {
    boolean check = false;
    String newStatus = "";

    if ("Active".equalsIgnoreCase(status)) {
      newStatus = "Inactive";
    } else if ("Inactive".equalsIgnoreCase(status)) {
      newStatus = "Active";
    } else {
      return false;
    }
    String query = "UPDATE DEVICE SET STATUS = ? WHERE ID = ?";
    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
      stmt.setString(1, newStatus);
      stmt.setInt(2, devId);

      if (stmt.executeUpdate() > 0) {
        check = true;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return check;
  }
}
