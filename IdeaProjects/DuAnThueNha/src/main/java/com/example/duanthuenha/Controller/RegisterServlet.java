package com.example.duanthuenha.Controller;

import com.example.duanthuenha.Service.Register.RegisterImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/registerServlet")
public class RegisterServlet extends HttpServlet {
    private RegisterImpl registerImpl = new RegisterImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        handleRegister(req, resp);
    }

    public void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String Rpassword = req.getParameter("rPassword");
        String fullname = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String blank = "";

        req.setAttribute("username", username);
        req.setAttribute("password", password);
        req.setAttribute("rPassword", Rpassword);
        req.setAttribute("fullname", fullname);
        req.setAttribute("phone", phone);
        req.setAttribute("email", email);

        if (registerImpl.checkUsername(username)) {
            req.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại vui lòng chọn tên khác!");
            req.setAttribute("username", blank);
            req.setAttribute("password", blank);
            req.setAttribute("rPassword", blank);
            req.getRequestDispatcher("view/register.jsp").forward(req, resp);
        }

        if (!password.equals(Rpassword)) {
            req.setAttribute("errorMessage", "Mật khẩu chưa trùng khớp, vui lòng nhập lại");
            req.setAttribute("password", blank);
            req.setAttribute("rPassword", blank);
            req.getRequestDispatcher("view/register.jsp").forward(req, resp);
            return;
        }

        if (registerImpl.checkPhone(phone)) {
            req.setAttribute("errorMessage", "Số điện thoại đã tồn tại, Vui lòng chọn số khác");
            req.setAttribute("phone", blank);
            req.getRequestDispatcher("view/register.jsp").forward(req, resp);
            return;
        }

        if (registerImpl.checkEmail(email)) {
            req.setAttribute("errorMessage", "Email đã tồn tại, Vui lòng chọn email khác");
            req.setAttribute("email", blank);
            req.getRequestDispatcher("view/register.jsp").forward(req, resp);
            return;
        }

        if (registerImpl.registerUser(username, password, fullname, phone, email)) {
            req.setAttribute("successMessage", "Đăng kí thành công, bạn có thể đăng nhập ngay bây giờ");
            req.getRequestDispatcher("view/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("errorMessage", "Hệ thống đang quá tải, vui lòng đợi");
            req.getRequestDispatcher("view/register.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "login":
                    loginView(req, resp);
                    break;
                case "register":
                    registerView(req, resp);
                    break;
                default:
                    registerView(req, resp);
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
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/login.jsp");
        dispatcher.forward(req, resp);
    }
}
