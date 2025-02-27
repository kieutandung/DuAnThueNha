package com.example.duanthuenha.Controller;

import com.example.duanthuenha.Service.Login.LoginImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/loginServlet")
public class LoginServlet extends HttpServlet {

    private LoginImpl loginImpl;

    public void init() {
        loginImpl = new LoginImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        handleLogin(req, resp);
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String[] loginInfo = loginImpl.checkLoginDB(username, password);
        if (loginInfo != null) {
            String role = loginInfo[0];
            String status = loginInfo[1];
            String id = loginInfo[2];
            if ("active".equalsIgnoreCase(status)) {
                HttpSession session = req.getSession();
                session.setAttribute("userId", id);
                if (role.equalsIgnoreCase("admin")) {
                    resp.sendRedirect("adminServlet");
                } else if (role.equalsIgnoreCase("user")|| role.equalsIgnoreCase("host")) {
                    resp.sendRedirect("/productServlet");

                }
            } else {
                req.setAttribute("errorMessage", "Tài khoản của bạn đã bị khóa!");
                req.getRequestDispatcher("view/login.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("errorMessage", "Sai tên đăng nhập hoặc mật khẩu, Vui lòng đăng nhập lại!");
            req.getRequestDispatcher("view/login.jsp").forward(req, resp);
        }
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "register":
                    registerView(req, resp);
                    break;
                default:
                    loginView(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private void registerView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/register.jsp");
        dispatcher.forward(req, resp);
    }

    private void loginView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.invalidate();
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/login.jsp");
        dispatcher.forward(req, resp);
    }
}
