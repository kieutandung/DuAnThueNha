package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Notification;
import com.example.duanthuenha.Model.Product;
import com.example.duanthuenha.Model.Report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ProductUserImpl implements ProductUserService {
    private ConnectDB connectDB = new ConnectDB();


    public void addReport(Report report) {
        String query = "INSERT INTO report (idProduct, idUser,reason,description) VALUES (?, ?, ?, ?)";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, report.getIdProduct());
            ps.setInt(2, report.getIdUser());
            ps.setString(3, report.getReason());
            ps.setString(4, report.getDescription());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm", e);
        }
    }

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
                        rs.getString("image"),
                        rs.getString("category"),
                        rs.getDouble("area")
                );
                productList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }


    @Override
    public Product getAllProductsById(int idProduct) {
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
            stmt.setInt(1, idProduct);
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
                product.setOwnerName(rs.getString("fullName"));
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

    @Override
    public boolean isFavorite(int userId, int productId) {
        String checkSql = "SELECT * FROM favorites WHERE userId = ? AND productId = ?";
        try (Connection conn = connectDB.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void addFavorite(int userId, int productId) {
        String insertSql = "INSERT INTO favorites (userId, productId) VALUES (?, ?)";
        try (Connection conn = connectDB.getConnection();
             PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, productId);
            insertStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeFavorite(int userId, int productId) {
        String deleteSql = "DELETE FROM favorites WHERE userId = ? AND productId = ?";
        try (Connection conn = connectDB.getConnection();
             PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
            deleteStmt.setInt(1, userId);
            deleteStmt.setInt(2, productId);
            deleteStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean toggleFavorite(int userId, int productId) {
        if (isFavorite(userId, productId)) {
            removeFavorite(userId, productId);
            return false;
        } else {
            addFavorite(userId, productId);
            return true;
        }
    }

    @Override
    public List<Product> getAllProductsByFavorite(int idUser) {
        List<Product> favoriteProducts = new ArrayList<>();
        String sql = "SELECT p.idProduct, p.idUser, p.nameProduct, p.productDescription, p.price, " +
                "p.address, p.status, p.image, p.category, p.area, COUNT(f.userId) AS totalLikes " +
                "FROM products p " +
                "JOIN favorites f ON p.idProduct = f.productId " +
                "WHERE f.userId = ? " +
                "GROUP BY p.idProduct, p.idUser, p.nameProduct, p.productDescription, p.price, " +
                "p.address, p.status, p.image, p.category, p.area " +
                "ORDER BY totalLikes DESC";

        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idUser);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("idProduct"),
                        rs.getInt("idUser"),
                        rs.getString("nameProduct"),
                        rs.getString("productDescription"),
                        rs.getBigDecimal("price"),
                        rs.getString("address"),
                        rs.getString("status"),
                        rs.getString("image"),
                        rs.getString("category"),
                        rs.getDouble("area")
                );
                favoriteProducts.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return favoriteProducts;
    }

    @Override
    public void complaint(int idUser, int idProduct, String description) {
        String sql = "INSERT INTO complaints (idUser, idProduct, complaintDate, description, status) " +
                "VALUES (?, ?, NOW(), ?, 'pending')";

        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, idUser);
            ps.setInt(2, idProduct);
            ps.setString(3, description);

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi gửi khiếu nại", e);
        }
    }

    @Override
    public List<Notification> getAllNotificationByidUser(int idUser) {
        String selectSQL = "SELECT * FROM notification WHERE idReceiver = ?";
        List<Notification> notificationList = new ArrayList<>();

        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(selectSQL);
            pstm.setInt(1, idUser);
            try {
                ResultSet rs = pstm.executeQuery();
                {
                    while (rs.next()) {
                        int idNotification = rs.getInt("idNotification");
                        String title = rs.getString("title");
                        String content = rs.getString("content");
                        String type = rs.getString("type");
                        String status = rs.getString("status");
                        int idReceiver = rs.getInt("idReceiver");
                        Notification notification = new Notification(idNotification, idUser, title, content, type, status, idReceiver);
                        notificationList.add(notification);
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return notificationList;
    }
}

