package com.example.duanthuenha.ConnectDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {
    private String url = "jdbc:mysql://localhost:3306/DuAnThueNha?useSSL=true&serverTimezone=UTC";
    private String username = System.getenv("jdbcUsernameDB");
    private String password = System.getenv("jdbcPasswordDB");
    public Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }
}
