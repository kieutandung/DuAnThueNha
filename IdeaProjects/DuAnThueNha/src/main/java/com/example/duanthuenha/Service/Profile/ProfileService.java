package com.example.duanthuenha.Service.Profile;


import com.example.duanthuenha.Model.Users;

public interface ProfileService {

    Users getUserById(int idUser);

    void UpdateInformation(Users updatedUser);

    void addVerification(int idUser, String documentType, String documentNumber, String documentImage);

}

