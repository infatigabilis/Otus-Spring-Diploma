package ru.otus.spring.diploma.issuetracker.service;

import javassist.NotFoundException;
import lombok.val;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.netflix.hystrix.HystrixCommands;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.db.dpo.CommentDpo;
import ru.otus.spring.diploma.issuetracker.db.repository.CommentRepository;
import ru.otus.spring.diploma.issuetracker.domain.Comment;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.exception.EntityNotFoundException;
import ru.otus.spring.diploma.issuetracker.exception.ExternalServiceUnavailableException;
import ru.otus.spring.diploma.issuetracker.utils.CommonUtils;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Create;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Service
@Validated
public class CommentService {
    private final static Logger logger = LoggerFactory.getLogger(CommentService.class);

    private final CommentRepository commentRepository;
    private final CommonUtils commonUtils;
    private final UserService userService;
    private final IssueService issueService;

    public CommentService(CommentRepository commentRepository, CommonUtils commonUtils, UserService userService, IssueService issueService) {
        this.commentRepository = commentRepository;
        this.commonUtils = commonUtils;
        this.userService = userService;
        this.issueService = issueService;
    }


    public Flux<Comment> getAllByIssueVisibleId(@NotBlank String issueVisibleId, @NotNull Authentication auth) {
        final var result = issueService.getByVisibleId(issueVisibleId, auth).flatMapMany(issue ->
                commentRepository.findAllByIssueId(issue.getId()).flatMapSequential(dpo -> dpoToDomain(dpo, issue))
        );

        return HystrixCommands.from(result).commandName("CommentService.getAllByIssueVisibleId")
                .fallback(cause -> {
                    return Flux.defer(() -> {
                        commonUtils.logFallback(logger, "getAllByIssueVisibleId", List.of(issueVisibleId, auth), cause);
                        return Flux.empty();
                    });
                })
                .toFlux();
    }

    @Validated(Create.class)
    public Mono<Void> add(@Valid Comment comment, @NotBlank String issueVisibleId, @NotNull Authentication auth) {
        final var result = issueService.getByVisibleId(issueVisibleId, auth).switchIfEmpty(Mono.fromCallable(() -> { throw new EntityNotFoundException(); })).flatMap(issue ->
                userService.getOneIgnoringDomain(auth.getPrincipal().toString()).flatMap(user -> {
                    comment.setIssue(issue);
                    comment.setUser(user);
                    comment.setDate(new Date());
                    return commentRepository.save(CommentDpo.fromDomain(comment)).then();
                })
        );

        return HystrixCommands.from(result).commandName("CommentService.add")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "add", List.of(comment, issueVisibleId, auth), cause);
                        throw new ExternalServiceUnavailableException();
                    });
                })
                .toMono();
    }


    private Mono<Comment> dpoToDomain(CommentDpo dpo, Issue issue) {
        return userService.getOneIgnoringDomain(dpo.getUserId()).map(user ->
                dpo.toDomain(user, issue)
        );
    }
}
