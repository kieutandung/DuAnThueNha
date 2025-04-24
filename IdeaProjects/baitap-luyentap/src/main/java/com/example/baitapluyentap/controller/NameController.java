package com.example.baitapluyentap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NameController {
    @GetMapping("/name")
    public String name(Model model,@RequestParam String name){
        model.addAttribute("name",name);
        return "name";
    }
}
