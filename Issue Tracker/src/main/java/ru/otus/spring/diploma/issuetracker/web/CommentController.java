package ru.otus.spring.diploma.issuetracker.web;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.Comment;
import ru.otus.spring.diploma.issuetracker.service.CommentService;

import java.util.List;

@RestController @RequestMapping("comments")
public class CommentController {
    private final CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }


    @GetMapping
    public Flux<Comment> getAllByIssueVisibleId(@RequestParam String issueVisibleId, Authentication auth) {
        return commentService.getAllByIssueVisibleId(issueVisibleId, auth);
    }

    @PostMapping
    public Mono<Void> add(@RequestBody Comment comment, @RequestParam String issueVisibleId, Authentication auth) {
        return commentService.add(comment, issueVisibleId, auth);
    }
}
