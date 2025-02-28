package com.example.duanthuenha.Controller;

import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.ProductHost;
import com.example.duanthuenha.Service.Host.ProductImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Collection;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB: giới hạn bộ nhớ trước khi lưu file tạm
        maxFileSize = 1024 * 1024 * 10,       // 10MB: kích thước tối đa của 1 file
        maxRequestSize = 1024 * 1024 * 50     // 50MB: kích thước tối đa của toàn bộ request
)
@WebServlet("/addProductHostServlet")
public class AddProductHostServlet extends HttpServlet {
    private ProductImpl productService = new ProductImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                default:
                    viewAddProductHost(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private void viewAddProductHost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/addNewHouse.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        addProduct(request, response);
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);
        String nameProduct = req.getParameter("nameProduct");
        String productDescription = req.getParameter("productDescription");
        Double price = Double.valueOf(req.getParameter("price"));
        String address = req.getParameter("address");
        String status = "active";
        Part imagePart = req.getPart("imageProduct");
        String image = imagePart.getSubmittedFileName();
        ProductHost product = new ProductHost(userID, nameProduct, productDescription, price, address, status, image);
        int productId = productService.addProduct(product);
        String uploadDir = getServletContext().getRealPath("") + File.separator + "img";
        Collection<Part> parts = req.getParts();
        for (Part part : parts) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String additionalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                part.write(uploadDir + File.separator + additionalFileName);
                Image imageAdd = new Image(productId, additionalFileName);
                productService.addImage(imageAdd);
            }
        }
        resp.sendRedirect("listProductHostServlet");
    }
}






