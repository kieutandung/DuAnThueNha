package com.example.duanthuenha.Service.Admin;

import com.example.duanthuenha.Model.Notification;

import com.example.duanthuenha.Model.Order;
import com.example.duanthuenha.Model.Product;

import com.example.duanthuenha.Model.Report;

import com.example.duanthuenha.Model.Users;
import com.example.duanthuenha.Model.Verification;


import java.util.List;
import java.util.Map;

public interface ListAccountService {
    List<Users> getAllUser();
    void deleteUser(int idUser);
    List<Users> searchUsersByName(String name);

    Users addUser(String username, String password, String fullName, String phone, String email, String role);

    List<Users> getAllUsersSortedByName();
    void updateUser(String username, String fullName, String phone, String email, String password, String role, String status,int idUser);
    Users getUserById(int id);
    List<Verification> getVerificationsByUserId(int idUser);
    boolean promoteUser(int idUser);
    boolean updateStatus(int idDocument, String status, String rejectionReason);
    Map<Integer, Double> getRevenueByMonth();
    List<Order> getAllOrder();
    Map<String, Integer> getOrderStatusCount();
    List<Product> getTopRentedProducts();
    List<Users> getAllUserByIdDocument();
    List<Report> getAllReport();
    Users getUserByidProduct(int idProduct);
    void sendFeedback(Notification notification);
    boolean updateVerificationStatus(int idDocument, String action, String reason);
}

