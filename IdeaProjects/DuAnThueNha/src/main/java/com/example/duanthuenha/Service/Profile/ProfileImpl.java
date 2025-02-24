package com.example.duanthuenha.Service.Profile;


import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProfileImpl implements ProfileService {
    private ConnectDB connectDB = new ConnectDB();

    @Override
    public Users getUserById(int idUser) {
        String sql = "select * from users where idUser = ?";
        Users users = null;
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, idUser);
            try {
                ResultSet rs = pstm.executeQuery();
                {
                    if (rs.next()) {
                        String username = rs.getString("username");
                        String password = rs.getString("password");
                        String fullName = rs.getString("fullName");
                        String phone = rs.getString("phone");
                        String email = rs.getString("email");
                        String image = rs.getString("image");
                        String birthDate = rs.getString("birthDate");
                        String address = rs.getString("address");
                        String gender = rs.getString("gender");
                        if (gender != null && gender.equals("male")) {
                            gender = "Nam";
                        }
                        if (gender != null && gender.equals("female")) {
                            gender = "Nữ";
                        }
                        if (gender != null && gender.equals("other")) {
                            gender = "Khác";
                        }
                        users = new Users(idUser, username, password, fullName, phone, email, image, birthDate, address, gender);
                        return users;
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public void UpdateInformation(Users users) {
        String query = "UPDATE users SET fullName = ?, phone = ?, email = ?, birthDate = ?, address = ? , gender = ? ,image = ? ,password = ? WHERE idUser = ?";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, users.getFullName());
            stmt.setString(2, users.getPhone());
            stmt.setString(3, users.getEmail());
            stmt.setString(4, users.getBirthDate());
            stmt.setString(5, users.getAddress());
            stmt.setString(6, users.getGender());
            stmt.setString(7, users.getImage());
            stmt.setString(8, users.getPassword());
            stmt.setInt(9, users.getIdUser());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addVerification(int idUser, String documentType, String documentNumber, String documentImage) {
        String query = "insert into verificationdocument (userId, documentType, documentNumber, documentImage) values (?,?,?,?)";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, idUser);
            stmt.setString(2, documentType);
            stmt.setString(3, documentNumber);
            stmt.setString(4, documentImage);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }


    public List<Users> getALlDocumentNumberUser(int id) {
        List<Users> users = new ArrayList<>();
        String query = "select * from verificationdocument where userId = ?";
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(query);
            pstm.setInt(1, id);
            try {
                ResultSet rs = pstm.executeQuery();
                {
                    while (rs.next()) {
                        int userId = rs.getInt("userId");
                        String documentType = rs.getString("documentType");

                        if (documentType.equals("ID Card")) {
                            documentType = "Căn cước công dân";
                        }
                        if (documentType.equals("Passport")) {
                            documentType = "Hộ Chiếu";
                        }
                        if (documentType.equals("Business License")) {
                            documentType = "Giấy phép kinh doanh";
                        }
                        if (documentType.equals("House Ownership Certificate")) {
                            documentType = "Giấy chứng nhận quyền sở hữu nhà";
                        }
                        if (documentType.equals("Other")) {
                            documentType = "Khác";
                        }

                        String documentNumber = rs.getString("documentNumber");
                        String status = rs.getString("status");

                        if (status.equals("approved")) {
                            status = "Đã được chấp thuận";
                        }
                        if (status.equals("pending")) {
                            status = "Đang chờ duyệt";
                        }
                        if (status.equals("rejected")) {
                            status = "Không hợp lệ";
                        }

                        Users user = new Users(userId, documentType, documentNumber, status);
                        users.add(user);
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }
}