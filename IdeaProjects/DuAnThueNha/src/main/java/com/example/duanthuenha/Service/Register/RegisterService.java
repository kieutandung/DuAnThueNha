package com.example.duanthuenha.Service.Register;

public interface RegisterService {
    boolean checkUsername(String username);

    boolean registerUser(String userName, String password, String fullName, String phone, String email);
}
