package com.example.duanthuenha.Controller.Admin;

import com.example.duanthuenha.Model.*;
import com.example.duanthuenha.Service.Admin.ListAccountImpl;
import com.example.duanthuenha.Service.Host.ProductImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(value = "/adminServlet")
public class AdminServlet extends HttpServlet {
    private ListAccountImpl listAccountService = new ListAccountImpl();
    private ProductImpl productImpl = new ProductImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
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
                case "revenueChart":
                    revenueChart(req, resp);
                    break;
                case "reportView":
                    listReportView(req, resp);
                    break;
                case "reportViewPending":
                    listReportViewPending(req, resp);
                    break;
                default:
                    listAccountView(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private void revenueChart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Order> orders = listAccountService.getAllOrder();
        Map<Integer, Double> revenueByMonth = listAccountService.getRevenueByMonth();
        Map<String, Integer> orderStatusCount = listAccountService.getOrderStatusCount();
        List<Product> topProducts = listAccountService.getTopRentedProducts();

        // Tính toán dữ liệu để gửi qua JSP
        req.setAttribute("pendingCount", orderStatusCount.getOrDefault("pending", 0));
        req.setAttribute("cancelledCount", orderStatusCount.getOrDefault("cancelled", 0));
        req.setAttribute("completedCount", orderStatusCount.getOrDefault("completed", 0));
        req.setAttribute("waitingCount", orderStatusCount.getOrDefault("waiting", 0));
        req.setAttribute("paidCount", orderStatusCount.getOrDefault("paid", 0));

        req.setAttribute("orders", orders);
        req.setAttribute("revenueByMonth", revenueByMonth);

        // Xử lý HTML của top sản phẩm trong Servlet
        StringBuilder topProductsHtml = new StringBuilder();
        if (topProducts != null && !topProducts.isEmpty()) {
            for (Product product : topProducts) {
                topProductsHtml.append("<div class='house-card'>")
                        .append("<img src='img/").append(product.getImage()).append("'>")
                        .append("<div class='house-details'>")
                        .append("<p class='price'>").append(product.getPrice()).append(" VNĐ / Ngày</p>")
                        .append("<p><strong><em>").append(product.getNameProduct()).append("</em></strong></p>")
                        .append("</div>")
                        .append("</div>");
            }
        } else {
            topProductsHtml.append("<p>Không có dữ liệu.</p>");
        }

        req.setAttribute("topProductsHtml", topProductsHtml.toString());

        RequestDispatcher dispatcher = req.getRequestDispatcher("/view/admin/revenue.jsp");
        dispatcher.forward(req, resp);
    }

    private void listReportView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Report> reportList = listAccountService.getAllReport();
        List<Users> usersList = new ArrayList<>();
        List<Users> hostList = new ArrayList<>();
        List<ProductHost> productsList = new ArrayList<>();

        for (Report report : reportList) {
            Users user = listAccountService.getUserById(report.getIdUser());
            Users host = listAccountService.getUserByidProduct(report.getIdProduct());
            ProductHost productHost = productImpl.getProduct(report.getIdProduct());
            usersList.add(user);
            hostList.add(host);
            productsList.add(productHost);
        }

        req.setAttribute("reportList", reportList);
        req.setAttribute("hostList", hostList);
        req.setAttribute("usersReport", usersList);
        req.setAttribute("productsList", productsList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/admin/report.jsp");
        dispatcher.forward(req, resp);
    }

    private void listReportViewPending(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Report> reportList = listAccountService.getAllReportPending();
        List<Users> usersList = new ArrayList<>();
        List<Users> hostList = new ArrayList<>();
        List<ProductHost> productsList = new ArrayList<>();

        for (Report report : reportList) {
            Users user = listAccountService.getUserById(report.getIdUser());
            Users host = listAccountService.getUserByidProduct(report.getIdProduct());
            ProductHost productHost = productImpl.getProduct(report.getIdProduct());
            usersList.add(user);
            hostList.add(host);
            productsList.add(productHost);
        }


        req.setAttribute("reportList", reportList);
        req.setAttribute("hostList", hostList);
        req.setAttribute("usersReport", usersList);
        req.setAttribute("productsList", productsList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/admin/report.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
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
                case "promoteUser":
                    handlePromoteUser(req, resp);
                    break;
                case "profileFeedback":
                    handleProfileFeedback(req, resp);
                    break;
                case "updateStatus":
                    updateStatus(req, resp);
                    break;
                case "sendFeedback":
                    sendFeedback(req, resp);
                    break;
                default:
                    listAccountView(req, resp);
                    break;
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private void sendFeedback(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);

        String feedback = req.getParameter("feedback");
        String title = req.getParameter("title");
        String idReport = req.getParameter("idReport");
        String type = "khiếu nại";
        int idReceiver = Integer.parseInt(req.getParameter("idUser"));

        Notification notification = new Notification(userID, title, feedback, type,idReceiver);
        listAccountService.updateReportApproved(Integer.parseInt(idReport),feedback);
        listAccountService.sendFeedback(notification);
        listReportView(req, resp);
    }

    private void handleProfileFeedback(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idDocument = Integer.parseInt(req.getParameter("idDocument"));
        String status = req.getParameter("status");
        String rejectionReason = "Không hợp lệ";

        if ("approved".equals(status)) {
            rejectionReason = null;
        }

        listAccountService.updateStatus(idDocument, status, rejectionReason);
        resp.sendRedirect(req.getHeader("Referer")); // Quay lại trang trước
    }


    private void handlePromoteUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idUser = Integer.parseInt(req.getParameter("idUser"));
        boolean success = listAccountService.promoteUser(idUser);

        if (success) {
            // Nếu phê duyệt thành công, chuyển hướng đến trang listApproveAccount
            resp.sendRedirect("view/approveAccount.jsp");
        } else {
            // Nếu có lỗi, có thể hiển thị thông báo lỗi
            req.setAttribute("errorMessage", "Không thể phê duyệt người dùng.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("errorPage.jsp"); // Chuyển đến trang lỗi hoặc trang khác
            dispatcher.forward(req, resp);
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
        req.setAttribute("addUserSuccess", true);
        if (newUser != null) {
            req.setAttribute("message", "Thêm người dùng thành công!");
        } else {
            req.setAttribute("error", "Thêm người dùng thất bại!");
        }
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
        String rejectionReason = req.getParameter("rejectionReason");
        int idUser = Integer.parseInt(req.getParameter("idUser"));

        try {
            // Gọi phương thức updateUser với logic cập nhật và tạo thông báo nếu cần
            listAccountService.updateUser(username, password, fullName, phone, email, role, status, rejectionReason, idUser);

            // Gửi phản hồi về giao diện
            req.setAttribute("message", "Cập nhật người dùng thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Cập nhật người dùng thất bại! Lỗi: " + e.getMessage());
        }
        listAccountView(req, resp);
    }



    private void listAccountView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Users> usersList = listAccountService.getAllUser();
        req.setAttribute("users", usersList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/admin/account.jsp");
        dispatcher.forward(req, resp);
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idUser = Integer.parseInt(req.getParameter("idUser"));
        listAccountService.deleteUser(idUser);
        req.setAttribute("deleteSuccess", true);
        listAccountView(req, resp);
    }

    private void searchUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        List<Users> users = listAccountService.searchUsersByName(name);
        req.setAttribute("users", users);
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/admin/account.jsp");
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
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/admin/account.jsp");
        dispatcher.forward(req, resp);
    }

    private void handleEditUserView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("idUser")); // Get the user ID to edit
        Users user = listAccountService.getUserById(id); // Fetch user details from the service
        req.setAttribute("user", user); // Set user details to request attribute
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/admin/editAccount.jsp");
        dispatcher.forward(req, resp);
    }

    private void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idDocument = Integer.parseInt(req.getParameter("idDocument"));
        String status = req.getParameter("status");
        String rejectionReason = req.getParameter("rejectionReason");

        listAccountService.updateVerificationStatus(idDocument, status, rejectionReason);
    }
}
