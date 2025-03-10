package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ApproveRequestImpl implements ApproveRequestService{
    private final ConnectDB connectDB = new ConnectDB();
    @Override
    public List<Order> getAllRentalRequestsByHost(int userID) {
        List<Order> rentalRequests = new ArrayList<>();
        String sql = "SELECT o.*, u.fullName, u.phone, p.nameProduct, p.image " +
                "FROM orders o " +
                "JOIN users u ON o.idUser = u.idUser " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE p.idUser = ? " +
                "AND o.paymentStatus != 'completed'";

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
    public void updateStatus(int idOrder, String newStatus) {
        String sql = "UPDATE orders SET paymentStatus = ? WHERE idOrder = ?";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, idOrder);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Cập nhật thành công đơn hàng ID: " + idOrder);
            } else {
                System.out.println("Không tìm thấy đơn hàng để cập nhật.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi cập nhật trạng thái đơn hàng", e);
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
