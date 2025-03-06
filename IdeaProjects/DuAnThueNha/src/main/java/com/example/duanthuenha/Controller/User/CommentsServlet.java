package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.ProductHost;
import com.example.duanthuenha.Service.Comment.CommentImpl;
import com.example.duanthuenha.Service.Host.ProductImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/commentServlet")
public class CommentsServlet extends HttpServlet {
    private CommentImpl commentService = new CommentImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        int productId = Integer.parseInt(req.getParameter("productId"));
        ProductImpl productImpl = new ProductImpl();
        ProductHost productHost = productImpl.getProduct(productId);
        req.setAttribute("product", productHost);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/addComments.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating")); // Ép kiểu rating thành int
            String reviewText = request.getParameter("reviewText");

            if (reviewText == null || reviewText.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Nội dung đánh giá không được để trống.");
                request.getRequestDispatcher("view/user/addComments.jsp").forward(request, response);
                return;
            }

            boolean isAdded = commentService.addComment(userId, productId, reviewText, rating);

            if (isAdded) {
                response.sendRedirect("orderInformationServlet?orderId=");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm đánh giá. Vui lòng thử lại.");
                request.getRequestDispatcher("view/user/addComments.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu nhập không hợp lệ.");
            request.getRequestDispatcher("view/user/addComments.jsp").forward(request, response);
        }
    }
}
