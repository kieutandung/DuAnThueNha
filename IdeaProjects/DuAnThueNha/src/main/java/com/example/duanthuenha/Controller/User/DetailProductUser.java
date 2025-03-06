package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.*;
import com.example.duanthuenha.Service.Comment.CommentImpl;
import com.example.duanthuenha.Service.Host.ProductImpl;
import com.example.duanthuenha.Service.Host.ProductUserImpl;
import com.example.duanthuenha.Service.Host.ProductUserService;
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
    ProductUserService productUserService = new ProductUserImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        ProductImpl productImpl = new ProductImpl();
        ProfileImpl profileImpl = new ProfileImpl();
        CommentImpl commentService = new CommentImpl();
        List<Image> listImage = productImpl.getImagesByProductId(productId);
        ProductHost product = productImpl.getProduct(productId);

        Image image = new Image(productId,product.getImage());
        listImage.add(0,image);
        Users avtUser = profileImpl.getUserById(product.getIdUser());
        List<Comment> comments = commentService.getCommentsByProductId(productId);
        boolean isFavorite = productUserService.isFavorite(Integer.parseInt(req.getSession().getAttribute("userId").toString()),productId);
        req.setAttribute("isFavorite", isFavorite);
        req.setAttribute("listImage", listImage);
        req.setAttribute("product", product);
        req.setAttribute("avtUser", avtUser);

        req.setAttribute("comments", comments);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/houseDetail.jsp");
        dispatcher.forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "toggleFavorite":
                toggleFavorite(req, resp);
                break;
           
        }
    }

    private void toggleFavorite(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String productId = req.getParameter("productId");
        HttpSession session = req.getSession();
        String userID = (String) session.getAttribute("userId");
        boolean isNowFavorite = productUserService.toggleFavorite(Integer.parseInt(userID),Integer.parseInt(productId));

        resp.setContentType("text/plain");
        if (isNowFavorite) {
            resp.getWriter().write("added");
        } else {
            resp.getWriter().write("removed");
        }
    }
}
