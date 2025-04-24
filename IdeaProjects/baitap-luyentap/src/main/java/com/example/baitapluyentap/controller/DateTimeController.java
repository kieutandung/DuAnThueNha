package com.example.baitapluyentap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Date;

@Controller
public class DateTimeController {
    @GetMapping("/datetime")
    public String datetime(Model model){
        Date date = new Date();
        model.addAttribute("date" , date);
        return "datetime";
    }
}
