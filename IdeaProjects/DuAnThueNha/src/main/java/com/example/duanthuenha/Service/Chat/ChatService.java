package com.example.duanthuenha.Service.Chat;

import com.example.duanthuenha.Model.Chat;

import java.util.List;

public interface ChatService {
    void addChat(Chat chat);

    List<Chat> getChats(String image, String fullname, int idSender, int idReceiver);

    List<Chat> getAllChats(int idReceiver);
}
