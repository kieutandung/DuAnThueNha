package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.Product;
import com.example.duanthuenha.Model.ProductHost;
import com.example.duanthuenha.Service.Host.ProductImpl;
import com.example.duanthuenha.Service.Host.ProductUserImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/homeUserServlet")
public class HomeUserServlet extends HttpServlet {
    ProductUserImpl productUserImpl = new ProductUserImpl();
    ProductImpl productImpl = new ProductImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String category = req.getParameter("category");
        String keyword = req.getParameter("keyword");
        if (keyword.isEmpty()) {
            List<ProductHost> products = productImpl.getAllProductsWithCategoryUser(category);
            req.setAttribute("listProduct", products);
            RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/home.jsp");
            dispatcher.forward(req, resp);
            return;
        }
        if (category.isEmpty()) {
            List<ProductHost> products = productImpl.getAllProductsWithKeywordUser(keyword);
            for (ProductHost productHost : products) {
                System.out.println(productHost.getIdProduct());
            }
            req.setAttribute("listProduct", products);
            req.setAttribute("keywordUser", keyword);
            RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/home.jsp");
            dispatcher.forward(req, resp);
            return;
        }
        List<ProductHost> products = productImpl.getAllProductsWithCategoryAndKeywordUser(keyword, category);
        req.setAttribute("listProduct", products);
        req.setAttribute("keywordUser", keyword);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/home.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "showFavorite":
                showFavorite(req, resp);
                break;
            default:
                List<ProductHost> products = productImpl.getAllProducts();
                req.setAttribute("listProduct", products);
                RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/home.jsp");
                dispatcher.forward(req, resp);
                break;
        }

    }

    private void showFavorite(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userID = (String) session.getAttribute("userId");
        List<Product> favoriteProducts = productUserImpl.getAllProductsByFavorite(Integer.parseInt(userID));
        req.setAttribute("listProduct", favoriteProducts);
        System.out.println(favoriteProducts);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/favorite.jsp");
        dispatcher.forward(req, resp);
    }

}
