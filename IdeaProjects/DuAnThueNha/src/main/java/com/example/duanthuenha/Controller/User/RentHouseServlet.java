package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.Order;
import com.example.duanthuenha.Service.RentHouse.RentHouseImpl;
import com.example.duanthuenha.Service.RentHouse.RentHouseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/rentHouseServlet")
public class RentHouseServlet extends HttpServlet {
    RentHouseService rentHouseService = new RentHouseImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        resp.setCharacterEncoding("UTF-8");
        try {

            HttpSession session = req.getSession();
            String userIDS = (String) session.getAttribute("userId");
            int idUser = Integer.parseInt(userIDS);

            int idProduct = Integer.parseInt(req.getParameter("idProduct"));

            String startDate = req.getParameter("startDate");
            String endDate = req.getParameter("endDate");
            String notes = req.getParameter("notes");
            int numPeople = Integer.parseInt(req.getParameter("numPeople"));

            Order order = rentHouseService.addRentHouse(idUser, idProduct, startDate, endDate, notes, numPeople);

            req.setAttribute("order", order);
            req.getRequestDispatcher("view/user/home.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi thuê nhà!");
        }
    }
}
