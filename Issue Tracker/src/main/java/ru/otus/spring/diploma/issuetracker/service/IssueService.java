package ru.otus.spring.diploma.issuetracker.service;

import lombok.val;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.netflix.hystrix.HystrixCommands;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.db.dpo.IssueDpo;
import ru.otus.spring.diploma.issuetracker.db.repository.IssueRepository;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.exception.EntityNotFoundException;
import ru.otus.spring.diploma.issuetracker.exception.ExternalServiceUnavailableException;
import ru.otus.spring.diploma.issuetracker.utils.CommonUtils;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Create;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Edit;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

import static java.util.stream.Collectors.toList;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.VERY_LOW;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.CLOSED;
import static ru.otus.spring.diploma.issuetracker.service.UserService.FALLBACK_USER;

@Service
@Validated
public class IssueService {
    private final static Logger logger = LoggerFactory.getLogger(IssueService.class);

    public final static Issue FALLBACK_ISSUE = new Issue("unknown", "UNKNOWN", "Unknown issue (Internal error)",
            "Internal error occurred. Please contact our support", CLOSED, VERY_LOW, FALLBACK_USER, null);

    private final CommonUtils commonUtils;
    private final IssueRepository issueRepository;
    private final UserService userService;


    public IssueService(CommonUtils commonUtils, IssueRepository issueRepository, UserService userService) {
        this.commonUtils = commonUtils;
        this.issueRepository = issueRepository;
        this.userService = userService;
    }


    public Mono<Issue> getByVisibleId(@NotBlank String issueVisibleId, Authentication auth) {
        val result = issueRepository.findByVisibleIdAndDomain(issueVisibleId, extractDomain(auth)).flatMap(this::dpoToDomain);

        return HystrixCommands.from(result).commandName("IssueService.getByVisibleId")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "getByVisibleId", List.of(issueVisibleId), cause);
                        return FALLBACK_ISSUE;
                    });
                })
                .toMono();
    }

    public Mono<List<Issue>> getMany(@NotNull Issue example, @NotNull Sort sort, Authentication auth) {
        val exampleTerm = Example.of(
                IssueDpo.fromDomain(example.withDomain(extractDomain(auth))),
                ExampleMatcher.matching().withIgnoreNullValues()
        );

//        TODO: refactor this snippet to more pretty and correct...
        val result = issueRepository
                .findAll(exampleTerm, sort)
                .collectList()
                .zipWith(
                        issueRepository.findAll(exampleTerm, sort).flatMap(this::dpoToDomain).collectList(),
                        (orderedList, listWithResolvedUsers) -> orderedList.stream()
                                .map(i -> listWithResolvedUsers.stream()
                                        .filter(ii -> ii.getId().equals(i.getId()))
                                        .findAny().orElse(null)
                                )
                                .collect(toList())
                );

        return HystrixCommands.from(result).commandName("IssueService.getMany")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "getMany", List.of(example, sort), cause);
                        return List.of(FALLBACK_ISSUE);
                    });
                })
                .toMono();
    }

    @Validated(Create.class)
    public Mono<Void> createIssue(@Valid Issue issue, Authentication auth) {
        val result = issueRepository.save(IssueDpo.fromDomain(issue.withDomain(extractDomain(auth)))).then();

        return HystrixCommands.from(result).commandName("IssueService.createIssue")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.ignoreFallbackException(cause, DuplicateKeyException.class);
                        commonUtils.logFallback(logger, "createIssue", List.of(issue), cause);
                        throw new ExternalServiceUnavailableException();
                    });
                })
                .toMono();
    }

    @Validated(Edit.class)
    public Mono<Void> editIssue(@NotBlank String originalIssueVisibleId, @Valid Issue diffIssue, Authentication auth) {
        val result = issueRepository.findByVisibleIdAndDomain(originalIssueVisibleId, extractDomain(auth)).flatMap(issue -> {
            commonUtils.mergeObjects(issue, IssueDpo.fromDomain(diffIssue), IssueDpo.class);
            commonUtils.validate(issue);
            return issueRepository.save(issue).then();
        });

        return HystrixCommands.from(result).commandName("IssueService.editIssue")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "editIssue", List.of(originalIssueVisibleId, diffIssue), cause);
                        throw new ExternalServiceUnavailableException();
                    });
                })
                .toMono();
    }


    private Mono<Issue> dpoToDomain(IssueDpo dpo) {
        return userService.getOne(dpo.getAssigneeId())
                .switchIfEmpty(Mono.defer(() -> {
                    logger.error("User not found by id '{}' for issue '{}'", dpo.getAssigneeId(), dpo.getId());
                    return Mono.just(new User(dpo.getAssigneeId(), "Deleted user", null, null));
                }))
                .map(dpo::toDomain);
    }

    private String extractDomain(Authentication auth) {
        return auth.getAuthorities().iterator().next().getAuthority();
    }
}
