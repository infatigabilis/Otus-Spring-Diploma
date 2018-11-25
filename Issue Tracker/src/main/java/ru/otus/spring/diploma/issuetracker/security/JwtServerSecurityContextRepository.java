package ru.otus.spring.diploma.issuetracker.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.jwk.source.JWKSource;
import com.nimbusds.jose.jwk.source.RemoteJWKSet;
import com.nimbusds.jose.proc.JWSVerificationKeySelector;
import com.nimbusds.jwt.proc.BadJWTException;
import com.nimbusds.jwt.proc.DefaultJWTProcessor;
import lombok.val;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.security.web.server.context.ServerSecurityContextRepository;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.User;

import java.net.MalformedURLException;
import java.net.URL;
import java.text.MessageFormat;
import java.util.Map;

import static org.springframework.util.StringUtils.isEmpty;

@Component
public class JwtServerSecurityContextRepository implements ServerSecurityContextRepository {
    private final static Logger logger = LoggerFactory.getLogger(JwtServerSecurityContextRepository.class);

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final JWKSource keySource;

    public JwtServerSecurityContextRepository(
            @Value("${security.keycloak.host}") String keycloakHost,
            @Value("${security.keycloak.realm}") String keycloakRealm
    ) {
        try {
            val stringUrl = MessageFormat.format("{0}/auth/realms/{1}/protocol/openid-connect/certs", keycloakHost, keycloakRealm);
            this.keySource = new RemoteJWKSet(new URL(stringUrl));
        } catch (MalformedURLException e) {
            throw new IllegalStateException("Invalid JWK url", e);
        }
    }

    @Override
    public Mono<Void> save(ServerWebExchange serverWebExchange, SecurityContext securityContext) {
        throw new UnsupportedOperationException();
    }

    @Override
    public Mono<SecurityContext> load(ServerWebExchange serverWebExchange) {
        val authHeader = serverWebExchange.getRequest().getHeaders().getFirst(HttpHeaders.AUTHORIZATION);

        if (isEmpty(authHeader) || !authHeader.startsWith("Bearer ")) {
            return Mono.empty();
        }

        val jwt = authHeader.substring(7);

        return parseJwt(jwt).map(SecurityContextImpl::new);
    }

    private Mono<Authentication> parseJwt(String jwt) {
        try {
            val jwtProcessor = new DefaultJWTProcessor();
            jwtProcessor.setJWSKeySelector(new JWSVerificationKeySelector(JWSAlgorithm.RS256, keySource));

            val rawClaim = jwtProcessor.process(jwt, null);

            val claim = objectMapper.readValue(rawClaim.toString(), Map.class);

            val user = new User(
                    (String) claim.get("preferred_username"),
                    (String) claim.get("name"),
                    (String) claim.get("email"),
                    (String) ((Map) claim.get("attr")).get("domain")
            );

            return Mono.just(new UserAuthentication(user));

        } catch (BadJWTException e) {
            return Mono.empty();
        } catch (Exception e) {
            logger.error("Failed to parse jwt", e);
            return Mono.empty();
        }
    }
}
