package com.example.baitapluyentap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class PathVariableController {
    @GetMapping("/pathVariable/{id}")
    public String PathVariable(Model model , @PathVariable int id){
        model.addAttribute("id" , id);
        return "pathVariable";
    }
}
