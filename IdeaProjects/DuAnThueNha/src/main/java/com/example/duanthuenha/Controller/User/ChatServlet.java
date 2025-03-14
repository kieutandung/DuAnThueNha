package com.example.duanthuenha.Controller.User;

import com.example.duanthuenha.Model.Chat;
import com.example.duanthuenha.Model.Users;
import com.example.duanthuenha.Service.Chat.ChatImpl;
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

@WebServlet(value = "/chatServlet")
public class ChatServlet extends HttpServlet {

    ChatImpl chatImpl = new ChatImpl();
    ProfileImpl profileImpl = new ProfileImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "sendMess":
                sendMess(req, resp);
                break;
        }
    }

    private void sendMess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        HttpSession session = req.getSession();
        int userID = Integer.parseInt((String) session.getAttribute("userId"));

        int idReceiver = Integer.parseInt(req.getParameter("idHost"));
        String sendMess = req.getParameter("sendMess");

        // Tạo và lưu tin nhắn mới vào DB
        Chat chat = new Chat(userID, idReceiver, sendMess);
        chatImpl.addChat(chat);

        // Lấy thông tin của đối phương và của chính user
        Users users = profileImpl.getUserById(idReceiver);
        Users myProfile = profileImpl.getUserById(userID);

        // Lấy danh sách tin nhắn của cuộc trò chuyện
        List<Chat> chatList = chatImpl.getChats(users.getImage(), users.getFullName(), userID, idReceiver);
        // Giả sử tin nhắn mới nhất nằm ở cuối danh sách
        Chat newChat = chatList.get(chatList.size() - 1);

        // Đặt attribute cho JSP fragment
        req.setAttribute("myProfile", myProfile);
        req.setAttribute("c", newChat);

        // Forward đến chatItem.jsp (chỉ fragment HTML tin nhắn mới)
        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/chatItem.jsp");
        dispatcher.forward(req, resp);
    }

    private void showChat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userIDS = (String) session.getAttribute("userId");
        int userID = Integer.parseInt(userIDS);

        String chatID = req.getParameter("idHost");
        int idReceiver = Integer.parseInt(chatID);

        Users users = profileImpl.getUserById(idReceiver);
        Users myProfile = profileImpl.getUserById(userID);
        List<Chat> chat = chatImpl.getChats(users.getImage(), users.getFullName(), userID, idReceiver);
        List<Chat> allChat = chatImpl.getAllChats(userID);

        if (allChat.size() == 0) {
            Chat chatCheck = new Chat(userID, idReceiver, null);
            chatImpl.addChat(chatCheck);
            int idChat = chatCheck.getIdChat();
            Chat newChat = new Chat(idReceiver, users.getImage(), users.getFullName(), idChat, userID, idReceiver, "", "sent");
            allChat.add(newChat);
            chat.add(chatCheck);
        }
        req.setAttribute("myProfile", myProfile);
        req.setAttribute("idHost", idReceiver);
        req.setAttribute("allChat", allChat);
        req.setAttribute("chat", chat);

        RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/chat.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "showChat":
                showChat(req, resp);
                break;

            default:
                HttpSession session = req.getSession();
                String userIDS = (String) session.getAttribute("userId");
                int userID = Integer.parseInt(userIDS);

                List<Chat> allChat = chatImpl.getAllChats(userID);
                Users myProfile = profileImpl.getUserById(userID);

                req.setAttribute("allChat", allChat);
                req.setAttribute("myProfile", myProfile);

                RequestDispatcher dispatcher = req.getRequestDispatcher("view/user/chat.jsp");
                dispatcher.forward(req, resp);
                break;
        }
    }
}

