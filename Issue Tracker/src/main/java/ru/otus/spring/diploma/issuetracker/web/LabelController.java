package ru.otus.spring.diploma.issuetracker.web;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;
import ru.otus.spring.diploma.issuetracker.domain.Label;
import ru.otus.spring.diploma.issuetracker.service.LabelService;

import javax.validation.constraints.NotNull;
import java.util.List;

@RestController @RequestMapping("labels")
public class LabelController {
    private final LabelService labelService;

    public LabelController(LabelService labelService) {
        this.labelService = labelService;
    }


    @GetMapping
    public Mono<List<Label>> getAll(@NotNull Authentication auth) {
        return labelService.getAll(auth);
    }
}
