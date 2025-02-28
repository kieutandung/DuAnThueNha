package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.Product;

import java.util.List;

public interface ProductService {

    int addProduct(Product product);

    void addImage(Image image);

    Product getProduct(int id);

    List<Product> getAllProductsById(int id);

    List<Image> getImagesByProductId(int productId);

    boolean deleteImage(int id);

    void editProduct(Product product);

    List<Product> getAllProductsWithKeyword(int idUser, String keyword);

    void deleteProduct(int id);
}

