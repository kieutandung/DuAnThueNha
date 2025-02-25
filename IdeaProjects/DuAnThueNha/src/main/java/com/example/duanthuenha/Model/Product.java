package com.example.duanthuenha.Model;
import java.math.BigDecimal;
import java.util.List;

public class Product {
    private int idProduct;
    private int idUser;
    private String nameProduct;
    private String productDescription;
    private BigDecimal price;
    private String address;
    private String status;
    private String image;

    public Product(int idProduct, int idUser, String nameProduct, String productDescription, BigDecimal price, String address, String status) {
        this.idProduct = idProduct;
        this.idUser = idUser;
        this.nameProduct = nameProduct;
        this.productDescription = productDescription;
        this.price = price;
        this.address = address;
        this.status = status;
    }

    public Product(int idProduct, int idUser, String nameProduct, String productDescription, BigDecimal price, String address, String status, String image) {
        this.idProduct = idProduct;
        this.idUser = idUser;
        this.nameProduct = nameProduct;
        this.productDescription = productDescription;
        this.price = price;
        this.address = address;
        this.status = status;
        this.image = image;
    }

    public Product(String nameProduct, String productDescription, BigDecimal price, String address, String status) {
        this.nameProduct = nameProduct;
        this.productDescription = productDescription;
        this.price = price;
        this.address = address;
        this.status = status;
    }

    public Product(int idUser, String nameProduct, String productDescription, BigDecimal price, String address, String status) {
        this.idUser = idUser;
        this.nameProduct = nameProduct;
        this.productDescription = productDescription;
        this.price = price;
        this.address = address;
        this.status = status;
    }


    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getNameProduct() {
        return nameProduct;
    }

    public void setNameProduct(String nameProduct) {
        this.nameProduct = nameProduct;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
