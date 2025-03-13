package com.example.duanthuenha.Controller.Admin;

import com.example.duanthuenha.Model.Verification;
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

@WebServlet(name = "VerificationServlet", value = "/verificationServlet")
public class VerificationServlet extends HttpServlet {
   ListAccountService listAccountService = new ListAccountImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getVerificationInfo(req, resp);
    }

    private void getVerificationInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            int idUser = Integer.parseInt(req.getParameter("idUser"));
            List<Verification> verifications = listAccountService.getVerificationsByUserId(idUser);

            req.setAttribute("verifications", verifications);
            RequestDispatcher dispatcher = req.getRequestDispatcher("view/admin/verificationDetails.jsp");
            dispatcher.forward(req, resp);
    }
}
