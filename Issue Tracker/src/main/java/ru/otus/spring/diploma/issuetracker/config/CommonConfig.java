package ru.otus.spring.diploma.issuetracker.config;

import com.github.mongobee.Mongobee;
import lombok.val;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CommonConfig {

    @Bean
    public Mongobee mongobee(@Value("${spring.data.mongodb.uri}") String mongoUri) {
        val runner = new Mongobee(mongoUri);
        runner.setChangeLogsScanPackage("ru.otus.spring.diploma.issuetracker.db.changelog");

        return runner;
    }
}
