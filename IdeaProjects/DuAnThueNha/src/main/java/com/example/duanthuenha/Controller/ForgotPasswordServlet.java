package com.example.duanthuenha.Controller;

import com.example.duanthuenha.Service.ForgotPassword.ForgotPasswordImpl;
import com.example.duanthuenha.Service.Register.RegisterImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ForgotPasswordServlet", value = "/forgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private RegisterImpl registerImpl = new RegisterImpl();
    private ForgotPasswordImpl forgotPasswordImpl = new ForgotPasswordImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleForgotPassword(req, resp);
    }

    public void handleForgotPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phone = req.getParameter("phone");
        if (!registerImpl.checkPhone(phone)) {
            req.setAttribute("errorMessage", "Không tìm thấy số điện thoại của bạn, vui lòng thử lại");
            req.getRequestDispatcher("view/forgotPassword.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("phone", phone);
        req.setAttribute("reset", true);
        String fullname = forgotPasswordImpl.checkfullNameWithPhone(phone);
        req.setAttribute("successMessage", "Xin chào " + fullname + ", vui lòng nhập mật khẩu mới và xác nhận mật khẩu.");

        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (newPassword != null && confirmPassword != null) {
            if (!newPassword.equals(confirmPassword)) {
                req.removeAttribute("successMessage");
                req.setAttribute("errorMessage", "Mật khẩu chưa trùng khớp, vui lòng nhập lại.");
                req.getRequestDispatcher("view/forgotPassword.jsp").forward(req, resp);
                return;
            }
            boolean isUpdated = forgotPasswordImpl.updatePassword(phone, newPassword);
            if (isUpdated) {
                req.setAttribute("successMessage", "Mật khẩu đã được cập nhật thành công! Bạn có thể đăng nhập ngay.");
                req.getRequestDispatcher("view/login.jsp").forward(req, resp);
                return;
            } else {
                req.removeAttribute("successMessage");
                req.setAttribute("errorMessage", "Có lỗi xảy ra, vui lòng thử lại sau.");
            }
        }
        req.getRequestDispatcher("view/forgotPassword.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "forgotPassword":
                forgotPassword(req, resp);
                break;
        }
    }

    private void forgotPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/forgotPassword.jsp");
        dispatcher.forward(req, resp);
    }
}
