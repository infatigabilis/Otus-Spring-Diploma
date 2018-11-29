package ru.otus.spring.diploma.issuetracker.web;

import lombok.val;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.reactive.server.WebTestClient;
import org.springframework.util.Assert;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.db.repository.IssueRepository;
import ru.otus.spring.diploma.issuetracker.db.repository.LabelRepository;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.domain.Label;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.security.UserAuthentication;
import ru.otus.spring.diploma.issuetracker.service.IssueService;
import ru.otus.spring.diploma.issuetracker.service.LabelService;
import ru.otus.spring.diploma.issuetracker.service.UserService;

import java.util.List;

import static org.mockito.BDDMockito.given;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.HIGH;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.LOW;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.MEDIUM;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.DEVELOPMENT;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.DONE;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.NEW;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.TESTING;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public abstract class AbstractControllerTest {

    @Autowired protected WebTestClient testClient;
    @Autowired private IssueService issueService;
    @Autowired private IssueRepository issueRepository;
    @Autowired private LabelService labelService;
    @Autowired private LabelRepository labelRepository;

    protected final User user1 = new User("user1", "Name1", "user1@mail.com", null);
    protected final User user2 = new User("user2", "Name2", "user2@mail.com", null);
    protected final User user3 = new User("user3", "Name3", "user3@mail.com", null);

    protected final Label label1 = new Label(null, "Label 1", "programming");
    protected final Label label2 = new Label(null, "Label 2", "programming");

    protected final Issue issue1 = new Issue(null, "OTUS-1", "Title1", "Desc1", DEVELOPMENT, HIGH, List.of(label1, label2), user1, null);
    protected final Issue issue2 = new Issue(null, "OTUS-2", "Title2", "Desc2", DEVELOPMENT, MEDIUM, List.of(label1), user2, null);
    protected final Issue issue3 = new Issue(null, "OTUS-3", "Title3", "Desc3", DONE, MEDIUM, List.of(), user2, null);
    protected final Issue issue4 = new Issue(null, "OTUS-4", "Title4", "Desc4", NEW, LOW, List.of(), user1, null);
    protected final Issue issue5 = new Issue(null, "OTUS-5", "Title5", "Desc5", TESTING, HIGH, List.of(label2), user1, null);
    protected final Issue issue6 = new Issue(null, "PM-1", "Title5", "Desc5", TESTING, HIGH, List.of(), user3, null);
    protected final Issue issue7 = new Issue(null, "PM-2", "Title5", "Desc5", TESTING, HIGH, List.of(), user3, null);

    @Before
    public void defaultSetUp() throws IllegalAccessException {
        val userService = (UserService) FieldUtils.readField(this, "userService", true);
        Assert.notNull(userService);

        given(userService.getOneIgnoringDomain("user1")).willReturn(Mono.just(user1));
        given(userService.getOneIgnoringDomain("user2")).willReturn(Mono.just(user2));
        given(userService.getOneIgnoringDomain("user3")).willReturn(Mono.just(user3));

        issueRepository.deleteAll().block();
        labelRepository.deleteAll().block();

        seedLabel(label1);
        seedLabel(label2);

        seedIssue(issue1, "programming");
        seedIssue(issue2, "programming");
        seedIssue(issue3, "programming");
        seedIssue(issue4, "programming");
        seedIssue(issue5, "programming");
        seedIssue(issue6, "business");
        seedIssue(issue7, "business");
    }


    protected void seedLabel(Label label) {
        val auth = new UserAuthentication(User.builder().domain(label.getDomain()).build());

        labelService.add(label, auth).block();
        label.setId(labelService.getAll(auth).block().stream().reduce((f, s) -> s).get().getId());

        label.setDomain(null);
    }

    protected void seedIssue(Issue issue, String authority) {
        val auth = new UserAuthentication(User.builder().domain(authority).build());

        issueService.createIssue(issue, auth).block();
        issue.setId(issueService.getByVisibleId(issue.getVisibleId(), auth).block().getId());

        issue.setDomain(null);
    }
}
