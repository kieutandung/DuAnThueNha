package com.example.duanthuenha.Service.Admin;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class ListAccountImpl implements ListAccountService {
    private ConnectDB connectDB = new ConnectDB();
    @Override
    public List<Users> getAllUser() {
        List<Users> users = new ArrayList<>();
        String query = "select * from users order by fullName desc";
        try (Connection connection = connectDB.getConnection()) {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int idUser = rs.getInt("idUser");
                String userName = rs.getString("userName");
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String image = rs.getString("image");
                Users user = new Users(idUser, userName, password, fullName, phone, email, role, status, image);
                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }

    @Override
    public void deleteUser(int idUser) {
        String sql = "DELETE FROM users WHERE idUser = ?";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, idUser);
            int rowsAffected = pre.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Người dùng đã được xóa thành công.");
            } else {
                System.out.println("Không tìm thấy người dùng với ID đã cho.");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa người dùng", e);
        }
    }

    public List<Users> searchUsersByName(String name) {
        List<Users> users = new ArrayList<>();
        String query = "SELECT * FROM users WHERE fullName LIKE ?";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int idUser = rs.getInt("idUser");
                String userName = rs.getString("username");
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String image = rs.getString("image");
                Users user = new Users(idUser, userName, password, fullName, phone, email, role, status, image);
                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm kiếm người dùng theo tên", e);
        }
        return users;
    }
    public List<Users> getAllUsersSortedByName() {
        List<Users> users = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY fullName ASC"; // Sắp xếp tăng dần theo tên

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int idUser = rs.getInt("idUser");
                String userName = rs.getString("userName");
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String image = rs.getString("image");

                Users user = new Users(idUser, userName, password, fullName, phone, email, role, status, image);
                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách người dùng đã sắp xếp", e);
        }
        return users;
    }

}

