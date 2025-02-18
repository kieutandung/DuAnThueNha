package com.example.duanthuenha.Controller;


import com.example.duanthuenha.Model.Users;
import com.example.duanthuenha.Service.ProfileImpl;
import com.example.duanthuenha.Service.ProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/UserServlet")
public class ProfileServlet extends HttpServlet {
    private ProfileService profileService = new ProfileImpl();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            }
        }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action){
            case "showInformation" :
                Information(request,response);
                break;
        }
    }
    private void Information (HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
      try {
          List<Users> users = profileService.getUserById();
          request.setAttribute("users", users);
          request.getRequestDispatcher("profile.jsp").forward(request, response);
      }catch (IOException e){
          e.printStackTrace();
      }
    }

}
