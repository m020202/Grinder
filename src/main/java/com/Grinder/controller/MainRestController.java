package com.Grinder.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainRestController {
    @GetMapping("/")
    public String hello() {
        return "Hello, this is nginx to spring server!!";
    }

    @GetMapping("/health")
    public String healthCheck() {
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        return "Hello !!";
    }
}
