package com.example.duanthuenha.Controller;

import com.example.duanthuenha.Model.ProductHost;
import com.example.duanthuenha.Service.Host.ProductImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB: giới hạn bộ nhớ trước khi lưu file tạm
        maxFileSize = 1024 * 1024 * 10,       // 10MB: kích thước tối đa của 1 file
        maxRequestSize = 1024 * 1024 * 50     // 50MB: kích thước tối đa của toàn bộ request
)
@WebServlet(value = "/listProductHostServlet")
public class ListProductHostServlet extends HttpServlet {
    private ProductImpl productService = new ProductImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "search":
                    showListProductSearchHost(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "delete":
                    int productId = Integer.parseInt(req.getParameter("productId"));
                    productService.deleteProduct(productId);
                    productService.deleteImages(productId);
                    req.setAttribute("successMessage", "Xóa thành công");
                    showListProductHost(req, resp);
                    break;
                default:
                    showListProductHost(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }

    }

    private void showListProductSearchHost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);
        String keyword = req.getParameter("searchProductHost");
        List<ProductHost> products = productService.getAllProductsWithKeyword(userID, keyword);
        req.setAttribute("listProduct", products);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/listProductHost.jsp");
        dispatcher.forward(req, resp);
    }

    private void showListProductHost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);
        List<ProductHost> products = productService.getAllProductsById(userID);
        req.setAttribute("listProduct", products);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/listProductHost.jsp");
        dispatcher.forward(req, resp);
    }
}
