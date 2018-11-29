package ru.otus.spring.diploma.issuetracker.db.repository;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Flux;
import ru.otus.spring.diploma.issuetracker.db.dpo.CommentDpo;

public interface CommentRepository extends ReactiveMongoRepository<CommentDpo, String> {
    Flux<CommentDpo> findAllByIssueId(String issueId);
}
