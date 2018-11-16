package ru.otus.spring.diploma.issuetracker.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.netflix.hystrix.HystrixCommands;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.utils.CommonUtils;

import javax.validation.constraints.NotBlank;
import java.util.List;
import java.util.Map;

@Service
@Validated
public class UserService {
    private final Logger logger = LoggerFactory.getLogger(UserService.class);

    public final static User FALLBACK_USER = new User("unknown", "Unknown user (Internal Error)", "unknown.user@mail.com");

    private final CommonUtils commonUtils;


    public UserService(CommonUtils commonUtils) {
        this.commonUtils = commonUtils;
    }


    public Mono<User> getOne(@NotBlank String id) {
//        TODO: remove stub
        final var stub = Map.of(
                "1", new User("1", "Scott Matthews", "user1@mail.com"),
                "2", new User("2", "Jake Moore", "user2@mail.com"),
                "3", new User("3", "Javon Guzman", "user3@mail.com"),
                "4", new User("4", "Robert Burke", "user4@mail.com")
        );

        final Mono<User> result = stub.containsKey(id) ? Mono.just(stub.get(id)) : Mono.empty();

        return HystrixCommands.from(result).commandName("IssueService.getOne")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "getOne", List.of(id), cause);
                        return FALLBACK_USER;
                    });
                })
                .toMono();
    }
}
