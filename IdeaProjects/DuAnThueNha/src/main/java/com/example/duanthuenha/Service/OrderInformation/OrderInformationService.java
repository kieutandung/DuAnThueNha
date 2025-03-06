package com.example.duanthuenha.Service.OrderInformation;

import com.example.duanthuenha.Model.Order;

import java.util.List;

public interface OrderInformationService {
    List<Order> getAllOrder(int idUser);
}
