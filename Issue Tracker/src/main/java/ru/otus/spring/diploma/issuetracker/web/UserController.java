package ru.otus.spring.diploma.issuetracker.web;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.service.UserService;
import ru.otus.spring.diploma.issuetracker.utils.CommonUtils;

import java.util.List;

@RestController @RequestMapping("users")
public class UserController {
    private final CommonUtils commonUtils;
    private final UserService userService;

    public UserController(CommonUtils commonUtils, UserService userService) {
        this.commonUtils = commonUtils;
        this.userService = userService;
    }


    @GetMapping
    public Mono<List<User>> getAll(Authentication auth) {
        return userService.getAll(commonUtils.extractDomain(auth));
    }
}
