package com.example.duanthuenha.Service.ForgotPassword;

public interface ForgotPasswordService {
    String checkfullNameWithPhone(String phone);
    boolean updatePassword(String phone, String newPassword);
}
