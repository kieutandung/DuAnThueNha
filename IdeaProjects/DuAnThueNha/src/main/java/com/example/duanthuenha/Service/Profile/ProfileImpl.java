package com.example.duanthuenha.Service.Profile;


import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Users;

import java.sql.*;

public class ProfileImpl implements ProfileService {
    private ConnectDB connectDB = new ConnectDB();

    @Override
    public Users getUserById(int idUser) {
        String sql = "select * from users where idUser = ?";
        Users users = null;
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, idUser);
            try {
                ResultSet rs = pstm.executeQuery();
                {
                    if (rs.next()) {
                        String username = rs.getString("username");
                        String password = rs.getString("password");
                        String fullName = rs.getString("fullName");
                        String phone = rs.getString("phone");
                        String email = rs.getString("email");
                        String image = rs.getString("image");
                        users = new Users(idUser, username, password, fullName, phone, email, image);
                        return users;
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public void UpdateInformation(Users users) {
        String query = "UPDATE users SET fullName = ?, phone = ?, email = ?, image = ? ,password = ? WHERE idUser = ?";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, users.getFullName());
            stmt.setString(2, users.getPhone());
            stmt.setString(3, users.getEmail());
            stmt.setString(4,users.getImage());
            stmt.setString(5, users.getPassword());
            stmt.setInt(6, users.getIdUser());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

}