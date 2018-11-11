package ru.otus.spring.diploma.issuetracker.dpo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.val;
import org.springframework.beans.BeanUtils;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import ru.otus.spring.diploma.issuetracker.domain.User;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
@Document
public class UserDpo {
    private @Id String id;
    private String name;
    private String email;


    public static UserDpo fromDomain(User domain) {
        val dpo = new UserDpo();
        BeanUtils.copyProperties(domain, dpo);

        return dpo;
    }

    public User toDomain() {
        val domain = new User();
        BeanUtils.copyProperties(this, domain);

        return domain;
    }
}
