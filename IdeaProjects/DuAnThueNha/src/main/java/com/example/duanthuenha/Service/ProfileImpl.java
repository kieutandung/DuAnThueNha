package com.example.duanthuenha.Service;


import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Users;
import com.mysql.cj.jdbc.DatabaseMetaData;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfileImpl implements ProfileService {
    private ConnectDB connectDB = new ConnectDB();

    public List<Users> getUserById() {
        List<Users> users = new ArrayList<>();
        String sql = "SELECT * FROM users where id=?";
        try {
            PreparedStatement ps = connectDB.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String userName = rs.getString("userName");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String image = rs.getString("image");
                System.out.println(userName + fullName + phone + email + image);
                Users users1 = new Users(userName, fullName, phone, email,image);
                users.add(users1);

            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }

}