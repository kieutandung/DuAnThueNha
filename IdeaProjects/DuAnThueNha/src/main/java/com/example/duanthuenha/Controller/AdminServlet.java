package com.example.duanthuenha.Controller;

import com.example.duanthuenha.Model.Verification;
import com.example.duanthuenha.Service.Admin.ListAccountImpl;
import com.example.duanthuenha.Model.Users;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/adminServlet")
public class AdminServlet extends HttpServlet {
    private ListAccountImpl listAccountService = new ListAccountImpl();

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
                case "sort":
                    sortUsersByName(req, resp);
                    break;
                case "editUser":
                    handleEditUserView(req, resp);
                    break;
                case "approveAccount":
                    listApproveAccount(req, resp);
                    break;
                default:
                    listAccountView(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private void listApproveAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Verification> verificationList = listAccountService.getAllVerification();
        req.setAttribute("verifications", verificationList);

        RequestDispatcher dispatcher = req.getRequestDispatcher("view/approveAccount.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "addUser":
                    handleAddUser(req, resp);
                    break;
                case "editUser":
                    handleEditUser(req, resp);
                    break;
                case "delete":
                    deleteUser(req, resp);
                    break;
                case "approveAccount":
                    listApproveAccount(req, resp);
                    break;
                default:
                    listAccountView(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    public void handleAddUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String role = req.getParameter("role");

        Users newUser = listAccountService.addUser(username, password, fullName, phone, email, role);
        List<Users> users = listAccountService.getAllUser();
        users.add(0, newUser);
        req.setAttribute("users", users);
        listAccountView(req, resp);
    }

    public void handleEditUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String role = req.getParameter("role");
        String status = req.getParameter("status");
        int idUser = Integer.parseInt(req.getParameter("idUser"));

        listAccountService.updateUser(username, password, fullName, phone, email, role, status, idUser);
        listAccountView(req, resp);
    }

    private void listAccountView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Users> usersList = listAccountService.getAllUser();
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

    private void sortUsersByName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Boolean isSorted = (Boolean) session.getAttribute("isSorted");
        if (isSorted == null || !isSorted) {
            List<Users> sortedUsers = listAccountService.getAllUsersSortedByName();
            req.setAttribute("users", sortedUsers);
            session.setAttribute("isSorted", true);
        } else {
            List<Users> users = listAccountService.getAllUser();
            req.setAttribute("users", users);
            session.setAttribute("isSorted", false);
        }
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/account.jsp");
        dispatcher.forward(req, resp);
    }

    private void handleEditUserView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idUser")); // Get the user ID to edit
        Users user = listAccountService.getUserById(id); // Fetch user details from the service
        req.setAttribute("user", user); // Set user details to request attribute
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/editAccount.jsp");
        dispatcher.forward(req, resp);
    }

}
