package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
    @RequestMapping(value = "/")
    public String home() {
        return "login";
    }

    @PostMapping(value = { "/loginAction" })
    public String loginAction() {
        return "redirect:/brand";
    }


}
