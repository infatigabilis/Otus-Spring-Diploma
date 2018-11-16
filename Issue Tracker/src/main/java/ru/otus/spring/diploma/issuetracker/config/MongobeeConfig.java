package ru.otus.spring.diploma.issuetracker.config;

import com.github.mongobee.Mongobee;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MongobeeConfig {

    @ConditionalOnProperty(value = "mongobee.enabled", havingValue = "true")
    @Bean
    public Mongobee mongobee(@Value("${spring.data.mongodb.uri}") String mongoUri) {
        final var runner = new Mongobee(mongoUri);
        runner.setChangeLogsScanPackage("ru.otus.spring.diploma.issuetracker.db.changelog");

        return runner;
    }
}
