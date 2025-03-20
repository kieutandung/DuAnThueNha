package com.example.duanthuenha.Service.Host;

import com.example.duanthuenha.Model.Order;
import com.example.duanthuenha.Model.Product;

import java.util.List;
import java.util.Map;

public interface RevenueService {
    List<Order> getAllOrderByIdUser(int idUser);
    Map<Integer, Double> getRevenueByMonth(int idUser);
    List<Product> getTopRentedHouses();
}
