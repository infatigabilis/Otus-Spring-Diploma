package ru.otus.spring.diploma.issuetracker.repository;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import ru.otus.spring.diploma.issuetracker.dpo.UserDpo;

public interface UserRepository extends ReactiveMongoRepository<UserDpo, String> {
}
