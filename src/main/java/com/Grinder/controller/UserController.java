package com.Grinder.controller;

import com.Grinder.domain.User;
import com.Grinder.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class UserController {
    private final UserRepository userRepository;

    @PostMapping("/users")
    public Long create(@RequestParam String name) {
        User user = User.builder().name(name).build();
        userRepository.save(user);
        return user.getId();
    }

    @GetMapping("/users/{id}")
    public User findOne(@PathVariable("id") Long id) {
        return userRepository.findById(id).orElseThrow();
    }
}
