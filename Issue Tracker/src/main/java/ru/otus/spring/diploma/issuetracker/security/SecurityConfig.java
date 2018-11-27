package ru.otus.spring.diploma.issuetracker.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity http, JwtServerSecurityContextRepository contextRepository) {
        return http
                .csrf().disable()
                .httpBasic().disable()
                .formLogin().disable()

                .securityContextRepository(contextRepository)

                .authorizeExchange()
                .pathMatchers("/swagger-ui.html", "/v2/api-docs", "/actuator/**").permitAll()
                .and()

                .authorizeExchange()
                .pathMatchers("/**").authenticated()
                .and()

                .build();
    }
}
