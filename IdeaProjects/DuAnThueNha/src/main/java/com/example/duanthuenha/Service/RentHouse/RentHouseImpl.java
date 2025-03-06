package com.example.duanthuenha.Service.RentHouse;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Order;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class RentHouseImpl implements RentHouseService {
    private final ConnectDB connectDB = new ConnectDB();

    @Override
    public Order addRentHouse(int idUser, int idProduct, String startDate, String endDate, String notes, int numPeople) {
        String sql = "INSERT INTO orders (idUser, idProduct, orderDate, startDate, endDate, notes, numPeople, paymentStatus) " +
                "VALUES (?, ?, NOW(), ?, ?, ?, ?, 'pending')";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Định dạng ngày tháng từ chuỗi (yyyy-MM-dd)
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate startDateTime = LocalDate.parse(startDate, formatter);
            LocalDate endDateTime = LocalDate.parse(endDate, formatter);

            ps.setInt(1, idUser);
            ps.setInt(2, idProduct);
            ps.setDate(3, Date.valueOf(startDateTime));
            ps.setDate(4, Date.valueOf(endDateTime));
            ps.setString(5, notes);
            ps.setInt(6, numPeople);

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Failed to insert order, no rows affected.");
            }

            // Lấy ID tự động tăng (idOrder)
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int idOrder = generatedKeys.getInt(1);
                    LocalDateTime orderDate = LocalDateTime.now(); // Thời gian hiện tại

                    return new Order(idOrder, idUser, idProduct, orderDate, startDateTime.atStartOfDay(), endDateTime.atStartOfDay(), notes, numPeople, "pending");
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding rental order: " + e.getMessage(), e);
        }
    }
}
