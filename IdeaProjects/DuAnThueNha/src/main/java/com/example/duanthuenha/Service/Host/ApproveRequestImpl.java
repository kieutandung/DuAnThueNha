package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ApproveRequestImpl implements ApproveRequestService {
    private final ConnectDB connectDB = new ConnectDB();

    @Override
    public List<Order> getAllRentalRequestsByHost(int userID) {
        List<Order> rentalRequests = new ArrayList<>();
        String sql = "SELECT o.*, u.fullName, u.phone, p.nameProduct, p.image " +
                "FROM orders o " +
                "JOIN users u ON o.idUser = u.idUser " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE p.idUser = ? " +
                "AND o.paymentStatus NOT IN ('completed', 'paid')";

        Connection connection = connectDB.getConnection();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
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

    @Override
    public void updateStatus(int idOrder, String newStatus, int idReceiver) {
        String updateOrderSql = "UPDATE orders SET paymentStatus = ? WHERE idOrder = ?";
        String insertNotificationSql = "INSERT INTO notification (idUser, title, content, createdAt, type, status, idReceiver) VALUES (?, ?, ?, NOW(), ?, 'unread', ?)";

        try (Connection connection = connectDB.getConnection()) {
            connection.setAutoCommit(false);

            // Cập nhật trạng thái đơn hàng
            try (PreparedStatement ps = connection.prepareStatement(updateOrderSql)) {
                ps.setString(1, newStatus);
                ps.setInt(2, idOrder);
                ps.executeUpdate();
            }

            // Thêm thông báo vào bảng notification
            try (PreparedStatement ps = connection.prepareStatement(insertNotificationSql)) {
                ps.setInt(1, idReceiver);
                ps.setString(2, "Cập nhật đơn hàng");
                String contentMessage = newStatus.equals("waiting") ? "Đơn hàng của bạn đã được xác nhận, thanh toán ngay để có thể thuê nhà." : "Đơn hàng của bạn đã bị từ chối.";
                ps.setString(3, contentMessage);
                ps.setString(4, "Xác nhận đơn");
                ps.setInt(5, idReceiver);
                ps.executeUpdate();
            }

            connection.commit();

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi cập nhật trạng thái đơn hàng và gửi thông báo", e);
        }
    }



    @Override
    public List<Order> getAllPaymentManagement(int userID) {
        List<Order> rentalRequests = new ArrayList<>();
        String sql = "SELECT o.*, u.fullName, u.phone, p.nameProduct, p.image, p.price " +
                "FROM orders o " +
                "JOIN users u ON o.idUser = u.idUser " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE p.idUser = ? " +
                "AND o.paymentStatus != 'pending' AND o.paymentStatus != 'cancelled'";

        Connection connection = connectDB.getConnection();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
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
}
