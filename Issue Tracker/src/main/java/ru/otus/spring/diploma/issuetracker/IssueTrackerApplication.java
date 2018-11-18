package ru.otus.spring.diploma.issuetracker;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.netflix.hystrix.EnableHystrix;
import org.springframework.data.mongodb.repository.config.EnableReactiveMongoRepositories;

@SpringBootApplication
@EnableReactiveMongoRepositories
@EnableEurekaClient
@EnableHystrix
public class IssueTrackerApplication {

    public static void main(String[] args) {
        try {
            SpringApplication.run(IssueTrackerApplication.class, args);

        } catch (Exception e) {
            System.out.println("Exit because of application failed to start");
            System.exit(-1);
        }
    }
}
