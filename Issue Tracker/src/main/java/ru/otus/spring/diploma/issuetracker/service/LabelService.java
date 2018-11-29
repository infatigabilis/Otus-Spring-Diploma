package ru.otus.spring.diploma.issuetracker.service;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.db.repository.LabelRepository;
import ru.otus.spring.diploma.issuetracker.domain.Label;
import ru.otus.spring.diploma.issuetracker.utils.CommonUtils;

import java.util.List;

@Service
public class LabelService {
    private final CommonUtils commonUtils;
    private final LabelRepository labelRepository;

    public LabelService(CommonUtils commonUtils, LabelRepository labelRepository) {
        this.commonUtils = commonUtils;
        this.labelRepository = labelRepository;
    }


    public Mono<List<Label>> getAll(Authentication auth) {
        return labelRepository.findAllByDomain(commonUtils.extractDomain(auth)).collectList();
    }

    public Mono<Void> add(Label label, Authentication auth) {
        return labelRepository.save(label.withDomain(commonUtils.extractDomain(auth))).then();
    }
}
