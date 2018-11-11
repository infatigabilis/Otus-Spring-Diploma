package ru.otus.spring.diploma.issuetracker.service;

import lombok.val;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.dpo.IssueDpo;
import ru.otus.spring.diploma.issuetracker.dpo.UserDpo;
import ru.otus.spring.diploma.issuetracker.repository.IssueRepository;
import ru.otus.spring.diploma.issuetracker.repository.UserRepository;
import ru.otus.spring.diploma.issuetracker.utils.CommonUtils;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import java.util.List;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.toList;
import static ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Create;

@Service
@Validated
public class IssueService {
    private final static Logger logger = LoggerFactory.getLogger(IssueService.class);

    private final CommonUtils commonUtils;
    private final IssueRepository issueRepository;
    private final UserRepository userRepository;


    public IssueService(CommonUtils commonUtils, IssueRepository issueRepository, UserRepository userRepository) {
        this.commonUtils = commonUtils;
        this.issueRepository = issueRepository;
        this.userRepository = userRepository;
    }


    public Mono<Issue> getByVisibleId(String issueVisibleId) {
        return issueRepository.findByVisibleId(issueVisibleId).flatMap(this::dpoToDomain);
    }

    public Mono<List<Issue>> getMany(@NotNull Issue example, @NotNull Sort sort) {
        val exampleTerm = Example.of(
                IssueDpo.fromDomain(example),
                ExampleMatcher.matching().withIgnoreNullValues()
        );

//        TODO: refactor this snippet to more pretty and correct...
        return issueRepository
                .findAll(exampleTerm, sort)
                .collectList()
                .zipWith(
                        issueRepository.findAll(exampleTerm, sort).flatMap(this::dpoToDomain).collectList(),
                        (orderedList, listWithResolvedUsers) -> orderedList.stream()
                                    .map(i -> listWithResolvedUsers.stream()
                                            .filter(ii -> ii.getId().equals(i.getId()))
                                            .findAny().orElse(null)
                                    )
                                    .collect(toList())
                        );
    }

    @Validated(Create.class)
    public Mono<Void> createIssue(@Valid Issue issue) {
        return issueRepository.save(IssueDpo.fromDomain(issue)).then();
    }

    public Mono<Void> editIssue(@NotBlank String originalIssueVisibleId, Issue diffIssue) {
        return issueRepository.findByVisibleId(originalIssueVisibleId).flatMap(issue -> {
            commonUtils.mergeObjects(issue, IssueDpo.fromDomain(diffIssue), IssueDpo.class);
            commonUtils.validate(issue);
            return issueRepository.save(issue).then();
        });
    }


    private Mono<Issue> dpoToDomain(IssueDpo dpo) {
        return userRepository.findById(dpo.getAssigneeId())
                .switchIfEmpty(Mono.defer(() -> {
                    logger.error("User not found by id '{}' for issue '{}'", dpo.getAssigneeId(), dpo.getId());
                    return Mono.just(new UserDpo(dpo.getAssigneeId(), "Deleted user", null));
                }))
                .map(user -> dpo.toDomain(user.toDomain()));
    }
}
