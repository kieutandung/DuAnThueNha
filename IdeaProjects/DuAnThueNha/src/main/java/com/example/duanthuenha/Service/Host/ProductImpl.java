package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Product;
import com.example.duanthuenha.ConnectDB.ConnectDB;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    @Override
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection conn = connectDB.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM product")) {

            while (rs.next()) {
                products.add(new Product(
//                        rs.getInt("id"),
                        rs.getString("nameProduct"),
                        rs.getString("productDescription"),
                        rs.getBigDecimal("price"),
                        rs.getString("address"),
                        rs.getString("status")
//                        rs.getString("image")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public Product getAllProductsById(int idProduct) {
        Product products = null;
        try {
            Connection conn = connectDB.getConnection();
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idProduct);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                products = new Product(
//                        rs.getInt("id"),
                        rs.getString("nameProduct"),
                        rs.getString("productDescription"),
                        rs.getBigDecimal("price"),
                        rs.getString("address"),
                        rs.getString("status")
//                        rs.getString("image")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
}




