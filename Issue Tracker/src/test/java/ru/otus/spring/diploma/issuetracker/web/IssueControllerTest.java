package ru.otus.spring.diploma.issuetracker.web;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.util.Assert;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.db.repository.IssueRepository;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.service.UserService;

import java.util.List;

import static java.nio.charset.StandardCharsets.UTF_8;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.VERY_HIGH;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.NEW;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.REVIEW;

public class IssueControllerTest extends AbstractControllerTest {

    @MockBean private UserService userService;
    @Autowired private IssueRepository issueRepository;


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
    public void getByLabels() {
        testClient.get()
                .uri(builder -> builder.path("/issues")
                        .queryParam("labelId", label1.getId())
                        .queryParam("labelId", label2.getId())
                        .build()
                )
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Issue.class).isEqualTo(List.of(issue1));
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void create() {
        final var newIssue = new Issue(null, "OTUS-12", "Title12", "Desc12", NEW, VERY_HIGH, List.of(label1), user2, "programming");

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
        testClient.post().uri("/issues")
                .body(Mono.just(new Issue("1", "", "Title12", "Desc12", null, VERY_HIGH, List.of(), user2, "programming")), Issue.class)
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
        final var newIssue = new Issue(null, "OTUS-12", "Title12", "Desc12", NEW, VERY_HIGH, List.of(), user2, "programming");

        testClient.post()
                .uri("/issues").body(Mono.just(newIssue), Issue.class)
                .exchange()
                .expectStatus().isUnauthorized();
    }

    @Test
    @WithMockUser(authorities = {"programming"})
    public void create_duplicationVisibleIdError() {
        testClient.post()
                .uri("/issues").body(Mono.just(new Issue(null, "OTUS-1", "Title12", "Desc12", NEW, VERY_HIGH, List.of(), user2, "programming")), Issue.class)
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
    public void edit_label() {
        testClient.put()
                .uri("/issues/" + issue1.getVisibleId())
                .body(Mono.just(Issue.builder().labels(List.of()).build()), Issue.class)
                .exchange()
                .expectStatus().isOk()
                .expectBody().isEmpty();

        issue1.setLabels(List.of());

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
}
