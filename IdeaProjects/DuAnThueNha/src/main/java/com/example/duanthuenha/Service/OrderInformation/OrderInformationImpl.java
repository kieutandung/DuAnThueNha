package com.example.duanthuenha.Service.OrderInformation;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderInformationImpl implements OrderInformationService{

    ConnectDB connectDB = new ConnectDB();
    @Override
    public List<Order> getAllOrder(int idUser) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, p.nameProduct, p.image " +
                "FROM orders o " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE o.idUser = ?";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, idUser);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setIdOrder(rs.getInt("idOrder"));
                    order.setIdUser(rs.getInt("idUser"));
                    order.setIdProduct(rs.getInt("idProduct"));
                    order.setOrderDate(rs.getTimestamp("orderDate").toLocalDateTime());
                    order.setStartDate(rs.getTimestamp("startDate").toLocalDateTime());
                    order.setEndDate(rs.getTimestamp("endDate").toLocalDateTime());
                    order.setNotes(rs.getString("notes"));
                    order.setNumPeople(rs.getInt("numPeople"));
                    order.setPaymentStatus(rs.getString("paymentStatus"));

                    // Lấy thêm dữ liệu từ bảng products
                    order.setNameProduct(rs.getString("nameProduct"));
                    order.setImage(rs.getString("image"));

                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách đơn đặt chỗ", e);
        }

        return orders;
    }



}
