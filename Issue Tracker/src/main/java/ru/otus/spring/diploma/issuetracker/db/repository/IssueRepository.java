package ru.otus.spring.diploma.issuetracker.db.repository;

import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.db.dpo.IssueDpo;

public interface IssueRepository extends ReactiveMongoRepository<IssueDpo, String> {
    Mono<IssueDpo> findByVisibleId(String visibleId);
    Flux<IssueDpo> findByAssigneeId(String assigneeId, Sort sort);
}
