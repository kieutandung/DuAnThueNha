package com.example.duanthuenha.Controller.Host;

import com.example.duanthuenha.Model.Order;
import com.example.duanthuenha.Model.Product;
import com.example.duanthuenha.Service.Host.RevenueImpl;
import com.example.duanthuenha.Service.Host.RevenueService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(value = "/revenueServlet")
public class RevenueServlet extends HttpServlet {
    RevenueService revenueService = new RevenueImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);

        List<Order> orders = revenueService.getAllOrderByIdUser(userID);
        Map<Integer, Double> revenueByMonthByIdUser = revenueService.getRevenueByMonth(userID);

        req.setAttribute("orders", orders);
        req.setAttribute("revenueByMonthByIdUser", revenueByMonthByIdUser);
        List<Product> topHouses = revenueService.getTopRentedHouses();
        req.setAttribute("topHouses" , topHouses);

        RequestDispatcher dispatcher = req.getRequestDispatcher("view/host/hostRevenue.jsp");
        dispatcher.forward(req, resp);
    }

}
