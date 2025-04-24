package com.example.baitapluyentap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SumController {
    @GetMapping("/sum")
    public String sum(Model model , @RequestParam int a , @RequestParam int b){
        int result = a + b;
        model.addAttribute("result" , result);
        return "sum";
    }
}
