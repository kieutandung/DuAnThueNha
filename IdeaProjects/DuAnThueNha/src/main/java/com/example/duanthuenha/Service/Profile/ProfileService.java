package com.example.duanthuenha.Service.Profile;


import com.example.duanthuenha.Model.Users;

public interface ProfileService {

    Users getUserById(int idUser);

    void UpdateInformation(Users updatedUser);


}

