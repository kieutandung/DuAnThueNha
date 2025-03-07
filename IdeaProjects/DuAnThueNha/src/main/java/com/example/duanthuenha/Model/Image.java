package com.example.duanthuenha.Model;

public class Image {
    public int getIdImage() {
        return idImage;
    }

    public void setIdImage(int idImage) {
        this.idImage = idImage;
    }

    int idImage;
    int idProduct;
    String img;

    public Image(int idImage, int idProduct, String img) {
        this.idImage = idImage;
        this.idProduct = idProduct;
        this.img = img;
    }

    public Image(int idProduct, String img) {
        this.idProduct = idProduct;
        this.img = img;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
}
