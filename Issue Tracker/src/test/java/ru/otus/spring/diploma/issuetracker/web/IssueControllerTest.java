package ru.otus.spring.diploma.issuetracker.web;

import lombok.val;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.reactive.server.WebTestClient;
import org.springframework.util.Assert;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.db.repository.IssueRepository;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.security.UserAuthentication;
import ru.otus.spring.diploma.issuetracker.service.IssueService;
import ru.otus.spring.diploma.issuetracker.service.UserService;

import java.util.List;

import static java.nio.charset.StandardCharsets.UTF_8;
import static org.mockito.BDDMockito.given;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.HIGH;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.LOW;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.MEDIUM;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.VERY_HIGH;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.DEVELOPMENT;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.DONE;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.NEW;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.REVIEW;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.TESTING;

public class IssueControllerTest extends AbstractControllerTest {

    @Autowired
    private WebTestClient testClient;

    @Autowired
    private IssueService issueService;

    @Autowired
    private IssueRepository issueRepository;

    @MockBean
    private UserService userService;


    private final User user1 = new User("1", "Name1", "user1@mail.com", null);
    private final User user2 = new User("2", "Name2", "user2@mail.com", null);
    private final User user3 = new User("3", "Name3", "user3@mail.com", null);
    private final Issue issue1 = new Issue(null, "OTUS-1", "Title1", "Desc1", DEVELOPMENT, HIGH, user1, null);
    private final Issue issue2 = new Issue(null, "OTUS-2", "Title2", "Desc2", DEVELOPMENT, MEDIUM, user2, null);
    private final Issue issue3 = new Issue(null, "OTUS-3", "Title3", "Desc3", DONE, MEDIUM, user2, null);
    private final Issue issue4 = new Issue(null, "OTUS-4", "Title4", "Desc4", NEW, LOW, user1, null);
    private final Issue issue5 = new Issue(null, "OTUS-5", "Title5", "Desc5", TESTING, HIGH, user1, null);
    private final Issue issue6 = new Issue(null, "PM-1", "Title5", "Desc5", TESTING, HIGH, user3, null);
    private final Issue issue7 = new Issue(null, "PM-2", "Title5", "Desc5", TESTING, HIGH, user3, null);


    @Before
    public void setUp() {
        given(userService.getOneIgnoringDomain("1")).willReturn(Mono.just(user1));
        given(userService.getOneIgnoringDomain("2")).willReturn(Mono.just(user2));
        given(userService.getOneIgnoringDomain("3")).willReturn(Mono.just(user3));

        issueRepository.deleteAll().block();

        seedIssue(issue1, "programming");
        seedIssue(issue2, "programming");
        seedIssue(issue3, "programming");
        seedIssue(issue4, "programming");
        seedIssue(issue5, "programming");
        seedIssue(issue6, "business");
        seedIssue(issue7, "business");
    }


    @Test
    @WithMockUser(authorities = {"programming"})
    public void getOne() {
        testClient.get()
                .uri("/issues/" + issue1.getVisibleId() )
                .exchange()
                .expectStatus().isOk()
                .expectBody(Issue.class).isEqualTo(issue1);
    }

    @Test
    public void getOne_authError() {
        testClient.get()
                .uri("/issues/" + issue1.getVisibleId() )
                .exchange()
                .expectStatus().isUnauthorized();
    }

    @Test
    @WithMockUser(authorities = {"business"})
    public void getOne_withWrongDomain_returnNothing() {
        testClient.get()
                .uri("/issues/" + issue1.getVisibleId())
                .exchange()
                .expectStatus().isNotFound();
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void getAll() {
        testClient.get()
                .uri("/issues")
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Issue.class).isEqualTo(List.of(issue1, issue2, issue3, issue4, issue5));
    }

    @Test
    public void getAll_authError() {
        testClient.get()
                .uri("/issues")
                .exchange()
                .expectStatus().isUnauthorized();
    }

    @Test
    @WithMockUser(authorities = {"business"})
    public void getAll_withOtherDomain_returnOther() {
        testClient.get()
                .uri("/issues")
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Issue.class).isEqualTo(List.of(issue6, issue7));
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void getByAssignee() {
        testClient.get()
                .uri(builder -> builder.path("/issues").queryParam("assigneeId", user1.getId()).build())
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Issue.class).isEqualTo(List.of(issue1, issue4, issue5));
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void getByAssignee_withWrongAssignee() {
        testClient.get()
                .uri(builder -> builder.path("/issues").queryParam("assigneeId", "123").build())
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Issue.class).isEqualTo(List.of());
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void getAll_withSortByPriority() {
        testClient.get()
                .uri(builder -> builder.path("/issues").queryParam("priorityDirection", "DESC").build())
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Issue.class).isEqualTo(List.of(issue1, issue5, issue2, issue3, issue4));
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void getAll_withSortByStatus() {
        testClient.get()
                .uri(builder -> builder.path("/issues").queryParam("statusDirection", "ASC").build())
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Issue.class).isEqualTo(List.of(issue4, issue1, issue2, issue5, issue3));
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void getByAssignee_withSort() {
        testClient.get()
                .uri(builder -> builder.path("/issues")
                        .queryParam("assigneeId", user1.getId())
                        .queryParam("priorityDirection", "DESC")
                        .queryParam("statusDirection", "ASC")
                        .build()
                )
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Issue.class).isEqualTo(List.of(issue1, issue5, issue4));
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void create() {
        final var newIssue = new Issue(null, "OTUS-12", "Title12", "Desc12", NEW, VERY_HIGH, user2, "programming");

        testClient.post()
                .uri("/issues").body(Mono.just(newIssue), Issue.class)
                .exchange()
                .expectStatus().isOk()
                .expectBody().isEmpty();

        newIssue.setId(issueRepository.findByVisibleIdAndDomain("OTUS-12", "programming").block().getId());

        testClient.get()
                .uri("/issues/" + newIssue.getVisibleId())
                .exchange()
                .expectStatus().isOk()
                .expectBody(Issue.class).isEqualTo(newIssue.withDomain(null));
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void create_validationError() {
        testClient.post()
                .uri("/issues").body(Mono.just(new Issue("1", "", "Title12", "Desc12", null, VERY_HIGH, user2, "programming")), Issue.class)
                .exchange()
                .expectStatus().isBadRequest()
                .expectBody()
                    .jsonPath("$.status").isEqualTo(400)
                    .jsonPath("$.exception").isEqualTo("javax.validation.ConstraintViolationException")
                    .jsonPath("$.timestamp").isNotEmpty()
                    .consumeWith(byteRes -> {
                        final var res = new String(byteRes.getResponseBody(), UTF_8);

                        Assert.isTrue(res.contains("createIssue.issue.id: must be null"));
                        Assert.isTrue(res.contains("createIssue.issue.visibleId: must not be blank"));
                        Assert.isTrue(res.contains("createIssue.issue.status: must not be null"));
                    });
    }

    @Test
    public void create_authError() {
        final var newIssue = new Issue(null, "OTUS-12", "Title12", "Desc12", NEW, VERY_HIGH, user2, "programming");

        testClient.post()
                .uri("/issues").body(Mono.just(newIssue), Issue.class)
                .exchange()
                .expectStatus().isUnauthorized();
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void create_duplicationVisibleIdError() {
        testClient.post()
                .uri("/issues").body(Mono.just(new Issue(null, "OTUS-1", "Title12", "Desc12", NEW, VERY_HIGH, user2, "programming")), Issue.class)
                .exchange()
                .expectStatus().isBadRequest()
                .expectBody()
                    .jsonPath("$.status").isEqualTo(400)
                    .jsonPath("$.exception").isEqualTo("org.springframework.dao.DuplicateKeyException")
                    .jsonPath("$.timestamp").isNotEmpty()
                    .jsonPath("$.message").isNotEmpty();
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void edit() {
        testClient.put()
                .uri("/issues/" + issue1.getVisibleId())
                    .body(Mono.just(Issue.builder().title("New title").description("New description").build()), Issue.class)
                .exchange()
                .expectStatus().isOk()
                .expectBody().isEmpty();

        issue1.setTitle("New title");
        issue1.setDescription("New description");

        testClient.get()
                .uri("/issues/" + issue1.getVisibleId())
                .exchange()
                .expectStatus().isOk()
                .expectBody(Issue.class).isEqualTo(issue1);
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void edit_changeStatus() {
        testClient.put()
                .uri("/issues/" + issue1.getVisibleId())
                .body(Mono.just(Issue.builder().status(REVIEW).build()), Issue.class)
                .exchange()
                .expectStatus().isOk()
                .expectBody().isEmpty();

        issue1.setStatus(REVIEW);

        testClient.get()
                .uri("/issues/" + issue1.getVisibleId())
                .exchange()
                .expectStatus().isOk()
                .expectBody(Issue.class).isEqualTo(issue1);
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void edit_changeAssignee() {
        testClient.put()
                .uri("/issues/" + issue1.getVisibleId())
                .body(Mono.just(Issue.builder().assignee(user2).build()), Issue.class)
                .exchange()
                .expectStatus().isOk()
                .expectBody().isEmpty();

        issue1.setAssignee(user2);

        testClient.get()
                .uri("/issues/" + issue1.getVisibleId())
                .exchange()
                .expectStatus().isOk()
                .expectBody(Issue.class).isEqualTo(issue1);
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void edit_validationError() {
        testClient.put()
                .uri("/issues/" + issue1.getVisibleId())
                    .body(Mono.just(Issue.builder().id("123").build()), Issue.class)
                .exchange()
                .expectStatus().isBadRequest()
                .expectBody()
                    .jsonPath("$.status").isEqualTo(400)
                    .jsonPath("$.exception").isEqualTo("javax.validation.ConstraintViolationException")
                    .jsonPath("$.timestamp").isNotEmpty()
                    .jsonPath("$.message").isEqualTo("editIssue.diffIssue.id: must be null");
    }

    @Test
    public void edit_authError() {
        testClient.put()
                .uri("/issues/" + issue1.getVisibleId())
                .body(Mono.just(Issue.builder().title("New title").description("New description").build()), Issue.class)
                .exchange()
                .expectStatus().isUnauthorized();
    }


    private void seedIssue(Issue issue, String authority) {
        val auth = new UserAuthentication(User.builder().domain(authority).build());

        issueService.createIssue(issue, auth).block();
        issue.setId(issueService.getByVisibleId(issue.getVisibleId(), auth).block().getId());

        issue.setDomain(null);
    }
}
