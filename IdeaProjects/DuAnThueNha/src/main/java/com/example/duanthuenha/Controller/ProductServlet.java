package com.example.duanthuenha.Controller;

import com.example.duanthuenha.Model.Product;
import com.example.duanthuenha.Service.Host.ProductImpl;
import com.example.duanthuenha.Service.Host.ProductService;
import com.example.duanthuenha.Service.Host.ProductUserImpl;
import com.example.duanthuenha.Service.Host.ProductUserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/productServlet")
public class ProductServlet extends HttpServlet {
    private ProductUserService productService = new ProductUserImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "default";

        switch (action) {
            case "viewDetail":
                String productId = request.getParameter("id");
                if (productId != null && !productId.isEmpty()) {
                    response.sendRedirect("/view/houseDetail.jsp?id=" + productId);
                } else {
                    response.sendRedirect("/view/home.jsp");
                }
                break;
            default:
                response.sendRedirect("/view/home.jsp");
                break;
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "default";

        switch (action) {
            case "addProduct":
                addProduct(request, response);
                break;

        }
    }


    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idUser = Integer.parseInt(request.getParameter("idUser"));
            String nameProduct = request.getParameter("nameProduct");
            String productDescription = request.getParameter("productDescription");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String address = request.getParameter("address");
            String status = "active";

            Product product = new Product(idUser, nameProduct, productDescription, price, address, status);
            productService.addProduct(product);

            response.sendRedirect("/view/addNewHouse.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
