package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    @Override
    public Product getProduct(int id) {
        String selectProductSQL = "SELECT * FROM products WHERE idProduct = ?";
        Product product = null;
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(selectProductSQL);
            pstm.setInt(1, id);
            try {
                ResultSet rs = pstm.executeQuery();
                {
                    if (rs.next()) {
                        int userId = rs.getInt("idUser");
                        String nameProduct = rs.getString("nameProduct");
                        String productDescription = rs.getString("productDescription");
                        Double price = Double.valueOf(rs.getString("price"));
                        String address = rs.getString("address");
                        String status = rs.getString("status");
                        if (status.equals("active")) {
                            status = "Có thể thuê";
                        }
                        if (status.equals("for rent")) {
                            status = "Đang được cho thuê";
                        }
                        if (status.equals("sold out")) {
                            status = "Hết chỗ";
                        }
                        String image = rs.getString("image");
                        product = new Product(userId, id, nameProduct, productDescription, price, address, status, image);
                        return product;
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<Image> getImagesByProductId(int productId) {
        List<Image> images = new ArrayList<>();
        String query = "SELECT * FROM Images WHERE idProduct = ?";
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(query);
            pstm.setInt(1, productId);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int imageId = rs.getInt("idImage");
                String img = rs.getString("img");
                Image image = new Image(imageId, productId, img);
                images.add(image);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return images;
    }

    @Override
    public boolean deleteImage(int id) {
        String sql = "DELETE FROM images WHERE idImage = ?";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa ảnh có id: " + id, e);
        }
    }

    @Override
    public void editProduct(Product product) {
        String editProduct = "update Products set nameProduct = ?, productDescription = ?, price = ?, address = ?, status = ?, image = ? where idProduct  = ?";

        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(editProduct)) {
            preparedStatement.setString(1, product.getNameProduct());
            preparedStatement.setString(2, product.getProductDescription());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setString(4, product.getAddress());
            preparedStatement.setString(5, product.getStatus());
            preparedStatement.setString(6, product.getImage());
            preparedStatement.setInt(7, product.getIdUser());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Product> getAllProductsWithKeyword(int idUser, String keyword) {
        String sql = "SELECT * FROM products WHERE nameProduct LIKE ? OR address LIKE ? order by idProduct desc";
        List<Product> products = new ArrayList<>();
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, "%" + keyword + "%");
            preparedStatement.setString(2, "%" + keyword + "%");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idProduct = rs.getInt("idProduct");
                String nameProduct = rs.getString("nameProduct");
                String productDescription = rs.getString("productDescription");
                Double price = Double.valueOf(rs.getString("price"));
                String address = rs.getString("address");
                String status = rs.getString("status");
                if (status.equals("active")) {
                    status = "Có thể thuê";
                }
                if (status.equals("for rent")) {
                    status = "Đang được cho thuê";
                }
                if (status.equals("sold out")) {
                    status = "Hết chỗ";
                }

                String image = rs.getString("image");
                Product product = new Product(idUser, idProduct, nameProduct, productDescription, price, address, status, image);

                products.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    @Override
    public void deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE idProduct = ?";
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void deleteImages(int idProduct) {
        String sql = "DELETE FROM images WHERE idProduct = ?";
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, idProduct);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Product> getAllProductsById(int id) {
        List<Product> products = new ArrayList<>();
        String selectProductSQL = "SELECT * FROM products WHERE idUser = ? order by idProduct desc ";
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(selectProductSQL);
            pstm.setInt(1, id);
            try {
                ResultSet rs = pstm.executeQuery();
                {
                    while (rs.next()) {
                        int idProduct = rs.getInt("idProduct");
                        String nameProduct = rs.getString("nameProduct");
                        String productDescription = rs.getString("productDescription");
                        Double price = Double.valueOf(rs.getString("price"));
                        String address = rs.getString("address");
                        String status = rs.getString("status");
                        if (status.equals("active")) {
                            status = "Có thể thuê";
                        }
                        if (status.equals("for rent")) {
                            status = "Đang được cho thuê";
                        }
                        if (status.equals("sold out")) {
                            status = "Hết chỗ";
                        }

                        String image = rs.getString("image");
                        Product product = new Product(id, idProduct, nameProduct, productDescription, price, address, status, image);

                        products.add(product);
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }
}



