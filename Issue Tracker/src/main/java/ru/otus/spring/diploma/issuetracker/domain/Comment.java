package ru.otus.spring.diploma.issuetracker.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Create;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Edit;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Null;
import javax.validation.groups.Default;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class Comment {

    @NotBlank(groups = {Default.class, Edit.class})
    @Null(groups = Create.class)
    private String id;

    @NotBlank
    private String text;

    @Null
    private User user;

    @JsonIgnore
    private Issue issue;
}
