package com.example.duanthuenha.Model;

import java.time.LocalDate;

public class Notification {
    private int idNotification;
    private int idUser;
    private String title;
    private String message;
    private String type;
    private String status;
    private int idReceiver;

    public int getIdReceiver() {
        return idReceiver;
    }

    public void setIdReceiver(int idReceiver) {
        this.idReceiver = idReceiver;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Notification(int idNotification, int idUser, String title, String message, String type, String status) {
        this.idNotification = idNotification;
        this.idUser = idUser;
        this.title = title;
        this.message = message;
        this.type = type;
        this.status = status;
    }
    public Notification(int idNotification, int idUser, String title, String message, String type, String status,int idReceiver) {
        this.idNotification = idNotification;
        this.idUser = idUser;
        this.title = title;
        this.message = message;
        this.type = type;
        this.status = status;
        this.idReceiver = idReceiver;
    }

    private LocalDate time;

    public Notification(int idNotification, int idUser, String title, String message, LocalDate time) {
        this.idNotification = idNotification;
        this.idUser = idUser;
        this.title = title;
        this.message = message;
        this.time = time;
    }

    public Notification(int idUser, String title, String message) {
        this.idUser = idUser;
        this.title = title;
        this.message = message;
    }

    public Notification(int idUser, String title, String message, String type) {
        this.idUser = idUser;
        this.title = title;
        this.message = message;
        this.type = type;
    }

    public Notification(int idUser, String title, String message, String type, int idReceiver) {
        this.idUser = idUser;
        this.title = title;
        this.message = message;
        this.type = type;
        this.idReceiver = idReceiver;
    }

    public int getIdNotification() {
        return idNotification;
    }

    public void setIdNotification(int idNotification) {
        this.idNotification = idNotification;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public LocalDate getTime() {
        return time;
    }

    public void setTime(LocalDate time) {
        this.time = time;
    }

}
