package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Product;
import com.example.duanthuenha.ConnectDB.ConnectDB;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
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
            ps.setBigDecimal(4, product.getPrice());
            ps.setString(5, product.getAddress());
            ps.setString(6, product.getStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm", e);
        }
    }

    @Override
    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM products";

        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("idProduct"),
                        rs.getInt("idUser"),
                        rs.getString("nameProduct"),
                        rs.getString("productDescription"),
                        rs.getBigDecimal("price"),
                        rs.getString("address"),
                        rs.getString("status"),
                        rs.getString("image")
                );
                productList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;

    }

    @Override
    public Product getAllProductsById(int id) {
        Product product = null;
        String sql = "SELECT " +
                "p.idProduct, p.nameProduct, p.productDescription, " +
                "p.price, p.address, p.status, p.image AS mainImage, " +
                "u.fullName, u.image AS userImage, " +
                "GROUP_CONCAT(i.img ORDER BY i.idImage SEPARATOR ',') AS additionalImages " +
                "FROM products p " +
                "JOIN users u ON p.idUser = u.idUser " +
                "LEFT JOIN images i ON p.idProduct = i.idProduct " +
                "WHERE p.idProduct = ? " +
                "GROUP BY p.idProduct, p.nameProduct, p.productDescription, p.price, " +
                "p.address, p.status, p.image, u.fullName, u.image;";

        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setIdProduct(rs.getInt("idProduct"));
                product.setNameProduct(rs.getString("nameProduct"));
                product.setProductDescription(rs.getString("productDescription"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setAddress(rs.getString("address"));
                product.setStatus(rs.getString("status"));
                product.setImage(rs.getString("mainImage"));
                product.setOwnerName(rs.getString("fullName"));;
                product.setOwnerImage(rs.getString("userImage"));

                // Xử lý danh sách hình ảnh
                String additionalImages = rs.getString("additionalImages");
                if (additionalImages != null) {
                    List<String> imagesList = Arrays.asList(additionalImages.split(","));
                    product.setAdditionalImages(imagesList);
                } else {
                    product.setAdditionalImages(new ArrayList<>());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }
}



