package dao;

import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DBUtils;

public class UserDAO {

  public UserDTO checkLogin(String username, String password) {
    String query = "SELECT ID, FULL_NAME, EMAIL, ROLE FROM USERS WHERE USERNAME = ? AND PASSWORD = ?";

    UserDTO user = null;

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(query)) {

      ptm.setString(1, username);
      ptm.setString(2, password);

      ResultSet rs = ptm.executeQuery();

      if (rs.next()) {
        int id = rs.getInt("ID");
        String fullName = rs.getString("FULL_NAME");
        String email = rs.getString("EMAIL");
        String role = rs.getString("ROLE");

        user = new UserDTO(id, username, password, fullName, email, role);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return user;
  }
}
