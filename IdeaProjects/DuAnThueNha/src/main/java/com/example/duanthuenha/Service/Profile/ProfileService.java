package com.example.duanthuenha.Service.Profile;


import com.example.duanthuenha.Model.Users;

public interface ProfileService {

    Users getUserById(int idUser);

    void UpdateInformation(Users updatedUser);

    void addVerification(Users addVerification);

    Users getVerificatioUser(int id);


}

