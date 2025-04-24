package com.example.baitapluyentap.controller;

import com.example.baitapluyentap.model.User;
import jdk.internal.icu.text.UnicodeSet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;


@Controller
public class UserController {
    private List<User> userList = new ArrayList<>();
    public UserController(){
        userList.add(new User(1, "minh", "minh@gmail.com", "yen bai","1"));
        userList.add(new User(2, "huy", "huy@gmail.com", "ha noi"));
    }
    @GetMapping("/users")
    public String showUserList(Model model) {
        model.addAttribute("users", userList);
        return "userList";
    }
    @GetMapping("/userForm")
    public String showForm(Model model){
        model.addAttribute("user" , new User());
        return "userForm";
    }
    @PostMapping("/addUser")
    public String addUser(@ModelAttribute("user") User user) {
        userList.add(user);
        return "redirect:/users";
    }
//    @GetMapping("/users")
//    public ModelAndView showUserList() {
//        ModelAndView mav = new ModelAndView("userList");
//        mav.addObject("users", userList);
//        return mav;
//    }
//    @GetMapping("/userForm")
//    public ModelAndView showForm() {
//        ModelAndView mav = new ModelAndView("userForm");
//        mav.addObject("user", new User());
//        return mav;
//    }
//    @PostMapping("/addUser")
//    public ModelAndView addUser(@ModelAttribute("user") User user) {
//        userList.add(user);
//        return new ModelAndView("redirect:/users");
//    }
    @GetMapping("/register")
    public ModelAndView showRegister(){
        return new ModelAndView("register" , "user" , new User());
    }
    @PostMapping("/register")
    public ModelAndView register(@ModelAttribute("user") User user){
        userList.add(user);
        return new ModelAndView("redirect:/users");
    }
    @GetMapping("/edit/{id}")
    public ModelAndView showEdit(@PathVariable("id") int id){
        User userToEdit = null;
        for (User u : userList) {
            if (u.getId() == id) {
                userToEdit = u;
                break;
            }
        }
        return new ModelAndView("edit" , "user" , userToEdit);
    }
    @PostMapping("/editUser")
    public String updateUser(@ModelAttribute("user") User user) {
        for (User u : userList) {
            if (u.getId() == user.getId()) {
                u.setName(user.getName());
                u.setEmail(user.getEmail());
                u.setPassword(user.getPassword());
                u.setAddress(user.getAddress());
                break;
            }
        }
        return "redirect:/users";
    }
    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable int id) {
        userList.removeIf(user -> user.getId() == id);
        return "redirect:/users";
    }
    @GetMapping("/search")
    public String searchUser(@RequestParam("keyword") String keyword, Model model) {
        List<User> result = new ArrayList<>();
        for (User u : userList) {
            if (u.getName().toLowerCase().contains(keyword.toLowerCase()) ||
                    u.getEmail().toLowerCase().contains(keyword.toLowerCase())) {
                result.add(u);
            }
        }
        model.addAttribute("users", result);
        return "userList";
    }
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }
    @PostMapping("/login")
    public String handleLogin(@ModelAttribute("user") User user, Model model) {
        String username = user.getName();
        String password = user.getPassword();

        for (User u : userList) {
            if (u.getName().equals(username) && u.getPassword().equals(password)) {
                return "redirect:/users";
            }
        }
        return "login";
    }

}
