package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Product;

import java.util.List;

public interface ProductUserService {
    void addProduct(Product product);
    List<Product> getAllProducts();
    Product getAllProductsById(int idProduct);
}
