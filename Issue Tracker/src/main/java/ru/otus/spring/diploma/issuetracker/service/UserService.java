package ru.otus.spring.diploma.issuetracker.service;

import lombok.val;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.User;

import javax.validation.constraints.NotBlank;
import java.util.Map;

@Service
@Validated
public class UserService {

    public Mono<User> getOne(@NotBlank String id) {
//        TODO: remove stub
        val stub = Map.of(
                "1", new User("1", "Scott Matthews", "user1@mail.com"),
                "2", new User("2", "Jake Moore", "user2@mail.com"),
                "3", new User("3", "Javon Guzman", "user3@mail.com"),
                "4", new User("4", "Robert Burke", "user4@mail.com")
        );

        return stub.containsKey(id) ? Mono.just(stub.get(id)) : Mono.empty();
    }
}
