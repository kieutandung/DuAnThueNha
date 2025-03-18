package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.Notification;
import com.example.duanthuenha.Model.ProductHost;
import com.example.duanthuenha.Model.Report;
import com.example.duanthuenha.Model.Users;
import com.example.duanthuenha.Service.Host.ProductImpl;
import com.example.duanthuenha.Service.Host.ProductUserImpl;
import com.example.duanthuenha.Service.Profile.ProfileImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = "/notificationUserServlet")
public class NotificationUserServlet extends HttpServlet {
    ProductUserImpl productUserImpl = new ProductUserImpl();
    ProfileImpl profileImpl = new ProfileImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userID = (String) session.getAttribute("userId");
        int idUser = Integer.parseInt(userID);

        List<Users> senderList = new ArrayList<>();
        List<Notification> notificationList = productUserImpl.getAllNotificationByidUser(idUser);
        req.setAttribute("notificationList", notificationList);

        int unreadCount = 0;
        for (Notification notification : notificationList) {
            if (notification.getStatus().equals("unread")) {
                unreadCount++;
            }
            Users sender = profileImpl.getUserById(notification.getIdUser());
            senderList.add(sender);
        }

        req.setAttribute("unreadCount", unreadCount);
        req.setAttribute("senderList", senderList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/home.jsp");
        dispatcher.forward(req, resp);
    }
}
