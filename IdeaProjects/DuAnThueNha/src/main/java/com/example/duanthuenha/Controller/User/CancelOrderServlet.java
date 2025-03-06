package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Service.OrderInformation.OrderInformationImpl;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {
    private final OrderInformationImpl orderService = new OrderInformationImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idOrder = Integer.parseInt(request.getParameter("idOrder"));

        orderService.cancelOrder(idOrder);

        response.sendRedirect("/orderInformationServlet");
    }
}
