package com.example.duanthuenha.Model;

public class Product {
    private int idProduct;
    private int idUser;
    private String nameProduct;
    private String productDescription;
    private int price;
    private String address;
    private String status;

    public Product(int idProduct, int idUser, String nameProduct, String productDescription, int price, String address, String status) {
        this.idProduct = idProduct;
        this.idUser = idUser;
        this.nameProduct = nameProduct;
        this.productDescription = productDescription;
        this.price = price;
        this.address = address;
        this.status = status;
    }
    public Product(int idUser, String nameProduct, String productDescription, int price, String address, String status) {
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

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
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
}
