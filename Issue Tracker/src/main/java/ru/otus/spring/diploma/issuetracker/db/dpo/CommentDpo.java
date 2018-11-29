package ru.otus.spring.diploma.issuetracker.db.dpo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.val;
import org.springframework.beans.BeanUtils;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.util.Assert;
import ru.otus.spring.diploma.issuetracker.domain.Comment;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.domain.User;

import java.util.Date;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
@Document
public class CommentDpo {
    private @Id String id;
    private String text;
    private String userId;
    private Date date;
    private String issueId;

    public static CommentDpo fromDomain(Comment domain) {
        val dpo = new CommentDpo();

        BeanUtils.copyProperties(domain, dpo);

        dpo.setIssueId(domain.getIssue() != null ? domain.getIssue().getId() : null);
        dpo.setUserId(domain.getUser() != null ? domain.getUser().getId() : null);

        return dpo;
    }

    public Comment toDomain(User user, Issue issue) {
        val domain = new Comment();
        BeanUtils.copyProperties(this, domain);

        Assert.isTrue(userId.equals(user.getId()), "Comment user ids not equals: " + userId + ", " + user.getId());
        Assert.isTrue(issueId.equals(issue.getId()), "Comment issue ids not equals: " + issueId + ", " + issue.getId());

        domain.setUser(user);
        domain.setIssue(issue);

        return domain;
    }
}
