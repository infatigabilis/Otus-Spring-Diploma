package ru.otus.spring.diploma.issuetracker.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Create;
import ru.otus.spring.diploma.issuetracker.utils.ValidationGroups.Edit;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Null;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
@Document
public class Label {

    @Id
    @NotBlank(groups = {Create.class, Edit.class})
    @Null
    private String id;

    @Indexed(unique = true)
    @NotBlank
    private String value;

    @JsonIgnore
    @NotBlank
    private String domain;


    public Label withDomain(String domain) {
        this.setDomain(domain);
        return this;
    }
}
