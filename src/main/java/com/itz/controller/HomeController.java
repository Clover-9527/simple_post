package com.itz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 首页
 */
@Controller
@RequestMapping("/home")
public class HomeController {

    @RequestMapping("toHome")
    public String toHome(){
        return "/home/home";
    }

}
