package com.example.duanthuenha.Controller.Host;

import com.example.duanthuenha.Model.Order;
import com.example.duanthuenha.Service.Host.ApproveRequestImpl;
import com.example.duanthuenha.Service.Host.ApproveRequestService;
import com.example.duanthuenha.Service.Host.ProductUserImpl;
import com.example.duanthuenha.Service.Host.ProductUserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/paymentManagementServlet")
public class PaymentManagementServlet extends HttpServlet {

    private ApproveRequestService approveRequestService = new ApproveRequestImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);

        List<Order> rentalRequests = approveRequestService.getAllPaymentManagement(userID);

        // ✅ Cập nhật tổng tiền trước khi gửi đến JSP
        for (Order order : rentalRequests) {
            order.setTotalPrice(order.calculateTotalPrice());
        }

        request.setAttribute("rentalRequests", rentalRequests);
        request.getRequestDispatcher("view/host/paymentManagement.jsp").forward(request, response);
    }

}
