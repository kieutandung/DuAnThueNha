package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.*;
import com.example.duanthuenha.Service.Comment.CommentImpl;
import com.example.duanthuenha.Service.Host.ProductImpl;
import com.example.duanthuenha.Service.Host.ProductUserImpl;
import com.example.duanthuenha.Service.Profile.ProfileImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/detailProductUser")
public class DetailProductUser extends HttpServlet {
    ProductUserImpl productUserService = new ProductUserImpl();
    ProductImpl productImpl = new ProductImpl();
    ProfileImpl profileImpl = new ProfileImpl();
    CommentImpl commentService = new CommentImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String userID = (String) session.getAttribute("userId");
        int productId = Integer.parseInt(req.getParameter("productId"));
        List<Image> listImage = productImpl.getImagesByProductId(productId);
        ProductHost product = productImpl.getProduct(productId);

        Image image = new Image(productId, product.getImage());
        listImage.add(0, image);
        Users avtUser = profileImpl.getUserById(product.getIdUser());
        List<Comment> comments = commentService.getCommentsByProductId(productId);
        boolean isFavorite = productUserService.isFavorite(Integer.parseInt(userID), productId);

        req.setAttribute("isFavorite", isFavorite);
        req.setAttribute("listImage", listImage);
        req.setAttribute("product", product);
        req.setAttribute("avtUser", avtUser);
        req.setAttribute("idUser", userID);
        req.setAttribute("comments", comments);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/houseDetail.jsp");
        dispatcher.forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "toggleFavorite":
                toggleFavorite(req, resp);
                break;
            case "report":
                reportHost(req, resp);
                break;
        }
    }

    private void reportHost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String userID = (String) session.getAttribute("userId");
        int idUser = Integer.parseInt(userID);
        int productId = Integer.parseInt(req.getParameter("productId"));
        String reason = req.getParameter("reason");
        String reasonDetails = req.getParameter("reasonDetails");
        Report report = new Report(productId, idUser, reason, reasonDetails);
        productUserService.addReport(report);
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        resp.sendRedirect("/detailProductUser?productId=" + productId);
    }

    private void toggleFavorite(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        HttpSession session = req.getSession();
        int userId = Integer.parseInt((String) session.getAttribute("userId"));
        if (!productUserService.isFavorite(userId, productId)) {
            List<Product> favorites = productUserService.getAllProductsByFavorite(userId);
            if (favorites.size() >= 12) {
                resp.setContentType("text/plain");
                resp.getWriter().write("error");
                return;
            }
        }
        boolean isNowFavorite = productUserService.toggleFavorite(userId, productId);
        resp.setContentType("text/plain");
        if (isNowFavorite) {
            resp.getWriter().write("added");
        } else {
            resp.getWriter().write("removed");
        }
    }
}