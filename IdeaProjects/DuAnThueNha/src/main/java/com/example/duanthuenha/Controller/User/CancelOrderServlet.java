package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Service.OrderInformation.OrderInformationImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    private final OrderInformationImpl orderService = new OrderInformationImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idOrder = Integer.parseInt(request.getParameter("idOrder"));

        try {
            orderService.cancelOrder(idOrder);
            response.sendRedirect("/orderInformationServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Có lỗi xảy ra khi hủy đơn hàng: " + e.getMessage());
        }
    }
}
