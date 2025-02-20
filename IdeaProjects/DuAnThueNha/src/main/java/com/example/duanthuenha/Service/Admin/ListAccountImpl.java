package com.example.duanthuenha.Service.Admin;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ListAccountImpl implements ListAccountService{
    private ConnectDB connectDB = new ConnectDB();
    @Override
    public List<Users> getAllUser() {
        Connection connection = connectDB.getConnection();
        List<Users> users = new ArrayList<>();
        String query = "select * from users order by idUser desc";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                int idUser = rs.getInt("idUser");
                String userName = rs.getString("userName");
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String image = rs.getString("image");
                Users user = new Users(idUser,userName,password,fullName,phone,email,role,status,image);
                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }
}
