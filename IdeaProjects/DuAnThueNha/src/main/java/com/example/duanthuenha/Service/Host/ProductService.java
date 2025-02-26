package com.example.duanthuenha.Service.Host;
import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.Product;

public interface ProductService {
    int addProduct(Product product);
    void addImage(Image image);
}

