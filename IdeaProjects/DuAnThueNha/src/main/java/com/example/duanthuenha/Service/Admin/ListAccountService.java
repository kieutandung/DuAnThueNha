package com.example.duanthuenha.Service.Admin;

import com.example.duanthuenha.Model.Users;

import java.util.List;

public interface ListAccountService {
    List<Users> getAllUser();
    void deleteUser(int idUser);
    List<Users> searchUsersByName(String name);
    boolean addUser(String username, String password, String fullName, String phone, String email, String role);
}
