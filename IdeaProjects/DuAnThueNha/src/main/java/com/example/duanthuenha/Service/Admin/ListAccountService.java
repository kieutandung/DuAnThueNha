package com.example.duanthuenha.Service.Admin;

import com.example.duanthuenha.Model.Users;
import com.example.duanthuenha.Model.Verification;

import java.util.List;

public interface ListAccountService {
    List<Users> getAllUser();
    void deleteUser(int idUser);
    List<Users> searchUsersByName(String name);

    Users addUser(String username, String password, String fullName, String phone, String email, String role);

    List<Users> getAllUsersSortedByName();
    void updateUser(String username, String fullName, String phone, String email, String password, String role, String status,int idUser);
    Users getUserById(int id);
    List<Verification> getAllVerification();
    List<Verification> getVerificationsByUserId(int idUser);
    boolean promoteUser(int idUser);
    boolean updateVerificationStatus(int idDocument, String status, String rejectionReason);
}
