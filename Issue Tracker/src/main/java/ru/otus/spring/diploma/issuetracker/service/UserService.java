package ru.otus.spring.diploma.issuetracker.service;

import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;
import lombok.val;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cloud.netflix.hystrix.HystrixCommands;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.User;
import ru.otus.spring.diploma.issuetracker.utils.CommonUtils;

import javax.annotation.Nullable;
import javax.validation.constraints.NotBlank;
import java.text.MessageFormat;
import java.util.List;

import static java.util.stream.Collectors.toList;
import static org.springframework.util.StringUtils.isEmpty;
import static org.springframework.web.reactive.function.BodyInserters.fromFormData;

//TODO: add tests
@Service
@Validated
public class UserService {
    private final Logger logger = LoggerFactory.getLogger(UserService.class);

    public final static User FALLBACK_USER = new User("unknown", "Unknown user (Internal Error)", "unknown.user@mail.com", null);

    private final CommonUtils commonUtils;

    private final String keycloakHost;
    private final String keycloakRealm;
    private final String keycloakAdminUsername;
    private final String keycloakAdminPassword;


    public UserService(
            CommonUtils commonUtils,
            @Value("${security.keycloak.host}") String keycloakHost,
            @Value("${security.keycloak.realm}") String keycloakRealm,
            @Value("${security.keycloak.admin.username}") String keycloakAdminUsername,
            @Value("${security.keycloak.admin.password}") String keycloakAdminPassword) {
        this.commonUtils = commonUtils;
        this.keycloakHost = keycloakHost;
        this.keycloakRealm = keycloakRealm;
        this.keycloakAdminUsername = keycloakAdminUsername;
        this.keycloakAdminPassword = keycloakAdminPassword;
    }


    @Cacheable("users")
    public Mono<User> getOne(@NotBlank String id) {
        val result = getKeycloakAdminAccessToken().flatMap(adminToken ->
                getKeycloakUsers(adminToken, id).map(keycloakUsers ->
                        keycloakUsers.stream().map(KeycloakUser::toDomain).collect(toList()).get(0)
                )
        );

        return HystrixCommands.from(result).commandName("IssueService.getOne")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "getOne", List.of(id), cause);
                        return FALLBACK_USER;
                    });
                })
                .toMono()
                .cache();
    }

    @Cacheable("users")
    public Mono<List<User>> getAll() {
        val result = getKeycloakAdminAccessToken().flatMap(adminToken ->
            getKeycloakUsers(adminToken, null).map(keycloakUsers ->
                    keycloakUsers.stream().map(KeycloakUser::toDomain).collect(toList())
            )
        );

        return HystrixCommands.from(result).commandName("IssueService.getAll")
                .fallback(cause -> {
                    return Mono.fromCallable(() -> {
                        commonUtils.logFallback(logger, "getAll", List.of(), cause);
                        return List.of(FALLBACK_USER);
                    });
                })
                .toMono()
                .cache();
    }

    private Mono<String> getKeycloakAdminAccessToken() {
        return WebClient.create()
                .post().uri(keycloakHost + "/auth/realms/master/protocol/openid-connect/token")
                .body(
                        fromFormData("client_id", "admin-cli")
                                .with("username", keycloakAdminUsername)
                                .with("password", keycloakAdminPassword)
                                .with("grant_type", "password")
                )
                .retrieve()

                .bodyToMono(KeycloakAuthToken.class)
                .map(KeycloakAuthToken::getAccessToken);
    }

    private Mono<List<KeycloakUser>> getKeycloakUsers(String adminAccessToken, @Nullable String filteredUsername) {
        val url = isEmpty(filteredUsername)
                ? MessageFormat.format("{0}/auth/admin/realms/{1}/users", keycloakHost, keycloakRealm)
                : MessageFormat.format("{0}/auth/admin/realms/{1}/users?username={2}", keycloakHost, keycloakRealm, filteredUsername);

        return WebClient.create()
                .get().uri(url)
                .header("Authorization", "Bearer " + adminAccessToken)
                .retrieve()

//                if replace to "new ParameterizedTypeReference<>() {}" how IDEA recommend,
//                you can receive JAVA INTERNAL(!!!) COMPILER ERROR!
                .bodyToMono(new ParameterizedTypeReference<List<KeycloakUser>>() {});
    }

    @Data
    @JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
    public static class KeycloakAuthToken {
        private String accessToken;
    }

    @Data
    public static class KeycloakUser {
        private String username;
        private String firstName;
        private String lastName;
        private String email;
        private Attributes attributes;

        @Data
        public static class Attributes {
            private List<String> domain;
        }

        public User toDomain() {
            return new User(username, firstName + " " + lastName, email, attributes.getDomain().get(0));
        }
    }
}
