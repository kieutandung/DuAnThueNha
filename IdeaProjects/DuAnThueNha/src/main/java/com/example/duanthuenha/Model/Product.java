package com.example.duanthuenha.Model;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

public class Product {
    private int idProduct;
    private int idUser;
    private String nameProduct;
    private String productDescription;
    private BigDecimal price;
    private String address;
    private String status;
    private String image;
    private String ownerName;
    private String ownerImage;
    private List<String> additionalImages;

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


    public Product(int idUser, String nameProduct, String productDescription, BigDecimal price, String address, String status) {
        this.idUser = idUser;
        this.nameProduct = nameProduct;
        this.productDescription = productDescription;
        this.price = price;
        this.address = address;
        this.status = status;
    }

    public Product() {

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

//    public String getStatus() {
//        return status;
//    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }


    public String getOwnerImage() {
        return ownerImage;
    }

    public void setOwnerImage(String ownerImage) {
        this.ownerImage = ownerImage;
    }

    public List<String> getAdditionalImages() {
        return additionalImages;
    }

    public void setAdditionalImages(List<String> additionalImages) {
        this.additionalImages = additionalImages;
    }

    public String getFormattedPrice() {
        NumberFormat currencyFormatter = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
        return currencyFormatter.format(price) + " VNĐ";
    }

    public String getStatus() {
        switch (this.status) {
            case "active":
                return "Đang hoạt động";
            case "for rent":
                return "Cho thuê";
            case "sold out":
                return "Đã bán";
            default:
                return "Không xác định";
        }
    }

}
