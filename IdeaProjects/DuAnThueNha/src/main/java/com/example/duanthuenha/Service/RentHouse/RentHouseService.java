package com.example.duanthuenha.Service.RentHouse;

import com.example.duanthuenha.Model.Order;

public interface RentHouseService {
    Order addRentHouse(int idUser, int idProduct, String startDate, String endDate, String notes, int numPeople);
}
