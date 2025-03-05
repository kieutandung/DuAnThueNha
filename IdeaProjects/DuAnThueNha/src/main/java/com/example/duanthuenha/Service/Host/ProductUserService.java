package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.Product;
import com.example.duanthuenha.Model.ProductHost;

import java.util.List;

public interface ProductUserService {
    void addProduct(Product product);
    List<Product> getAllProducts();
    Product getAllProductsById(int idProduct);
    boolean isFavorite(int userId, int productId);
    boolean toggleFavorite(int idProduct, int idUser);
    List<Product> getAllProductsByFavorite(int idUser);
}
