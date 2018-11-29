package ru.otus.spring.diploma.issuetracker.web;

import lombok.val;
import org.junit.FixMethodOrder;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import ru.otus.spring.diploma.issuetracker.IssueTrackerApplication;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.security.UserAuthentication;
import ru.otus.spring.diploma.issuetracker.service.IssueService;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public abstract class AbstractControllerTest {

    @Autowired private IssueService issueService;


    protected void seedIssue(Issue issue, String authority) {
        val auth = new UserAuthentication(User.builder().domain(authority).build());

        issueService.createIssue(issue, auth).block();
        issue.setId(issueService.getByVisibleId(issue.getVisibleId(), auth).block().getId());

        issue.setDomain(null);
    }
}
