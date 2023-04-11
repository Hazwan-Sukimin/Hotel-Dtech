package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnection {
    private static Connection con;
    
    public static Connection getConnection(){
        try {
            
            // variable getconnection driver manager
            String connectionString = "jdbc:mysql://localhost:3306/dtech hotel";
            String dbUsername = "root";
            String dbPassword = "";
            
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            con = DriverManager.getConnection(connectionString,dbUsername,dbPassword);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
    
    public String checkConnection(){
        String message = "";
        try {
            if (con != null && !con.isClosed()) {
                message = "Database connection is active";
            } else {
                message = "Database connection is not active";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Error while checking database connection: " + e.getMessage();
        }
        return message;
    }
}
