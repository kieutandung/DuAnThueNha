package com.example.duanthuenha.Service.Admin;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;import java.sql.SQLException;
import java.util.ArrayList;
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

    @Override
    public boolean addUser(String username, String password, String fullName, String phone, String email, String role) {
        Connection connection = connectDB.getConnection();
        String query = "INSERT INTO users (username, password, fullName, phone, email, role, status,image) values (?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, fullName);
            preparedStatement.setString(4, phone);
            preparedStatement.setString(5, email);
            preparedStatement.setString(6, role);
            preparedStatement.setString(7, "active");
            preparedStatement.setString(8, "man.png");

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
    public void updateUser(String username,String password, String fullName, String phone, String email,  String role, String status ,int idUser) {
        try (Connection connection = connectDB.getConnection()) {
            String query = "UPDATE users SET username = ?, password = ?, fullName = ?, phone = ?, email = ?, role = ?, status = ? WHERE idUser = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, fullName);
            ps.setString(4, phone);
            ps.setString(5, email);
            ps.setString(6, role);
            ps.setString(7, status);
            ps.setInt(8, idUser);

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Users getUserById(int id) {
        Users user = null; // Change to a single Users object
        try (Connection connection = connectDB.getConnection()) {
            String query = "SELECT * FROM users WHERE idUser = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) { // Use if instead of while since ID is unique
                int idUser = rs.getInt("idUser");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String image = rs.getString("image");
                user = new Users(idUser, username, password, fullName, phone, email, role, status, image);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user; // Return a single Users object
    }


}

