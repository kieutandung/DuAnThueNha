package com.example.duanthuenha.Controller;


import com.example.duanthuenha.Model.Users;
import com.example.duanthuenha.Service.Profile.ProfileImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet("/profileServlet")
public class ProfileServlet extends HttpServlet {
    private ProfileImpl profileImpl = new ProfileImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }
        switch (action) {
            case "editProfile":
                showEditProfile(req, resp);
                break;
            default:
                showProfile(req, resp);
                break;
        }

    }

    private void showEditProfile(HttpServletRequest req, HttpServletResponse resp) throws
            ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/profile.jsp");
        dispatcher.forward(req, resp);
    }

    private void showProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);
        Users user = profileImpl.getUserById(userID);
        req.setAttribute("user", user);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/profile.jsp");
        dispatcher.forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "updateInformation":
                UpdateInformation(req, resp);
                showProfile(req, resp);
                break;
        }

    }

    private void UpdateInformation(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);
        Users userPassAndUsername = profileImpl.getUserById(userID);
        String username = userPassAndUsername.getUsername();
        String fullName = req.getParameter("fullName");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String image = req.getParameter("image");
        if (image == "") {
            image = req.getParameter("imageBox");
        }
        Users updatedUser = new Users(userID, username, password, fullName, phone, email, image);
        profileImpl.UpdateInformation(updatedUser);

    }

}





