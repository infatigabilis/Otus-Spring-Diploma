package ru.otus.spring.diploma.issuetracker.web;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.reactive.server.WebTestClient;
import ru.otus.spring.diploma.issuetracker.domain.Label;
import ru.otus.spring.diploma.issuetracker.service.UserService;

import java.util.List;

public class LabelControllerTest extends AbstractControllerTest {

    @MockBean private UserService userService;

    @Test
    @WithMockUser(authorities = "programming")
    public void getAll() {
        testClient.get().uri("/labels")
                .exchange()
                .expectStatus().isOk()
                .expectBodyList(Label.class).isEqualTo(List.of(label1, label2));
    }

    @Test
    public void getAll_authError() {
        testClient.get().uri("/labels")
                .exchange()
                .expectStatus().isUnauthorized();
    }
}
