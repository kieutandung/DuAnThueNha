package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.ProductHost;

import java.util.List;

public interface ProductService {
    int addProduct(ProductHost product);

    void addImage(Image image);

    ProductHost getProduct(int id);

    List<ProductHost> getAllProductsById(int id);

    List<Image> getImagesByProductId(int productId);

    boolean deleteImage(int id);

    void editProduct(ProductHost product);

    List<ProductHost> getAllProductsWithKeyword(int idUser, String keyword);

    void deleteProduct(int id);
}

