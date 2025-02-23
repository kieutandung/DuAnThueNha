package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Product;
import com.example.duanthuenha.ConnectDB.ConnectDB;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ProductImpl implements ProductService {
    private ConnectDB connectDB = new ConnectDB();

    @Override
    public void addProduct(Product product) {
        String query = "INSERT INTO products (idUser, nameProduct, productDescription, price, address, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, product.getIdUser());
            ps.setString(2, product.getNameProduct());
            ps.setString(3, product.getProductDescription());
            ps.setBigDecimal(4, product.getPrice()); // Sử dụng setBigDecimal cho giá trị DECIMAL
            ps.setString(5, product.getAddress());
            ps.setString(6, product.getStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm", e);
        }
    }
}



