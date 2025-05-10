package com.example.duanthuenha.Model;

public class Chat {
    private int idChat;
    private int idUser;

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    private int idSender;
    private int idReceiver;
    private String text;
    private String status;

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    private String image;
    private String fullName;

    public Chat(int idChat, int idSender, int idReceiver, String text, String status, String time) {
        this.idChat = idChat;
        this.idSender = idSender;
        this.idReceiver = idReceiver;
        this.text = text;
        this.status = status;
        this.time = time;
    }

    public Chat(int idSender, int idReceiver, String text) {
        this.idSender = idSender;
        this.idReceiver = idReceiver;
        this.text = text;
    }

    public Chat(int idUser, String image, String fullName, int idChat, int idSender, int idReceiver, String text, String status) {
        this.idUser = idUser;
        this.image = image;
        this.fullName = fullName;
        this.idChat = idChat;
        this.idSender = idSender;
        this.idReceiver = idReceiver;
        this.text = text;
        this.status = status;

    }

    public Chat(int idChat, int idSender, int idReceiver, String text, String status) {
        this.idChat = idChat;
        this.idSender = idSender;
        this.idReceiver = idReceiver;
        this.text = text;
        this.status = status;
    }

    public Chat(String image, String fullName, int idChat, int idSender, int idReceiver, String text, String status) {
        this.image = image;
        this.fullName = fullName;
        this.idChat = idChat;
        this.idSender = idSender;
        this.idReceiver = idReceiver;
        this.text = text;
        this.status = status;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getIdReceiver() {
        return idReceiver;
    }

    public void setIdReceiver(int idReceiver) {
        this.idReceiver = idReceiver;
    }

    public int getIdSender() {
        return idSender;
    }

    public void setIdSender(int idSender) {
        this.idSender = idSender;
    }

    public int getIdChat() {
        return idChat;
    }

    public void setIdChat(int idChat) {
        this.idChat = idChat;
    }

    private String time;

}
