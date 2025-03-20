package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Order;
import com.example.duanthuenha.Model.Product;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RevenueImpl implements RevenueService{
    ConnectDB connectDB = new ConnectDB();

    @Override
    public List<Order> getAllCompletedOrdersByHost(int hostId) {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT o.*, u.fullName, u.phone, p.nameProduct, p.image, p.price " +
                "FROM orders o " +
                "JOIN products p ON o.idProduct = p.idProduct " + // Kết nối bảng products
                "JOIN users u ON o.idUser = u.idUser " + // Kết nối bảng users để lấy thông tin khách thuê
                "WHERE o.paymentStatus = 'completed' AND p.idUser = ?"; // Lọc theo hostId

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, hostId); // Host ID từ bảng products

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setIdOrder(rs.getInt("idOrder"));
                    order.setIdUser(rs.getInt("idUser")); // Đây là idUser của người thuê
                    order.setIdProduct(rs.getInt("idProduct"));

                    // Định dạng ngày
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    String formattedDate = rs.getTimestamp("orderDate").toLocalDateTime().format(formatter);
                    order.setFormattedOrderDate(formattedDate);

                    order.setStartDate(rs.getTimestamp("startDate").toLocalDateTime().toLocalDate());
                    order.setEndDate(rs.getTimestamp("endDate").toLocalDateTime().toLocalDate());
                    order.setNotes(rs.getString("notes"));
                    order.setNumPeople(rs.getInt("numPeople"));
                    order.setPaymentStatus(rs.getString("paymentStatus"));

                    // Thông tin khách thuê
                    order.setFullName(rs.getString("fullName"));
                    order.setPhone(rs.getString("phone"));

                    // Thông tin nhà
                    order.setImage(rs.getString("image"));
                    order.setNameProduct(rs.getString("nameProduct"));
                    order.setPrice((int) Math.round(rs.getDouble("price")));

                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy danh sách đơn hàng hoàn thành của host", e);
        }
        return orderList;
    }
    @Override
    public Map<Integer, Double> getRevenueByMonth(int idUser) {
        Map<Integer, Double> revenueByMonth = new HashMap<>();
        String sql = "SELECT MONTH(o.endDate) AS month, SUM(p.price) AS revenue " +
                "FROM orders o " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE o.paymentStatus = 'completed' AND p.idUser = ? " +
                "GROUP BY month";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idUser);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    revenueByMonth.put(rs.getInt("month"), rs.getDouble("revenue"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy doanh thu theo tháng", e);
        }
        return revenueByMonth;
    }
    public List<Product> getTopRentedHouses(int idUser) {
        List<Product> topHouses = new ArrayList<>();
        String sql = "SELECT p.idProduct, p.nameProduct, p.price, p.image, p.area, COUNT(o.idOrder) AS rentCount " +
                "FROM orders o " +
                "JOIN products p ON o.idProduct = p.idProduct " +
                "WHERE o.paymentStatus = 'completed' AND p.idUser = ? " +
                "GROUP BY p.idProduct " +
                "ORDER BY rentCount DESC " +
                "LIMIT 5";

        try (Connection conn = connectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUser); // Truyền idUser vào câu lệnh SQL
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setIdProduct(rs.getInt("idProduct"));
                    product.setNameProduct(rs.getString("nameProduct"));
                    product.setPrice(BigDecimal.valueOf(rs.getDouble("price")));
                    product.setImage(rs.getString("image"));
                    product.setArea(rs.getDouble("area"));
                    topHouses.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy top nhà được thuê nhiều nhất", e);
        }
        return topHouses;
    }



}
