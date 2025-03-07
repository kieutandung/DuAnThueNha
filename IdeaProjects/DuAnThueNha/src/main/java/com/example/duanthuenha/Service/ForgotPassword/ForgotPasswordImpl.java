package com.example.duanthuenha.Service.ForgotPassword;

import com.example.duanthuenha.ConnectDB.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ForgotPasswordImpl implements ForgotPasswordService {
    ConnectDB connectionDB = new ConnectDB();
    private static final String checkUsername = "SELECT fullName FROM Users WHERE phone = ?";
    private static final String updatePassword = "UPDATE Users SET password = ? WHERE phone = ?";

    @Override
    public String checkfullNameWithPhone(String phone) {
        Connection connection = connectionDB.getConnection();
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement(checkUsername);

            preparedStatement.setString(1, phone);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getString("fullName");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updatePassword(String phone, String newPassword) {
        Connection connection = connectionDB.getConnection();
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement(updatePassword);

            preparedStatement.setString(1, newPassword);
            preparedStatement.setString(2, phone);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
