package com.example.duanthuenha.Model;

public class Product {
    private int idUser;
    private int idProduct;
    private String nameProduct;
    private String productDescription;
    private Double price;
    private String address;

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    private String status;
    private String image;

    public Product(int idUser, String nameProduct, String productDescription, Double price, String address, String status, String image) {
        this.idUser = idUser;
        this.nameProduct = nameProduct;
        this.productDescription = productDescription;
        this.price = price;
        this.address = address;
        this.status = status;
        this.image = image;
    }

    public Product(int idUser, int idProduct, String nameProduct, String productDescription, Double price, String address, String status, String image) {
        this.idUser = idUser;
        this.idProduct = idProduct;
        this.nameProduct = nameProduct;
        this.productDescription = productDescription;
        this.price = price;
        this.address = address;
        this.status = status;
        this.image = image;
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
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
