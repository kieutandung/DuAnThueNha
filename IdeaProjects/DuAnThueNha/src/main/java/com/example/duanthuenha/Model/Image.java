package com.example.duanthuenha.Model;

public class Image {
    int idProduct;
    String img;

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
