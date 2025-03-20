package com.example.duanthuenha.Controller.Admin;

import com.example.duanthuenha.Model.Users;
import com.example.duanthuenha.Service.Admin.ListAccountImpl;
import com.example.duanthuenha.Service.Admin.ListAccountService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ApproveAccountServlet", value = "/approveAccountServlet")
public class ApproveAccountServlet extends HttpServlet {
    ListAccountService listAccountService = new ListAccountImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        listApproveAccount(req, resp);
    }

    private void listApproveAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Users> users = listAccountService.getAllUserByIdDocument();
        req.setAttribute("users", users);

        RequestDispatcher dispatcher = req.getRequestDispatcher("view/admin/approveAccount.jsp");
        dispatcher.forward(req, resp);
    }
}
