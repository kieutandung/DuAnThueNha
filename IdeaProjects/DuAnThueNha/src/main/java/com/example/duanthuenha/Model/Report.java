package com.example.duanthuenha.Model;

import java.time.LocalDate;

public class Report {
    private int idReport;
    private int idProduct;
    private int idUser;
    private String description;
    private String status;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Report(int idReport, int idProduct, int idUser, String description, String status, LocalDate reportDate) {
        this.idReport = idReport;
        this.idProduct = idProduct;
        this.idUser = idUser;
        this.description = description;
        this.status = status;
        this.reportDate = reportDate;
    }

    public Report(int idProduct, int idUser, String description) {
        this.idProduct = idProduct;
        this.idUser = idUser;
        this.description = description;
    }

    public LocalDate getReportDate() {
        return reportDate;
    }

    public void setReportDate(LocalDate reportDate) {
        this.reportDate = reportDate;
    }

    public int getIdReport() {
        return idReport;
    }

    public void setIdReport(int idReport) {
        this.idReport = idReport;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    private LocalDate reportDate;

}
