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
import java.util.List;

@WebServlet(name = "UserToHostServlet", value = "/userToHostServlet")
public class UserToHostServlet extends HttpServlet {
    ProfileImpl profile = new ProfileImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String documentType = req.getParameter("documentType");
        String documentId = req.getParameter("documentId");
        String image = req.getParameter("image");

        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);

        profile.addVerification(userID, documentType, documentId, image);
        displayUserToHost(req,resp);
     }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                default:
                    displayUserToHost(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private void displayUserToHost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);

        List<Users> userDocumentNumber = profile.getALlDocumentNumberUser(userID);
        req.setAttribute("allUserDocumentNumber", userDocumentNumber);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/userToHost.jsp");
        dispatcher.forward(req, resp);
    }
}
