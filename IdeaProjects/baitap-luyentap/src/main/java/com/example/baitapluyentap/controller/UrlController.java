package com.example.baitapluyentap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UrlController {
    @GetMapping({"/" , "/a" ,"/b" , "/c"})
    public String url(){
        return "home";
    }
}
