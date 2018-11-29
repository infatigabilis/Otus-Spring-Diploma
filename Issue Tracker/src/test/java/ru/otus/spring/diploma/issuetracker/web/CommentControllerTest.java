package ru.otus.spring.diploma.issuetracker.web;

import lombok.val;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.reactive.server.WebTestClient;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.db.repository.CommentRepository;
import ru.otus.spring.diploma.issuetracker.db.repository.IssueRepository;
import ru.otus.spring.diploma.issuetracker.domain.Comment;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.security.UserAuthentication;
import ru.otus.spring.diploma.issuetracker.service.CommentService;
import ru.otus.spring.diploma.issuetracker.service.IssueService;
import ru.otus.spring.diploma.issuetracker.service.UserService;

import java.util.List;

import static org.mockito.BDDMockito.given;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.HIGH;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.MEDIUM;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.DEVELOPMENT;

public class CommentControllerTest extends AbstractControllerTest {

    @Autowired private WebTestClient testClient;
    @Autowired private CommentService commentService;
    @Autowired private IssueRepository issueRepository;
    @Autowired private CommentRepository commentRepository;
    @MockBean private UserService userService;

    private final User user1 = new User("user1", "Name1", "user1@mail.com", null);
    private final User user2 = new User("user2", "Name2", "user2@mail.com", null);
    private final User user3 = new User("user3", "Name3", "user3@mail.com", null);
    private final Issue issue1 = new Issue(null, "OTUS-1", "Title1", "Desc1", DEVELOPMENT, HIGH, user1, null);
    private final Issue issue2 = new Issue(null, "OTUS-2", "Title2", "Desc2", DEVELOPMENT, MEDIUM, user3, null);
    private final Comment comment1 = new Comment(null, "Comment1", user1, issue1);
    private final Comment comment2 = new Comment(null, "Comment2", user2, issue1);
    private final Comment comment3 = new Comment(null, "Comment3", user3, issue2);

    @Before
    public void setUp() {
        given(userService.getOneIgnoringDomain("user1")).willReturn(Mono.just(user1));
        given(userService.getOneIgnoringDomain("user2")).willReturn(Mono.just(user2));
        given(userService.getOneIgnoringDomain("user3")).willReturn(Mono.just(user3));

        issueRepository.deleteAll().block();
        commentRepository.deleteAll().block();

        seedIssue(issue1, "programming");
        seedIssue(issue2, "business");

        seedComment(comment1, "programming");
        seedComment(comment2, "programming");
        seedComment(comment3, "business");
    }


    @Test
    @WithMockUser(authorities = "programming")
    public void getAllByVisibleId() {
        comment1.setIssue(null);
        comment2.setIssue(null);

        testClient.get().uri("/comments?issueVisibleId=" + issue1.getVisibleId())
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Comment.class).isEqualTo(List.of(comment1, comment2));
    }

    @Test
    public void getAllByVisibleId_withWrongAuth_returnError() {
        testClient.get().uri("/comments?issueVisibleId=" + issue1.getVisibleId())
                .exchange()
                .expectStatus().isUnauthorized();
    }

    @Test
    @WithMockUser(authorities = "business")
    public void getAllByVisibleId_withWrongDomain_returnEmpty() {
        testClient.get().uri("/comments?issueVisibleId=" + issue1.getVisibleId())
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Comment.class).isEqualTo(List.of());
    }

    @Test
    @WithMockUser
    public void add() {
        val auth = new UserAuthentication(User.builder().id("user1").domain("programming").build());
        SecurityContextHolder.getContext().setAuthentication(auth);

        val newComment = new Comment(null, "Comment4", user1, issue1);

        testClient.post().uri("/comments?issueVisibleId=" + issue1.getVisibleId())
                .body(Mono.just(newComment), Comment.class)
                .exchange()
                .expectStatus().isOk();

        comment1.setIssue(null);
        comment2.setIssue(null);
        newComment.setId(commentService.getAllByIssueVisibleId(newComment.getIssue().getVisibleId(), auth).block().stream().reduce((f, s) -> s).get().getId());
        newComment.setIssue(null);

        testClient.get().uri("/comments?issueVisibleId=" + issue1.getVisibleId())
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Comment.class).isEqualTo(List.of(comment1, comment2, newComment));
    }

    @Test
    public void add_withWrongAuth_returnError() {
        testClient.post().uri("/comments?issueVisibleId=" + issue1.getVisibleId())
                .exchange()
                .expectStatus().isUnauthorized();
    }

    @Test
    @WithMockUser(authorities = "business")
    public void add_withWrongDomain_returnError() {
        val newComment = new Comment(null, "Comment4", user1, issue1);

        testClient.post().uri("/comments?issueVisibleId=" + issue1.getVisibleId())
                .body(Mono.just(newComment), Comment.class)
                .exchange()
                .expectStatus().isNotFound();
    }


    private void seedComment(Comment comment, String authority) {
        val auth = new UserAuthentication(User.builder().id(comment.getUser().getId()).domain(authority).build());

        commentService.add(comment, comment.getIssue().getVisibleId(), auth).block();
        comment.setId(commentService.getAllByIssueVisibleId(comment.getIssue().getVisibleId(), auth).block().stream().reduce((f, s) -> s).get().getId());

        comment.getIssue().setDomain(null);
    }
}
