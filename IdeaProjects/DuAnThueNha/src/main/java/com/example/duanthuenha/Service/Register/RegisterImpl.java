package com.example.duanthuenha.Service.Register;

import com.example.duanthuenha.ConnectDB.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterImpl implements RegisterService{
    ConnectDB connectionDB = new ConnectDB();
    private final String register = "insert into users (username, password, name, role, status) values (?,?,?,?,?)";
    private final String checkUser = "select * from users where username = ?";

    public RegisterImpl() {

    }

    @Override
    public boolean checkUsername(String username) {
        Connection connection = connectionDB.getConnection();
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement(checkUser);

            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int count = resultSet.getInt(1);
                if (count > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    @Override
    public boolean registerUser(String username, String password, String fullName, String phone, String email) {
        Connection connection = connectionDB.getConnection();
        PreparedStatement preparedStatement;

        if (checkUsername(username)) {
            return false;
        }

        try {
            preparedStatement = connection.prepareStatement(register);

            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, fullName);
            preparedStatement.setString(4, phone);
            preparedStatement.setString(5, email);
            preparedStatement.setString(4, "user");
            preparedStatement.setString(5, "active");

            int row = preparedStatement.executeUpdate();

            if (row > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }
}
