package com.example.duanthuenha.Service.Admin;

import com.example.duanthuenha.Model.Users;

import java.util.List;

public interface ListAccountService {
    List<Users> getAllUser();
    void deleteUser(int idUser);
    List<Users> searchUsersByName(String name);
    List<Users> getAllUsersSortedByName();
}
