package com.example.duanthuenha.Controller.Host;

import com.example.duanthuenha.Model.Order;
import com.example.duanthuenha.Model.ProductHost;
import com.example.duanthuenha.Service.Host.ApproveRequestImpl;
import com.example.duanthuenha.Service.Host.ApproveRequestService;
import com.example.duanthuenha.Service.Host.ProductImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB: giới hạn bộ nhớ trước khi lưu file tạm
        maxFileSize = 1024 * 1024 * 10,       // 10MB: kích thước tối đa của 1 file
        maxRequestSize = 1024 * 1024 * 50     // 50MB: kích thước tối đa của toàn bộ request
)
@WebServlet(value = "/listProductHostServlet")
public class ListProductHostServlet extends HttpServlet {
    private final ProductImpl productService = new ProductImpl();
    private final ApproveRequestImpl approveRequestService  = new ApproveRequestImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "search":
                    showListProductSearchHost(req, resp);
                    break;
                case "updateStatus":
                    updateOrderStatus(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private void updateOrderStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int idOrder = Integer.parseInt(req.getParameter("idOrder"));
        String status = req.getParameter("status");

        System.out.println("orderId nhận được: " + idOrder);
        System.out.println("Trạng thái mới: " + status);

        approveRequestService.updateStatus(idOrder, status);

        resp.sendRedirect(req.getContextPath() + "/listProductHostServlet?action=manageRentalRequests");
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "delete":
                    int productId = Integer.parseInt(req.getParameter("productId"));
                    productService.deleteProduct(productId);
                    productService.deleteImages(productId);
                    req.setAttribute("successMessage", "Xóa thành công");
                    showListProductHost(req, resp);
                    break;
                case "manageRentalRequests":
                    showListManageRentalRequests(req,resp);
                    break;
                default:
                    showListProductHost(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }

    }

    private void showListManageRentalRequests(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);

        // Lấy danh sách yêu cầu thuê từ MySQL
        List<Order> rentalRequests = approveRequestService.getAllRentalRequestsByHost(userID);

        // Gửi danh sách đến JSP
        req.setAttribute("rentalRequests", rentalRequests);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/host/hostApproveTheRequest.jsp");
        dispatcher.forward(req, resp);
    }


    private void showListProductSearchHost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);
        String keyword = req.getParameter("searchProductHost");

        String pageString = req.getParameter("page");
        if (pageString == null || pageString.isEmpty()) {
            pageString = "1";
        }
        int page = Integer.parseInt(pageString);
        int count = productService.getTotalProductsSearchHost(userID,keyword);
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        req.setAttribute("endPageUser", endPage);
        req.setAttribute("tag", page);
        List<ProductHost> products = productService.getAllProductsWithKeyword(userID, keyword,page);
        req.setAttribute("keyword", keyword);
        req.setAttribute("listProduct", products);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/host/listProductHost.jsp");
        dispatcher.forward(req, resp);
    }

    private void showListProductHost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);

        String pageString = req.getParameter("page");
        if (pageString == null || pageString.isEmpty()) {
            pageString = "1";
        }
        int page = Integer.parseInt(pageString);
        int count = productService.getTotalProductsHost(userID);
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        req.setAttribute("endPageUser", endPage);
        req.setAttribute("tag", page);
        List<ProductHost> products = productService.getAllProductsById(userID,page);
        req.setAttribute("listProduct", products);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/host/listProductHost.jsp");
        dispatcher.forward(req, resp);
    }
}
