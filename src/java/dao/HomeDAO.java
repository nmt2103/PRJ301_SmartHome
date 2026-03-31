package dao;

import dto.HomeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.DBUtils;

public class HomeDAO {

  public boolean insertHome(HomeDTO home) {
    String sql = "INSERT INTO HOME (CODE, NAME, ADDRESS, STATUS, CREATE_AT) VALUES (?, ?, ?, ?, GETDATE())";

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

      ptm.setString(1, home.getCode());
      ptm.setString(2, home.getName());
      ptm.setString(3, home.getAddress());
      ptm.setBoolean(4, home.isStatus());

      return ptm.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }

    return false;
  }

  public List<HomeDTO> getHomes(String name, String status) {
    List<HomeDTO> searchedList = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM HOME WHERE 1=1");
    List<Object> parameters = new ArrayList<>();

    if (name != null && !name.trim().isEmpty()) {
      sql.append(" AND NAME LIKE ?");
      parameters.add("%" + name + "%");
    }

    if (status != null && !status.trim().isEmpty()) {
      sql.append(" AND STATUS = ?");
      parameters.add(status);
    }

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql.toString())) {

      for (int i = 0; i < parameters.size(); i++) {
        ptm.setObject(i + 1, parameters.get(i));
      }

      ResultSet rs = ptm.executeQuery();
      while (rs.next()) {
        searchedList.add(new HomeDTO(
                rs.getInt("ID"), rs.getString("CODE"),
                rs.getString("NAME"), rs.getString("ADDRESS"),
                rs.getBoolean("STATUS"), rs.getTimestamp("CREATE_AT")));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return searchedList;
  }

  public HomeDTO getHomeById(String id) {
    HomeDTO home = null;
    String sql = "SELECT * FROM HOME WHERE ID=?";

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

      ptm.setString(1, id);
      ResultSet rs = ptm.executeQuery();
      if (rs.next()) {
        home = new HomeDTO(rs.getInt("ID"), rs.getString("CODE"),
                rs.getString("NAME"), rs.getString("ADDRESS"),
                rs.getBoolean("STATUS"), rs.getTimestamp("CREATE_AT"));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return home;
  }

  public boolean updateHome(HomeDTO home) {
    String sql = "UPDATE HOME SET CODE=?, NAME=?, ADDRESS=?, STATUS=? WHERE ID=?";

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

      ptm.setString(1, home.getCode());
      ptm.setString(2, home.getName());
      ptm.setString(3, home.getAddress());
      ptm.setBoolean(4, home.isStatus());
      ptm.setInt(5, home.getId());

      return ptm.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }

    return false;
  }

  public boolean deleteHome(int id) {
    String sql = "DELETE FROM HOME WHERE ID=?";

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

      ptm.setInt(1, id);

      return ptm.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }

    return false;
  }
  
  public boolean toggleHomeStatus(int homeId, boolean status) {
      boolean check = false;
      String query = "UPDATE HOME SET STATUS = ? WHERE ID = ?";
      try (Connection conn = DBUtils.getConnection();
              PreparedStatement stmt = conn.prepareStatement(query)) {
          stmt.setBoolean(1, status);
          stmt.setInt(2, homeId);
          
          if(stmt.executeUpdate() > 0) {
              check = true;
          }
      } catch (Exception e) {
          e.printStackTrace();
      }
      return check;
  }
}
