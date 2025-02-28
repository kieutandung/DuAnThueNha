package com.example.duanthuenha.Service.Admin;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Users;
import com.example.duanthuenha.Model.Verification;

import java.sql.*;
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
    public Users addUser(String username, String password, String fullName, String phone, String email, String role) {
        Connection connection = connectDB.getConnection();
        String query = "INSERT INTO users (username, password, fullName, phone, email, role, status, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

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
                // Lấy ID của người dùng mới được thêm
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int newUserId = generatedKeys.getInt(1);
                    // Tạo đối tượng Users mới
                    return new Users(newUserId, username, password, fullName, phone, email, role, "active", "man.png");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không thành công
    }

    public List<Users> getAllUsersSortedByName() {
        List<Users> users = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY SUBSTRING_INDEX(fullName, ' ', -1) ASC";

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


    public void updateUser(String username, String password, String fullName, String phone, String email, String role, String status, int idUser) {
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
        Users user = null;
        try (Connection connection = connectDB.getConnection()) {
            String query = "SELECT * FROM users WHERE idUser = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
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
        return user;
    }

    @Override
    public List<Verification> getAllVerification() {
        List<Verification> verificationList = new ArrayList<>();
        String sql = "SELECT * FROM verificationdocument";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int idDocument = rs.getInt("idDocument");
                int idUser = rs.getInt("userId");
                String documentType = rs.getString("documentType");
                String documentNumber = rs.getString("documentNumber");
                String documentImage = rs.getString("documentImage");
                String status = rs.getString("status");
                String rejectionReason = rs.getString("rejectionReason");
                String createdAt = rs.getString("createdAt");
                String updatedAt = rs.getString("updatedAt");
                Verification verification = new Verification(idDocument, idUser, documentType, documentNumber, documentImage, status, rejectionReason, createdAt, updatedAt);
                verificationList.add(verification);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return verificationList;
    }

    public List<Verification> getVerificationsByUserId(int idUser) {
        List<Verification> verifications = new ArrayList<>();
        String sql = "SELECT * FROM verificationdocument WHERE userId = ?"; // Chỉ cần idUser

        try (Connection connection = connectDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, idUser); // Chỉ cần thiết lập idUser

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Verification verification = new Verification();
                verification.setIdDocument(resultSet.getInt("idDocument"));
                verification.setIdUser(resultSet.getInt("userId"));
                verification.setDocumentType(resultSet.getString("documentType"));
                verification.setDocumentNumber(resultSet.getString("documentNumber"));
                verification.setDocumentImage(resultSet.getString("documentImage"));
                verification.setStatus(resultSet.getString("status"));
                verification.setRejectionReason(resultSet.getString("rejectionReason"));
                verification.setCreatedAt(String.valueOf(resultSet.getTimestamp("createdAt"))); // Giữ nguyên kiểu dữ liệu Timestamp
                verifications.add(verification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return verifications;
    }


    public boolean promoteUser(int idUser) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean updated = false;

        try {
            conn = connectDB.getConnection();
            String sql = "UPDATE users SET role = 'host' WHERE idUser = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUser);

            int rowsAffected = stmt.executeUpdate();
            updated = rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updated;
    }


    public boolean updateStatus(int idDocument, String status, String rejectionReason) {
        String sql = "UPDATE verificationdocument SET status = ?, rejectionReason = ?, updatedAt = NOW() WHERE idDocument = ?";

        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setString(2, rejectionReason);
            stmt.setInt(3, idDocument);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public Verification getVerificationByIdDocument(int idDocument) {
        String query = "SELECT * FROM verificationdocument WHERE idDocument = ?";
        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, idDocument);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Verification(
                        rs.getInt("idDocument"),
                        rs.getInt("userId"),
                        rs.getString("documentType"),
                        rs.getString("documentNumber"),
                        rs.getString("documentImage"),
                        rs.getString("status"),
                        rs.getString("rejectionReason"),
                        rs.getString("createdAt"),
                        rs.getString("updatedAt")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean updateVerificationStatus(int idDocument, String status, String rejectionReason) {
        String sql = "UPDATE verificationdocument SET status = ?, rejectionReason = ? WHERE idDocument = ?";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, status);
            preparedStatement.setString(2, rejectionReason);
            preparedStatement.setInt(3, idDocument);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có bản ghi được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}

