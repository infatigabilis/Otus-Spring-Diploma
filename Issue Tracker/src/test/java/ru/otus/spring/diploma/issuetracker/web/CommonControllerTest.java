package ru.otus.spring.diploma.issuetracker.web;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.security.test.context.support.WithSecurityContext;
import org.springframework.test.web.reactive.server.WebTestClient;

public class CommonControllerTest extends AbstractControllerTest {

    @Autowired
    private WebTestClient testClient;


    @Test
    @WithMockUser
    public void wrongEnumParam() {
        testClient.get()
                .uri(builder -> builder.path("/issues").queryParam("priorityDirection", "WRONG").build())
                .exchange()
                .expectStatus().isBadRequest()
                .expectBody()
                    .jsonPath("$.status").isEqualTo(400)
                    .jsonPath("$.exception").isEqualTo("org.springframework.web.server.ServerWebInputException")
                    .jsonPath("$.timestamp").isNotEmpty()
                    .jsonPath("$.message").isNotEmpty();
    }

    @Test
    public void getSwagger() {
        testClient.get().uri("/v2/api-docs")
                .exchange()
                .expectStatus().isOk();
    }

    @Test
    public void getSwaggerUi() {
        testClient.get().uri("swagger-ui.html")
                .exchange()
                .expectStatus().isOk();
    }
}
