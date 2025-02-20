package com.example.duanthuenha.Controller;

import com.example.duanthuenha.Service.Admin.ListAccountImpl;
import com.example.duanthuenha.Service.Admin.ListAccountService;
import com.example.duanthuenha.Model.Users;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/adminServlet")
public class AdminServlet extends HttpServlet {
    private ListAccountService listAccountService = new ListAccountImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "delete":
                    deleteUser(req, resp);
                    break;
                case "search":
                    searchUsers(req, resp);
                    break;
                case "addUser":
                    addUserView(req,resp);
                default:
                    listAccountView(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

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
            String fullName = req.getParameter("fullName");
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");
            String role = req.getParameter("role");

            req.setAttribute("username", username);
            req.setAttribute("password", password);
            req.setAttribute("fullName", fullName);
            req.setAttribute("phone", phone);
            req.setAttribute("email", email);
            req.setAttribute("role", role);
    }
    private void addUserView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/addAccount.jsp");
        dispatcher.forward(req,resp);
    }
    private void listAccountView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Users> usersList = listAccountService.getAllUser();
        System.out.println(usersList);
        req.setAttribute("users", usersList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/account.jsp");
        dispatcher.forward(req, resp);
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idUser = Integer.parseInt(req.getParameter("idUser"));
        listAccountService.deleteUser(idUser);
        resp.getWriter().write("success");
    }

    private void searchUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        List<Users> users = listAccountService.searchUsersByName(name);
        req.setAttribute("users", users);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/account.jsp");
        dispatcher.forward(req, resp);
    }
}
