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
import ru.otus.spring.diploma.issuetracker.db.repository.LabelRepository;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.exception.ExternalServiceUnavailableException;
import ru.otus.spring.diploma.issuetracker.utils.CommonUtils;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Create;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Edit;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

import static java.util.stream.Collectors.toList;
import static org.springframework.data.domain.ExampleMatcher.GenericPropertyMatchers.contains;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.VERY_LOW;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.CLOSED;
import static ru.otus.spring.diploma.issuetracker.service.UserService.FALLBACK_USER;

@Service
@Validated
public class IssueService {
    private final static Logger logger = LoggerFactory.getLogger(IssueService.class);

    public final static Issue FALLBACK_ISSUE = new Issue("unknown", "UNKNOWN", "Unknown issue (Internal error)",
            "Internal error occurred. Please contact our support", CLOSED, VERY_LOW, List.of(), FALLBACK_USER, null);

    private final CommonUtils commonUtils;
    private final IssueRepository issueRepository;
    private final LabelRepository labelRepository;
    private final UserService userService;


    public IssueService(CommonUtils commonUtils, IssueRepository issueRepository, LabelRepository labelRepository, UserService userService) {
        this.commonUtils = commonUtils;
        this.issueRepository = issueRepository;
        this.labelRepository = labelRepository;
        this.userService = userService;
    }


    public Mono<Issue> getByVisibleId(@NotBlank String issueVisibleId, @NotNull Authentication auth) {
        final var result = issueRepository.findByVisibleIdAndDomain(issueVisibleId, commonUtils.extractDomain(auth)).flatMap(this::dpoToDomain);

        return HystrixCommands.from(result).commandName("IssueService.getByVisibleId")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "getByVisibleId", List.of(issueVisibleId, auth), cause);
                        return FALLBACK_ISSUE;
                    });
                })
                .toMono();
    }

    public Mono<List<Issue>> getMany(@NotNull Issue example, @NotNull Sort sort, @NotNull Authentication auth) {
        val exampleTerm = Example.of(
                IssueDpo.fromDomain(example.withDomain(commonUtils.extractDomain(auth))),
                ExampleMatcher.matching().withIgnoreNullValues()
        );

        val orderedIssuesMono = issueRepository.findAll(exampleTerm, sort).collectList();
        val issuesWithResolvedUsersMono = issueRepository.findAll(exampleTerm, sort).flatMap(this::dpoToDomain).collectList();

        final var result = Mono.zip(orderedIssuesMono, issuesWithResolvedUsersMono, (orderedIssues, issuesWithResolvedUsers) ->
                orderedIssues.stream()
                    .map(i -> issuesWithResolvedUsers.stream()
                            .filter(ii -> ii.getId().equals(i.getId()))
                            .findAny().orElse(null)
                    )
                    .collect(toList())
        );

        return HystrixCommands.from(result).commandName("IssueService.getMany")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "getMany", List.of(example, sort, auth), cause);
                        return List.of();
                    });
                })
                .toMono();
    }

    @Validated(Create.class)
    public Mono<Void> createIssue(@Valid Issue issue, @NotNull Authentication auth) {
        final var result = issueRepository.save(IssueDpo.fromDomain(issue.withDomain(commonUtils.extractDomain(auth)))).then();

        return HystrixCommands.from(result).commandName("IssueService.createIssue")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.ignoreFallbackException(cause, DuplicateKeyException.class);
                        commonUtils.logFallback(logger, "createIssue", List.of(issue, auth), cause);
                        throw new ExternalServiceUnavailableException();
                    });
                })
                .toMono();
    }

    @Validated(Edit.class)
    public Mono<Void> editIssue(@NotBlank String originalIssueVisibleId, @Valid Issue diffIssue, @NotNull Authentication auth) {
        final var result = issueRepository.findByVisibleIdAndDomain(originalIssueVisibleId, commonUtils.extractDomain(auth)).flatMap(issue -> {
            commonUtils.mergeObjects(issue, IssueDpo.fromDomain(diffIssue), IssueDpo.class);
            commonUtils.validate(issue);
            return issueRepository.save(issue).then();
        });

        return HystrixCommands.from(result).commandName("IssueService.editIssue")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "editIssue", List.of(originalIssueVisibleId, diffIssue, auth), cause);
                        throw new ExternalServiceUnavailableException();
                    });
                })
                .toMono();
    }


    private Mono<Issue> dpoToDomain(IssueDpo dpo) {
        val userMono = userService.getOneIgnoringDomain(dpo.getAssigneeId()).switchIfEmpty(Mono.defer(() -> {
            logger.error("User not found by id '{}' for issue '{}'", dpo.getAssigneeId(), dpo.getId());
            return Mono.just(new User(dpo.getAssigneeId(), "Deleted user", null, null));
        }));

        val labelsMono = labelRepository.findAllById(dpo.getLabelIds()).collectList();

        return Mono.zip(userMono, labelsMono, dpo::toDomain);
    }
}
