package com.example.duanthuenha.Model;

import java.time.LocalDate;

public class Notification {
    private int idNotification;
    private int idUser;
    private String title;
    private String message;
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
