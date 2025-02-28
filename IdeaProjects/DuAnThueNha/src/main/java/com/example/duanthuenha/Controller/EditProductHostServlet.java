package com.example.duanthuenha.Controller;

import com.example.duanthuenha.Model.Image;
import com.example.duanthuenha.Model.ProductHost;
import com.example.duanthuenha.Service.Host.ProductImpl;
import org.json.JSONObject;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB: giới hạn bộ nhớ trước khi lưu file tạm
        maxFileSize = 1024 * 1024 * 10,       // 10MB: kích thước tối đa của 1 file
        maxRequestSize = 1024 * 1024 * 50     // 50MB: kích thước tối đa của toàn bộ request
)
@WebServlet(value = "/editProductHostServlet")
public class EditProductHostServlet extends HttpServlet {
    private ProductImpl productService = new ProductImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        formEditProduct(req, resp);
        doPost(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "updateProductHost":
                    editProductHost(req, resp);
                    break;
                case "deleteImage":
                    deleteImageProduct(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private void deleteImageProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idImage = Integer.parseInt(req.getParameter("imageId"));
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        JSONObject json = new JSONObject();
        boolean success = productService.deleteImage(idImage);
        json.put("success", success);
        out.print(json);
        out.flush();
    }

    private void formEditProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idProduct = Integer.parseInt(req.getParameter("productId"));
        ProductHost product = productService.getProduct(idProduct);
        List<Image> images = productService.getImagesByProductId(idProduct);
        req.setAttribute("product", product);
        req.setAttribute("imagesProduct", images);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/editProductHost.jsp");
        dispatcher.forward(req, resp);
    }

    private void editProductHost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idProduct = Integer.parseInt(req.getParameter("idProduct"));
        String nameProduct = req.getParameter("nameProduct");
        String productDescription = req.getParameter("productDescription");
        double price = Double.parseDouble(req.getParameter("price"));
        String address = req.getParameter("address");
        String status = req.getParameter("statusProduct");
        Part filePart = req.getPart("imageProduct");
        String imageProduct = filePart.getSubmittedFileName();
        if (imageProduct == "") {
            imageProduct = req.getParameter("image");
        }
        ProductHost product = new ProductHost(idProduct, nameProduct, productDescription, price, address, status, imageProduct);
        productService.editProduct(product);
        String uploadDir = getServletContext().getRealPath("") + File.separator + "img";
        Collection<Part> parts = req.getParts();
        for (Part part : parts) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String additionalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                part.write(uploadDir + File.separator + additionalFileName);
                Image imageAdd = new Image(idProduct, additionalFileName);
                productService.addImage(imageAdd);
            }
        }
        resp.sendRedirect("listProductHostServlet");
    }
}
