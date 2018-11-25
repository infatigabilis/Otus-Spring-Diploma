package ru.otus.spring.diploma.issuetracker.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class User {

    @NotBlank
    private String id;

    @NotBlank
    private String name;

    @NotBlank @Email
    private String email;

    @NotNull
    private String domain;
}
