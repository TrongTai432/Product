package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = { "/" })
public class IndexController {
    @RequestMapping(value = "/")
    public String home() {
        return "redirect:/login";
    }
    @RequestMapping(value = "/login")
    public String login() {
        return "login";
    }

    @PostMapping(value = { "/loginAction" })
    public String loginAction() {
        return "redirect:/product";
    }
}
