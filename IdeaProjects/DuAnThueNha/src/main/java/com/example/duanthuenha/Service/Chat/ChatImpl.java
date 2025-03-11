package com.example.duanthuenha.Service.Chat;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Chat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ChatImpl implements ChatService {
    private ConnectDB connectDB = new ConnectDB();

    @Override
    public void addChat(Chat chat) {
        String query = "INSERT INTO chat (idSender, idReceiver, text) VALUES (?, ?, ?)";
        try (Connection connection = connectDB.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, chat.getIdSender());
            ps.setInt(2, chat.getIdReceiver());
            ps.setString(3, chat.getText());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm", e);
        }
    }

    @Override
    public List<Chat> getChats(String image, String fullname, int idSender, int idReceiver) {
        List<Chat> chats = new ArrayList<>();
        String query = "SELECT *\n" +
                "FROM Chat\n" +
                "WHERE (idSender = ? AND idReceiver = ?)\n" +
                "   OR (idSender = ? AND idReceiver = ?)\n" +
                "ORDER BY createdAt ASC;";
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(query);
            pstm.setInt(1, idSender);
            pstm.setInt(2, idReceiver);
            pstm.setInt(3, idReceiver);
            pstm.setInt(4, idSender);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int idChat = rs.getInt("idChat");
                int idSenderU = rs.getInt("idSender");
                int idReceiverU = rs.getInt("idReceiver");
                String text = rs.getString("text");
                String status = rs.getString("status");
                Chat chat = new Chat(image, fullname, idChat, idSenderU, idReceiverU, text, status);
                chats.add(chat);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return chats;
    }

    @Override
    public List<Chat> getAllChats(int idReceiver) {
        List<Chat> chats = new ArrayList<>();
        String query = "SELECT \n" +
                "    u.image,\n" +
                "    u.fullName,\n" +
                "    u.idUser,\n" +
                "    c.*\n" +
                "FROM Chat c\n" +
                "JOIN (\n" +
                "    SELECT \n" +
                "        CASE \n" +
                "            WHEN idSender = ? THEN idReceiver \n" +
                "            ELSE idSender \n" +
                "        END AS partner,\n" +
                "        MAX(createdAt) AS lastCreatedAt\n" +
                "    FROM Chat\n" +
                "    WHERE idSender = ? OR idReceiver = ?\n" +
                "    GROUP BY partner\n" +
                ") AS lastMsg \n" +
                "    ON ((c.idSender = ? AND c.idReceiver = lastMsg.partner) \n" +
                "        OR (c.idReceiver = ? AND c.idSender = lastMsg.partner))\n" +
                "    AND c.createdAt = lastMsg.lastCreatedAt\n" +
                "JOIN Users u ON u.idUser = lastMsg.partner;";
        try {
            Connection connection = connectDB.getConnection();
            PreparedStatement pstm = connection.prepareStatement(query);
            pstm.setInt(1, idReceiver);
            pstm.setInt(2, idReceiver);
            pstm.setInt(3, idReceiver);
            pstm.setInt(4, idReceiver);
            pstm.setInt(5, idReceiver);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int idUser = rs.getInt("idUser");
                int idChat = rs.getInt("idChat");
                int idSenderU = rs.getInt("idSender");
                int idReceiverU = rs.getInt("idReceiver");
                String text = rs.getString("text");
                String status = rs.getString("status");
                String image = rs.getString("image");
                String fullName = rs.getString("fullName");
                Chat chat = new Chat(idUser,image, fullName, idChat, idSenderU, idReceiverU, text, status);
                chats.add(chat);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return chats;
    }
}
