package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.Order;
import com.example.duanthuenha.Service.OrderInformation.OrderInformationImpl;
import com.example.duanthuenha.Service.OrderInformation.OrderInformationService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/orderInformationServlet")
public class OrderInformationServlet extends HttpServlet {
    OrderInformationService orderInformationService = new OrderInformationImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession();
        Object userIDObj = session.getAttribute("userId");

        if (userIDObj == null) {
            resp.sendRedirect("loginServlet");
            return;
        }

        int idUser = Integer.parseInt(userIDObj.toString());
        List<Order> orders = orderInformationService.getAllOrder(idUser);
        req.setAttribute("orders", orders);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/view/user/orderInformation.jsp");
        dispatcher.forward(req, resp);
    }
}

