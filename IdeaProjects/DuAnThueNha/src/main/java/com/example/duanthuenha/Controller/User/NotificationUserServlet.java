package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.Notification;
import com.example.duanthuenha.Service.Host.ProductUserImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/notificationUserServlet")
public class NotificationUserServlet extends HttpServlet {
    ProductUserImpl productUserImpl = new ProductUserImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userID = (String) session.getAttribute("userId");
        int idUser = Integer.parseInt(userID);
        List<Notification> notificationList = productUserImpl.getAllNotificationByidUser(idUser);
        req.setAttribute("notificationList", notificationList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/view/header.jsp");
        dispatcher.forward(req, resp);
    }
}
