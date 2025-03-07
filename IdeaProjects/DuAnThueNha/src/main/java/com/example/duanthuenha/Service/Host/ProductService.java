package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.ProductHost;

import java.util.List;

public interface ProductService {
    int addProduct(ProductHost product);

    void addImage(Image image);

    ProductHost getProduct(int id);

    List<ProductHost> getAllProductsById(int id, int page);

    List<Image> getImagesByProductId(int productId);

    boolean deleteImage(int id);

    void editProduct(ProductHost product);

    List<ProductHost> getAllProductsWithKeyword(int idUser, String keyword, int page);

    void deleteProduct(int id);

    List<ProductHost> getAllProductsWithKeywordUser(String keyword, int page);

    List<ProductHost> getAllProductsWithCategoryUser(String category, int page);

    List<ProductHost> getAllProductsWithCategoryAndKeywordUser(String keyword, String category, int page);

    List<ProductHost> getAllProducts();

    int getTotalProducts();

    int getTotalProductsCategory(String category);

    int getTotalProductsKeyword(String keyword);

    int getTotalProductsCategoryAndKeyword(String keyword, String category);

    int getTotalProductsHost(int idUser);

     int getTotalProductsSearchHost(int idUser, String keyword);

    List<ProductHost> getProductsPage(int page);
}

