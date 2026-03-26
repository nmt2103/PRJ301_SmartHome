package dao;

import dto.RuleDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.DBUtils;

public class RuleDAO {

  public boolean insertRule(RuleDTO rule) {
    String sql = "INSERT INTO RULES (HOME_ID, NAME, TRIGGER_TYPE, PRIORITY, STATUS, CREATED_AT)"
            + " VALUES (?, ?, ?, ?, ?, GETDATE())";

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

      ptm.setInt(1, rule.getHomeId());
      ptm.setString(2, rule.getName());
      ptm.setString(3, rule.getTriggerType());
      ptm.setInt(4, rule.getPriority());
      ptm.setBoolean(5, rule.getStatus());

      return ptm.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }

    return false;
  }

  public List<RuleDTO> getRules(String name, String status) {
    List<RuleDTO> searchedList = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM RULES WHERE 1=1");
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
        searchedList.add(new RuleDTO(
                rs.getInt("ID"), rs.getInt("HOME_ID"),
                rs.getString("NAME"), rs.getString("TRIGGER_TYPE"),
                rs.getInt("PRIORITY"), rs.getBoolean("STATUS")));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return searchedList;
  }

  public RuleDTO getRuleById(String id) {
    RuleDTO rule = null;
    String sql = "SELECT * FROM RULES WHERE ID=?";

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

      ptm.setString(1, id);
      ResultSet rs = ptm.executeQuery();
      if (rs.next()) {
        rule = new RuleDTO(rs.getInt("ID"), rs.getInt("HOME_ID"),
                rs.getString("NAME"), rs.getString("TRIGGER_TYPE"),
                rs.getInt("PRIORITY"), rs.getBoolean("STATUS"));
      }

    } catch (Exception e) {
      e.printStackTrace();
    }

    return rule;
  }

  public boolean updateRule(RuleDTO rule) {
    String sql = "UPDATE RULES SET NAME=?, TRIGGER_TYPE=?, PRIORITY=?, STATUS=? WHERE ID=?";

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

      ptm.setString(1, rule.getName());
      ptm.setString(2, rule.getTriggerType());
      ptm.setInt(3, rule.getPriority());
      ptm.setBoolean(4, rule.getStatus());
      ptm.setInt(5, rule.getId());

      return ptm.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }

    return false;
  }

  public boolean deleteRule(int id) {
    String sql = "DELETE FROM RULES WHERE ID=?";

    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

      ptm.setInt(1, id);

      return ptm.executeUpdate() > 0;
    } catch (Exception e) {
      e.printStackTrace();
    }

    return false;
  }

  public boolean checkDuplicateName(String ruleName, int homeId, int currentRuleId) {
    String sql = "SELECT ID FROM RULES WHERE NAME = ? AND HOME_ID = ? AND ID != ?";
    try ( Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
      ps.setString(1, ruleName);
      ps.setInt(2, homeId);
      ps.setInt(3, currentRuleId);
      ResultSet rs = ps.executeQuery();
      if (rs.next()) {
        return true;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return false;
  }
}
