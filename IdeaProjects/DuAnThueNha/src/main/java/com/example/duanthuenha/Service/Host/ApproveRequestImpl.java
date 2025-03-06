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
        String sql = "SELECT o.*, u.fullName, u.phone ,p.nameProduct ,p.image " +
                "FROM orders o " +
                "JOIN users u ON o.idUser = u.idUser " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE p.idUser = ?"; // Chỉ lấy các đơn hàng của chủ nhà (host)

        Connection connection = connectDB.getConnection();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setIdUser(rs.getInt("idUser"));
                order.setIdProduct(rs.getInt("idProduct"));
                order.setOrderDate(rs.getTimestamp("orderDate").toLocalDateTime());
                order.setStartDate(rs.getTimestamp("startDate").toLocalDateTime());
                order.setEndDate(rs.getTimestamp("endDate").toLocalDateTime());
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
}
