package ru.otus.spring.diploma.issuetracker.db.dpo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.val;
import org.springframework.beans.BeanUtils;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.util.Assert;
import ru.otus.spring.diploma.issuetracker.domain.Issue;
import ru.otus.spring.diploma.issuetracker.domain.IssueStatus;
import ru.otus.spring.diploma.issuetracker.domain.User;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
@Document
public class IssueDpo {
    private @Id String id;
    private @Indexed(unique = true) String visibleId;
    private String title;
    private String description;

    private Integer statusOrdinal;
    private Integer priorityOrdinal;
    private String assigneeId;


    public static IssueDpo fromDomain(Issue domain) {
        val dpo = new IssueDpo();
        BeanUtils.copyProperties(domain, dpo);

        dpo.setAssigneeId(domain.getAssignee() != null ? domain.getAssignee().getId() : null);
        dpo.setStatusOrdinal(domain.getStatus() != null ? domain.getStatus().ordinal() : null);
        dpo.setPriorityOrdinal(domain.getPriority() != null ? domain.getPriority().ordinal() : null);

        return dpo;
    }

    public Issue toDomain(User assignee) {
        val domain = new Issue();
        BeanUtils.copyProperties(this, domain);

        Assert.isTrue(assigneeId.equals(assignee.getId()), "Issue assignee ids not equals: " + assigneeId + ", " + assignee.getId());

        domain.setAssignee(assignee);
        domain.setPriority(Issue.Priority.values()[priorityOrdinal]);
        domain.setStatus(IssueStatus.values()[statusOrdinal]);

        return domain;
    }
}
