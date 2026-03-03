package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtils {

  private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=SmartHome";
  private static final String USER = "sa";
  private static final String PASS = "12345";

  public static Connection getConnection() throws SQLException, ClassNotFoundException {
    Connection conn = null;
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    conn = DriverManager.getConnection(URL, USER, PASS);

    return conn;
  }
}
