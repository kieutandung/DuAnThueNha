package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.Product;
import com.example.duanthuenha.Service.Host.ProductUserImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/homeUserServlet")
public class HomeUserServlet extends HttpServlet {
    ProductUserImpl productUserImpl = new ProductUserImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = productUserImpl.getAllProducts();
        req.setAttribute("listProduct", products);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/home.jsp");
        dispatcher.forward(req, resp);
    }
}
