package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.ProductHost;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductImpl implements ProductService {
    private ConnectDB connectDB = new ConnectDB();

    @Override
    public int addProduct(ProductHost product) {
        int productId = -1;
        String query = "INSERT INTO products (idUser, nameProduct, productDescription, price, address, status,image,category,area) VALUES (?, ?, ?, ?, ?, ?, ?,?,?)";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, product.getIdUser());
            ps.setString(2, product.getNameProduct());
            ps.setString(3, product.getProductDescription());
            ps.setDouble(4, product.getPrice());
            ps.setString(5, product.getAddress());
            ps.setString(6, product.getStatus());
            ps.setString(7, product.getImage());
            ps.setString(8, product.getCategory());
            ps.setDouble(9, product.getArea());
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
    public ProductHost getProduct(int id) {
        String selectProductSQL = "SELECT * FROM products WHERE idProduct = ?";
        ProductHost product = null;
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
                            status = "Hết chỗ";
                        }
                        if (status.equals("sold out")) {
                            status = "Không còn kinh doanh";
                        }
                        String image = rs.getString("image");
                        String category = rs.getString("category");
                        double area = Double.parseDouble(rs.getString("area"));
                        product = new ProductHost(userId, id, nameProduct, productDescription, price, address, status, image, category, area);
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
    public void editProduct(ProductHost product) {
        String editProduct = "update Products set nameProduct = ?, productDescription = ?, price = ?, address = ?, status = ?, image = ?, category = ? where idProduct  = ?";

        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(editProduct)) {
            preparedStatement.setString(1, product.getNameProduct());
            preparedStatement.setString(2, product.getProductDescription());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setString(4, product.getAddress());
            preparedStatement.setString(5, product.getStatus());
            preparedStatement.setString(6, product.getImage());
            preparedStatement.setString(7, product.getCategory());
            preparedStatement.setInt(8, product.getIdUser());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ProductHost> getAllProductsWithKeyword(int idUser, String keyword, int page) {
        String sql = "SELECT * FROM products WHERE idUser = ? and (nameProduct LIKE ? OR address LIKE ?) order by idProduct desc LIMIT 10 OFFSET ? ";
        List<ProductHost> products = new ArrayList<>();
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(2, "%" + keyword + "%");
            preparedStatement.setString(3, "%" + keyword + "%");
            preparedStatement.setInt(4, page);
            preparedStatement.setInt(1, idUser);
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
                    status = "Hết chỗ";
                }
                if (status.equals("sold out")) {
                    status = "Không còn kinh doanh";
                }

                String image = rs.getString("image");
                ProductHost product = new ProductHost(idUser, idProduct, nameProduct, productDescription, price, address, status, image);

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

    @Override
    public List<ProductHost> getAllProductsWithKeywordUser(String keyword, int page) {
        String sql = "SELECT * FROM products WHERE nameProduct LIKE ? OR address LIKE ? OR area = ? order by idProduct desc LIMIT 10 OFFSET ?";
        List<ProductHost> products = new ArrayList<>();
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, "%" + keyword + "%");
            preparedStatement.setString(2, "%" + keyword + "%");
            preparedStatement.setString(3, keyword);
            preparedStatement.setInt(4, (page - 1) * 10);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idUser = 0;
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
                    status = "Hết chỗ";
                }
                if (status.equals("sold out")) {
                    status = "Không còn kinh doanh";
                }
                String image = rs.getString("image");
                String category = rs.getString("category");
                double area = Double.parseDouble(rs.getString("area"));
                ProductHost product = new ProductHost(idUser, idProduct, nameProduct, productDescription, price, address, status, image, category, area);
                products.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    @Override
    public List<ProductHost> getAllProducts() {
        List<ProductHost> productList = new ArrayList<>();
        String query = "SELECT * FROM products order by idProduct desc ";

        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int idUser = rs.getInt("idUser");
                int idProduct = rs.getInt("idProduct");
                String nameProduct = rs.getString("nameProduct");
                String productDescription = rs.getString("productDescription");
                Double price = Double.valueOf(rs.getString("price"));
                String address = rs.getString("address");
                String status = rs.getString("status");
                if (status.equals("active")) {
                    status = "Có thể thuê";
                } else {
                    status = "Hết chỗ";
                }
                String image = rs.getString("image");
                String category = rs.getString("category");
                double area = Double.parseDouble(rs.getString("area"));

                ProductHost product = new ProductHost(idUser, idProduct, nameProduct, productDescription, price, address, status, image, category, area);
                productList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public List<ProductHost> getAllProductsWithCategoryUser(String category, int page) {
        String sql = "SELECT * FROM products WHERE category LIKE ? order by idProduct desc LIMIT 10 OFFSET ?";
        List<ProductHost> products = new ArrayList<>();
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, "%" + category + "%");
            preparedStatement.setInt(2, (page - 1) * 10);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idUser = 0;
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
                    status = "Hết chỗ";
                }
                if (status.equals("sold out")) {
                    status = "Không còn kinh doanh";
                }
                String image = rs.getString("image");
                String categoryU = rs.getString("category");
                double area = Double.parseDouble(rs.getString("area"));
                ProductHost product = new ProductHost(idUser, idProduct, nameProduct, productDescription, price, address, status, image, categoryU, area);

                products.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    @Override
    public List<ProductHost> getAllProductsWithCategoryAndKeywordUser(String keyword, String category, int page) {
        String sql = "SELECT * FROM products WHERE category = ? and nameProduct LIKE ? OR address LIKE ? or area = ? order by idProduct desc LIMIT 10 OFFSET ?";
        List<ProductHost> products = new ArrayList<>();
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, category);
            preparedStatement.setString(2, "%" + keyword + "%");
            preparedStatement.setString(3, "%" + keyword + "%");
            preparedStatement.setString(4, keyword);
            preparedStatement.setInt(5, (page - 1) * 10);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idUser = 0;
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
                    status = "Hết chỗ";
                }
                if (status.equals("sold out")) {
                    status = "Không còn kinh doanh";
                }
                String image = rs.getString("image");
                String categoryU = rs.getString("category");
                double area = Double.parseDouble(rs.getString("area"));

                ProductHost product = new ProductHost(idUser,idProduct, nameProduct, productDescription, price, address, status, image, categoryU, area);

                products.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    @Override
    public int getTotalProducts() {
        String query = "SELECT count(*) FROM products";
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public int getTotalProductsCategory(String category) {
        String query = "SELECT count(*) FROM products WHERE category = ? order by idProduct desc";
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, category);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public int getTotalProductsKeyword(String keyword) {
        String query = "SELECT count(*) FROM products WHERE nameProduct LIKE ? OR address LIKE ? OR area = ? order by idProduct desc";
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, "%" + keyword + "%");
            preparedStatement.setString(2, "%" + keyword + "%");
            preparedStatement.setString(3, keyword);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public int getTotalProductsCategoryAndKeyword(String keyword, String category) {
        String query = "SELECT count(*) FROM products WHERE category = ? and nameProduct LIKE ? OR address LIKE ? or area = ? order by idProduct desc";
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, category);
            preparedStatement.setString(2, "%" + keyword + "%");
            preparedStatement.setString(3, "%" + keyword + "%");
            preparedStatement.setString(4, keyword );
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public int getTotalProductsHost(int idUser) {
       String query = "SELECT count(*) FROM products WHERE idUser = ? order by idProduct desc";
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, idUser);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public int getTotalProductsSearchHost(int idUser, String keyword) {
       String query = "SELECT count(*) FROM products WHERE idUser = ? and  (nameProduct LIKE ? OR address LIKE ?) order by idProduct desc";
        try (Connection connection = connectDB.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, idUser);
            preparedStatement.setString(2, "%" + keyword + "%");
            preparedStatement.setString(3, "%" + keyword + "%");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public List<ProductHost> getProductsPage(int page) {
        List<ProductHost> productList = new ArrayList<>();
        String query = "SELECT * FROM products\n" +
                "ORDER BY idProduct DESC\n" +
                "LIMIT 10 OFFSET ?; ";

        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
        ) {
            stmt.setInt(1, (page - 1) * 10);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int idUser = rs.getInt("idUser");
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
                    status = "Hết chỗ";
                }
                if (status.equals("sold out")) {
                    status = "Không còn kinh doanh";
                }
                String image = rs.getString("image");
                String category = rs.getString("category");
                double area = Double.parseDouble(rs.getString("area"));

                ProductHost product = new ProductHost(idUser, idProduct, nameProduct, productDescription, price, address, status, image, category, area);
                productList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public void stopSelling(int product) {
        try (Connection connection = connectDB.getConnection()) {
            String query = "UPDATE products SET status = ? WHERE idProduct = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "sold out");
            ps.setInt(2, product);
            ps.executeUpdate();
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
    public List<ProductHost> getAllProductsById(int id, int page) {
        List<ProductHost> products = new ArrayList<>();
        String selectProductSQL = "SELECT * FROM products WHERE idUser = ? order by idProduct desc LIMIT 10 OFFSET ?; ";
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(selectProductSQL);
            pstm.setInt(1, id);
            pstm.setInt(2, (page - 1) * 10);
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
                            status = "Hết chỗ";
                        }
                        if (status.equals("sold out")) {
                            status = "Không còn kinh doanh";
                        }

                        String image = rs.getString("image");
                        ProductHost product = new ProductHost(id, idProduct, nameProduct, productDescription, price, address, status, image);

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



