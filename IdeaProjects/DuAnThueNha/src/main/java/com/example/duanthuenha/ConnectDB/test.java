package com.example.duanthuenha.ConnectDB;

import java.sql.Connection;

public class test {
    public static void main(String[] args) {
            ConnectDB connectDB = new ConnectDB();
            Connection connection = connectDB.getConnection();
        System.out.println(connection);
    }
}
