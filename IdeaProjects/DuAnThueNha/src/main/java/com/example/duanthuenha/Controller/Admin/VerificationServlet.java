package com.example.duanthuenha.Controller.Admin;

import com.example.duanthuenha.Model.Verification;
import com.example.duanthuenha.Service.Admin.ListAccountImpl;
import com.example.duanthuenha.Service.Admin.ListAccountService;
import org.json.JSONObject;

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
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String idUserParam = req.getParameter("idUser");

        // Kiểm tra nếu idUser bị null hoặc rỗng
        if (idUserParam == null || idUserParam.trim().isEmpty()) {
            resp.sendRedirect("error.jsp"); // Hoặc hiển thị thông báo lỗi
            return;
        }

        int idUser = Integer.parseInt(idUserParam); // Không còn lỗi NumberFormatException
        List<Verification> verifications = listAccountService.getVerificationsByUserId(idUser);

        req.setAttribute("verifications", verifications);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/admin/verificationDetails.jsp");
        dispatcher.forward(req, resp);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String action = request.getParameter("action");
        String reason = request.getParameter("reason");
        String idDocumentParam = request.getParameter("idDocument");

        JSONObject jsonResponse = new JSONObject();

        try {
            if (idDocumentParam == null || idDocumentParam.trim().isEmpty()) {
                throw new NumberFormatException("idDocument is missing");
            }

            int idDocument = Integer.parseInt(idDocumentParam);
            boolean success = listAccountService.updateVerificationStatus(idDocument, action, reason);

            if (success) {
                jsonResponse.put("success", true);
                jsonResponse.put("idDocument", idDocument);
                jsonResponse.put("status", action.equals("accept") ? "approved" : "rejected");
                jsonResponse.put("rejectionReason", action.equals("reject") ? reason : "");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Cập nhật thất bại!");
            }
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Lỗi: " + e.getMessage());
        }

        response.getWriter().write(jsonResponse.toString());
    }
}
