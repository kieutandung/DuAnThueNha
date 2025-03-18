package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.Notification;
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
        String pageString = req.getParameter("page");

        req.setAttribute("category", category);

        if (pageString == null || pageString.isEmpty()) {
            pageString = "1";
        }

        int page = Integer.parseInt(pageString);

        if (keyword.isEmpty()) {
            showProductWithCategory(req, resp, category, page);
            return;
        }

        if (category.isEmpty()) {
            showProductWithKeyword(req, resp, keyword, page);
            return;
        }
        showProductWithCategoryAndKeyword(req, resp, category, keyword, page);
    }

    private void showProductWithCategoryAndKeyword(HttpServletRequest req, HttpServletResponse resp, String category, String keyword, int page) throws ServletException, IOException {
        int count = productImpl.getTotalProductsCategoryAndKeyword(keyword, category);
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }

        req.setAttribute("endPageUser", endPage);
        List<ProductHost> products = productImpl.getAllProductsWithCategoryAndKeywordUser(keyword, category, page);
        req.setAttribute("listProduct", products);
        req.setAttribute("keywordUser", keyword);
        req.setAttribute("tag", page);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/home.jsp");
        dispatcher.forward(req, resp);
    }

    private void showProductWithKeyword(HttpServletRequest req, HttpServletResponse resp, String keyword, int page) throws ServletException, IOException {
        int count = productImpl.getTotalProductsKeyword(keyword);
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        req.setAttribute("endPageUser", endPage);
        List<ProductHost> products = productImpl.getAllProductsWithKeywordUser(keyword, page);
        req.setAttribute("listProduct", products);
        req.setAttribute("keywordUser", keyword);
        req.setAttribute("tag", page);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/home.jsp");
        dispatcher.forward(req, resp);
    }

    private void showProductWithCategory(HttpServletRequest req, HttpServletResponse resp, String category, int page) throws ServletException, IOException {
        int count = productImpl.getTotalProductsCategory(category);
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        req.setAttribute("endPageUser", endPage);
        List<ProductHost> products = productImpl.getAllProductsWithCategoryUser(category, page);
        req.setAttribute("listProduct", products);
        req.setAttribute("tag", page);
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
                showListProductPage(req, resp);
                break;
        }
    }


    private void showListProductPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pageString = req.getParameter("page");
        if (pageString == null || pageString.isEmpty()) {
            pageString = "1";
        }
        int page = Integer.parseInt(pageString);
        int count = productImpl.getTotalProducts();
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        req.setAttribute("endPageUser", endPage);

        List<ProductHost> products = productImpl.getProductsPage(page);
        req.setAttribute("listProduct", products);
        req.setAttribute("tag", page);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/notificationUserServlet");
        dispatcher.forward(req, resp);
    }

    private void showFavorite(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userID = (String) session.getAttribute("userId");
        List<Product> favoriteProducts = productUserImpl.getAllProductsByFavorite(Integer.parseInt(userID));
        req.setAttribute("listProduct", favoriteProducts);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/favorite.jsp");
        dispatcher.forward(req, resp);
    }
}