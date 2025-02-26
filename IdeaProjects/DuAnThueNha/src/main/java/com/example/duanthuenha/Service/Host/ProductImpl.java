package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.Product;

import java.sql.*;

public class ProductImpl implements ProductService {
    private ConnectDB connectDB = new ConnectDB();

    @Override
    public int addProduct(Product product) {
        int productId = -1;
        String query = "INSERT INTO products (idUser, nameProduct, productDescription, price, address, status,image) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, product.getIdUser());
            ps.setString(2, product.getNameProduct());
            ps.setString(3, product.getProductDescription());
            ps.setDouble(4, product.getPrice());
            ps.setString(5, product.getAddress());
            ps.setString(6, product.getStatus());
            ps.setString(7, product.getImage());
            int checkRow = ps.executeUpdate();
            if (checkRow > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    productId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm", e);
        }
        return productId;
    }

    @Override
    public void addImage(Image image) {
        String insertImageSQL = "INSERT INTO Images (idProduct, img) VALUES (?, ?)";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(insertImageSQL)) {
            ps.setInt(1, image.getIdProduct());
            ps.setString(2, image.getImg());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm", e);
        }
    }
}



