package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.ProductHost;
import com.example.duanthuenha.Service.Host.ProductImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/orderProductServlet")
public class OrderProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        int productId = Integer.parseInt(req.getParameter("productId"));
        ProductImpl productImpl = new ProductImpl();
        ProductHost productHost = productImpl.getProduct(productId);
        req.setAttribute("product", productHost);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/rentHouse.jsp");
        dispatcher.forward(req, resp);
    }
}
