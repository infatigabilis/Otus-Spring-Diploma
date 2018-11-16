package ru.otus.spring.diploma.issuetracker.domain;

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

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class Issue {

//    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    @NotBlank(groups = Default.class)
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

    @NotNull(groups = {Default.class, Create.class})
    private User assignee;


    @AllArgsConstructor
    public enum Priority {
        VERY_LOW, LOW, MEDIUM, HIGH, VERY_HIGH;
    }
}
