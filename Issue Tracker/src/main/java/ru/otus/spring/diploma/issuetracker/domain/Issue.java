package ru.otus.spring.diploma.issuetracker.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Create;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Edit;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import javax.validation.groups.Default;
import java.util.List;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class Issue {

    @NotBlank
    @Null(groups = {Create.class, Edit.class})
    private String id;

    @NotBlank(groups = {Default.class, Create.class})
    private String visibleId;

    @NotBlank(groups = {Default.class, Create.class})
    private String title;

    @NotBlank(groups = {Default.class, Create.class})
    private String description;


    @NotNull(groups = {Default.class, Create.class})
    private IssueStatus status;

    @NotNull(groups = {Default.class, Create.class})
    private Priority priority;

    @NotNull
    private List<Label> labels;


    @NotNull(groups = {Default.class, Create.class})
    private User assignee;


    @JsonIgnore
    @NotBlank
    private String domain;


    public Issue withDomain(String domain) {
        this.domain = domain;
        return this;
    }


    @AllArgsConstructor
    public enum Priority {
        VERY_LOW, LOW, MEDIUM, HIGH, VERY_HIGH;
    }
}
