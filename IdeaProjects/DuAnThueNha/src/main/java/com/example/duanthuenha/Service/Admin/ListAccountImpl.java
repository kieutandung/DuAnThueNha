package com.example.duanthuenha.Service.Admin;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.*;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ListAccountImpl implements ListAccountService {
    private ConnectDB connectDB = new ConnectDB();

    @Override
    public List<Users> getAllUser() {
        List<Users> users = new ArrayList<>();
        String query = "select * from users order by idUser desc";
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


    public void updateUser(String username, String password, String fullName, String phone, String email, String role, String status, String rejectionReason, int idUser) {
        try (Connection connection = connectDB.getConnection()) {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // 1. Lấy vai trò hiện tại của user trước khi cập nhật
            String oldRole = "";
            String selectQuery = "SELECT role FROM users WHERE idUser = ?";
            try (PreparedStatement psSelect = connection.prepareStatement(selectQuery)) {
                psSelect.setInt(1, idUser);
                ResultSet rs = psSelect.executeQuery();
                if (rs.next()) {
                    oldRole = rs.getString("role");
                }
            }

            // 2. Cập nhật thông tin người dùng
            String updateQuery = "UPDATE users SET username = ?, password = ?, fullName = ?, phone = ?, email = ?, role = ?, status = ?, rejectionReason = ? WHERE idUser = ?";
            try (PreparedStatement ps = connection.prepareStatement(updateQuery)) {
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, fullName);
                ps.setString(4, phone);
                ps.setString(5, email);
                ps.setString(6, role);
                ps.setString(7, status);
                ps.setString(8, rejectionReason);
                ps.setInt(9, idUser);
                ps.executeUpdate();
            }
            // 3. Nếu role thay đổi từ 'user' sang 'host', thêm thông báo vào bảng notification
            if ("user".equals(oldRole) && "host".equals(role)) {
                String insertNotification = "INSERT INTO notification (idUser, title, content, createdAt, type, status, idReceiver) VALUES (?, ?, ?, NOW(), ?, ?, ?)";
                try (PreparedStatement psNotification = connection.prepareStatement(insertNotification)) {
                    psNotification.setInt(1, idUser);
                    psNotification.setString(2, "Chúc mừng! Bạn đã trở thành chủ nhà");
                    psNotification.setString(3, "Tài khoản của bạn đã được nâng cấp lên chủ nhà. Bạn có thể bắt đầu đăng tải các căn hộ cho thuê ngay bây giờ.");
                    psNotification.setString(4, "Thăng chức");
                    psNotification.setString(5, "unread");
                    psNotification.setInt(6, idUser); // Người nhận thông báo là chính user đó
                    psNotification.executeUpdate();
                }
            }

            connection.commit(); // Xác nhận transaction
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


    public List<Verification> getVerificationsByUserId(int idUser) {
        List<Verification> verifications = new ArrayList<>();
        String sql = "SELECT * FROM verificationdocument WHERE userId = ?";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, idUser);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Verification verification = new Verification();
                    verification.setIdDocument(resultSet.getInt("idDocument"));
                    verification.setIdUser(resultSet.getInt("userId"));
                    verification.setDocumentType(resultSet.getString("documentType"));
                    verification.setDocumentNumber(resultSet.getString("documentNumber"));
                    verification.setDocumentImage(resultSet.getString("documentImage"));
                    verification.setStatus(resultSet.getString("status"));
                    verification.setRejectionReason(resultSet.getString("rejectionReason"));
                    verification.setCreatedAt(String.valueOf(resultSet.getTimestamp("createdAt").toLocalDateTime().toLocalDate()));
                    verification.setUpdatedAt(String.valueOf(resultSet.getTimestamp("updatedAt").toLocalDateTime().toLocalDate()));
                    verification.setDocumentFile(resultSet.getString("documentFile"));

                    verifications.add(verification);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách hồ sơ của người dùng: " + idUser, e);
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
    public boolean updateVerificationStatus(int idDocument, String action, String reason) {
        String sql = "UPDATE verificationdocument SET status = ?, rejectionReason = ? WHERE idDocument = ?";

        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, action.equals("accept") ? "approved" : "rejected");
            stmt.setString(2, action.equals("accept") ? "" : reason);
            stmt.setInt(3, idDocument);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Order> getAllOrder() {
        List<Order> rentalRequests = new ArrayList<>();
        String sql = "SELECT o.*, u.fullName, u.phone, p.nameProduct, p.image, p.price " +
                "FROM orders o " +
                "JOIN users u ON o.idUser = u.idUser " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE o.paymentStatus = 'completed'";

        Connection connection = connectDB.getConnection();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setIdOrder(rs.getInt("idOrder"));
                order.setIdUser(rs.getInt("idUser"));
                order.setIdProduct(rs.getInt("idProduct"));
                order.setOrderDate(rs.getTimestamp("orderDate").toLocalDateTime());
                order.setStartDate(rs.getTimestamp("startDate").toLocalDateTime().toLocalDate());
                order.setEndDate(rs.getTimestamp("endDate").toLocalDateTime().toLocalDate());
                order.setNotes(rs.getString("notes"));
                order.setNumPeople(rs.getInt("numPeople"));
                order.setPaymentStatus(rs.getString("paymentStatus"));

                // Thêm thông tin user
                order.setFullName(rs.getString("fullName"));
                order.setPhone(rs.getString("phone"));
                order.setImage(rs.getString("image"));
                order.setNameProduct(rs.getString("nameProduct"));
                order.setPrice(rs.getDouble("price"));

                rentalRequests.add(order);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return rentalRequests;
    }

    public Map<Integer, Double> getRevenueByMonth() {
        Map<Integer, Double> revenueByMonth = new HashMap<>();
        String sql = "SELECT MONTH(o.endDate) AS month, SUM(p.price) AS totalRevenue " +
                "FROM orders o " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE o.paymentStatus = 'completed' " +
                "GROUP BY MONTH(o.endDate)";

        Connection connection = connectDB.getConnection();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("month");
                double totalRevenue = rs.getDouble("totalRevenue");
                revenueByMonth.put(month, totalRevenue);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return revenueByMonth;
    }

    public Map<String, Integer> getOrderStatusCount() {
        Map<String, Integer> statusCount = new HashMap<>();
        String sql = "SELECT paymentStatus, COUNT(*) AS count FROM orders GROUP BY paymentStatus";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                statusCount.put(rs.getString("paymentStatus"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return statusCount;
    }

    public List<Product> getTopRentedProducts() {
        List<Product> topProducts = new ArrayList<>();
        String sql = "SELECT p.idProduct, p.nameProduct, p.image, p.price, COUNT(o.idOrder) AS rentalCount " +
                "FROM orders o " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE o.paymentStatus = 'completed' " +
                "GROUP BY p.idProduct " +
                "ORDER BY rentalCount DESC " +
                "LIMIT 5";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setIdProduct(rs.getInt("idProduct"));
                product.setNameProduct(rs.getString("nameProduct"));
                product.setImage(rs.getString("image"));
                product.setPrice(BigDecimal.valueOf(rs.getDouble("price")));
                topProducts.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return topProducts;
    }

    @Override
    public List<Users> getAllUserByIdDocument() {
        List<Users> userList = new ArrayList<>();
        String sql = "SELECT DISTINCT u.* FROM users u " +
                "JOIN verificationdocument v ON u.idUser = v.userId";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int idUser = rs.getInt("idUser");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String image = rs.getString("image");
                String address = rs.getString("address");
                String gender = rs.getString("gender");
                String birthDate = rs.getString("birthDate");
                String rejectionReason = rs.getString("rejectionReason");

                Users user = new Users(idUser, username, password, fullName, phone, email, role, status, image, address, gender, birthDate, rejectionReason);
                userList.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách người dùng có liên kết với idDocument", e);
        }
        return userList;
    }

    public List<Report> getAllReport() {
        List<Report> reportList = new ArrayList<>();
        String sql = "SELECT *\n" +
                "FROM report\n" +
                "order by idReport desc;";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int idReport = rs.getInt("idReport");
                int idProduct = rs.getInt("idProduct");
                int idUser = rs.getInt("idUser");
                LocalDate reportDate = rs.getTimestamp("reportDate").toLocalDateTime().toLocalDate();

                String description = rs.getString("description");
                String reason = rs.getString("reason");
                String status = rs.getString("status");
                String adminResponse = rs.getString("adminResponse");

                Report report = new Report(idReport, idProduct, idUser, description, status, reason, reportDate, adminResponse);
                reportList.add(report);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return reportList;
    }

    public List<Report> getAllReportPending() {
        List<Report> reportList = new ArrayList<>();
        String sql = "SELECT *\n" +
                "FROM report\n" +
                "WHERE status = 'pending' order by idReport desc;";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int idReport = rs.getInt("idReport");
                int idProduct = rs.getInt("idProduct");
                int idUser = rs.getInt("idUser");
                LocalDate reportDate = rs.getTimestamp("reportDate").toLocalDateTime().toLocalDate();

                String description = rs.getString("description");
                String reason = rs.getString("reason");
                String status = rs.getString("status");

                Report report = new Report(idReport, idProduct, idUser, description, status, reason, reportDate);
                reportList.add(report);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return reportList;
    }

    @Override
    public Users getUserByidProduct(int idProduct) {
        Users user = null;
        try (Connection connection = connectDB.getConnection()) {
            String query = "SELECT u.*\n" +
                    "FROM Users u\n" +
                    "JOIN Products p ON u.idUser = p.idUser\n" +
                    "WHERE p.idProduct = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, idProduct);
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
    public void sendFeedback(com.example.duanthuenha.Model.Notification notification) {
        String insertImageSQL = "INSERT INTO Notification (idUser, title, content,type,idReceiver) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(insertImageSQL)) {
            ps.setInt(1, notification.getIdUser());
            ps.setString(3, notification.getMessage());
            ps.setString(2, notification.getTitle());
            ps.setString(4, notification.getType());
            ps.setInt(5, notification.getIdReceiver());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm", e);
        }
    }

    @Override
    public Notification getNotificationById(int idNotification) {
        String selectSQL = "SELECT * FROM notification WHERE idNotification = ?";
        Notification notification = null;
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(selectSQL);
            pstm.setInt(1, idNotification);
            try {
                ResultSet rs = pstm.executeQuery();
                {
                    if (rs.next()) {
                        int idUser = rs.getInt("idUser");
                        String title = rs.getString("title");
                        String content = rs.getString("content");
                        String type = rs.getString("type");
                        String status = rs.getString("status");
                        notification = new Notification(idNotification, idUser, title, content, type, status);
                        return notification;
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

    public void updateReportApproved(int idReport, String adminResponse) {
        try (Connection connection = connectDB.getConnection()) {
            String query = "UPDATE report SET status = ?, adminResponse = ? WHERE idReport = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(3, idReport);
            ps.setString(1, "approved");
            ps.setString(2, adminResponse);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}

