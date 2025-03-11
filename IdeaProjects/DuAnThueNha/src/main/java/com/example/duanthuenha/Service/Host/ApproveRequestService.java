package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Order;

import java.util.List;

public interface ApproveRequestService {
    List<Order> getAllRentalRequestsByHost(int userID);
    void updateStatus(int orderId, String newStatus);
}
