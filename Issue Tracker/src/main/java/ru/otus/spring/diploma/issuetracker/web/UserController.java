package ru.otus.spring.diploma.issuetracker.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.service.UserService;

import java.util.List;

@RestController @RequestMapping("users")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }


    @GetMapping
    public Mono<List<User>> getAll() {
        return userService.getAll();
    }
}
