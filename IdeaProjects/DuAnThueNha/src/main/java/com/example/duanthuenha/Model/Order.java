package com.example.duanthuenha.Model;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;


public class Order {
    private int idOrder;
    private int idUser;
    private int idProduct;
    private LocalDateTime orderDate;
    private LocalDate startDate;
    private LocalDate endDate;
    private String notes;
    private int numPeople;
    private String paymentStatus;

    private String fullName;
    private String phone;
    private String image;
    private String nameProduct;
    private double price;
    private double totalPrice;

    // Constructor đầy đủ
    public Order(int idOrder, int idUser, int idProduct, LocalDateTime orderDate, LocalDate startDate, LocalDate endDate, String notes, int numPeople, String paymentStatus) {
        this.idOrder = idOrder;
        this.idUser = idUser;
        this.idProduct = idProduct;
        this.orderDate = orderDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.notes = notes;
        this.numPeople = numPeople;
        this.paymentStatus = paymentStatus;
    }

    public Order(int idUser, int idProduct, LocalDate startDate, LocalDate endDate, String notes, int numPeople, String paymentStatus) {
        this.idUser = idUser;
        this.idProduct = idProduct;
        this.startDate = startDate;
        this.endDate = endDate;
        this.notes = notes;
        this.numPeople = numPeople;
        this.paymentStatus = paymentStatus;
    }

    public Order() {}
    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getIdOrder() { return idOrder; }
    public void setIdOrder(int idOrder) { this.idOrder = idOrder; }

    public int getIdUser() { return idUser; }
    public void setIdUser(int idUser) { this.idUser = idUser; }

    public int getIdProduct() { return idProduct; }
    public void setIdProduct(int idProduct) { this.idProduct = idProduct; }

    public LocalDateTime getOrderDate() { return orderDate; }
    public void setOrderDate(LocalDateTime orderDate) { this.orderDate = orderDate; }


    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public int getNumPeople() { return numPeople; }
    public void setNumPeople(int numPeople) { this.numPeople = numPeople; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getNameProduct() { return nameProduct; }
    public void setNameProduct(String nameProduct) { this.nameProduct = nameProduct; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    @Override
    public String toString() {
        return "Order{" +
                "idOrder=" + idOrder +
                ", idUser=" + idUser +
                ", idProduct=" + idProduct +
                ", orderDate=" + orderDate +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", notes='" + notes + '\'' +
                ", numPeople=" + numPeople +
                ", paymentStatus='" + paymentStatus + '\'' +
                '}';
    }

    public double calculateTotalPrice() {
        long days = ChronoUnit.DAYS.between(startDate, endDate);
        days = Math.max(days, 1); // Đảm bảo ít nhất 1 ngày
        return days * price;
    }

}
