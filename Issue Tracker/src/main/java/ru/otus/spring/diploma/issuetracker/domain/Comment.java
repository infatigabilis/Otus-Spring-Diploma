package ru.otus.spring.diploma.issuetracker.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Create;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Edit;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Null;
import javax.validation.groups.Default;
import java.util.Date;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class Comment {

    @NotBlank(groups = {Default.class, Edit.class})
    @Null(groups = Create.class)
    private String id;

    @NotBlank
    private String text;

    @Null
    @JsonFormat(shape = JsonFormat.Shape.NUMBER)
    private Date date;

    @Null
    private User user;

    @JsonIgnore
    private Issue issue;
}
