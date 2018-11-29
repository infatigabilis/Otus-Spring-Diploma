package ru.otus.spring.diploma.issuetracker.db.repository;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import reactor.core.publisher.Flux;
import ru.otus.spring.diploma.issuetracker.domain.Label;

public interface LabelRepository extends ReactiveMongoRepository<Label, String> {
    Flux<Label> findAllByDomain(String domain);
}
