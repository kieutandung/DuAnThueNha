package com.example.duanthuenha.Service.Login;

import com.example.duanthuenha.ConnectDB.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginImpl implements LoginService {
    private static final String loginCheck = "select * from users where LOWER(username) = LOWER(?) and password = ?";

    public LoginImpl() {

    }

    private ConnectDB connectDB = new ConnectDB();

    @Override
    public String[] checkLoginDB(String username, String password) {
        Connection connection = connectDB.getConnection();
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement(loginCheck);

            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String role = resultSet.getString("role");
                String status = resultSet.getString("status");
                String name = resultSet.getString("fullName");
                String id = resultSet.getString("idUser");
                return new String[]{role, status, name, id};
            } else {
                return null;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
