package ru.otus.spring.diploma.issuetracker.web;

import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.exception.EntityNotFoundException;
import ru.otus.spring.diploma.issuetracker.service.IssueService;

import java.util.List;

@RestController @RequestMapping("issues")
public class IssueController {
    private final IssueService issueService;

    public IssueController(IssueService issueService) {
        this.issueService = issueService;
    }


    @GetMapping("{visibleId}")
    public Mono<Issue> getOne(@PathVariable String visibleId, Authentication auth) {
        return issueService.getByVisibleId(visibleId, auth)
                .switchIfEmpty(Mono.fromCallable(() -> { throw new EntityNotFoundException(); }));
    }

    @GetMapping
    public Mono<List<Issue>> getMany(
            @RequestParam(required = false) String assigneeId,
            @RequestParam(required = false) Sort.Direction priorityDirection,
            @RequestParam(required = false) Sort.Direction statusDirection,
            Authentication auth) {

        final var exampleIssue = Issue.builder()
                .assignee(User.builder().id(assigneeId).build())
                .build();

        var sortTerm = Sort.unsorted();
        if (priorityDirection != null) {
            sortTerm = sortTerm.and(Sort.by(priorityDirection, "priorityOrdinal"));
        }
        if (statusDirection != null) {
            sortTerm = sortTerm.and(Sort.by(statusDirection, "statusOrdinal"));
        }

        return issueService.getMany(exampleIssue, sortTerm, auth);
    }

    @PostMapping
    public Mono<Void> create(@RequestBody Issue issue, Authentication auth) {
        return issueService.createIssue(issue, auth);
    }

    @PutMapping("{visibleId}")
    public Mono<Void> edit(@PathVariable String visibleId, @RequestBody Issue diffIssue, Authentication auth) {
        return issueService.editIssue(visibleId, diffIssue, auth);
    }
}
