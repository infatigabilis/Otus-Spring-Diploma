package ru.otus.spring.diploma.issuetracker.domain;

import lombok.Getter;
import ru.otus.spring.diploma.issuetracker.exception.BusinessRuleViolationException;

import java.util.List;

public enum IssueStatus {
    NEW, ANALYSIS, DEVELOPMENT, REVIEW, DEPLOYMENT, TESTING, FEEDBACK, VERIFIED, DONE, CLOSED;

    static {
        NEW.back = List.of(CLOSED);
        NEW.next = List.of(IssueStatus.ANALYSIS, IssueStatus.DEVELOPMENT);

        ANALYSIS.back = List.of(IssueStatus.CLOSED);
        ANALYSIS.next = List.of(IssueStatus.DEVELOPMENT);

        DEVELOPMENT.back = List.of(IssueStatus.ANALYSIS);
        DEVELOPMENT.next = List.of(IssueStatus.REVIEW);

        REVIEW.back = List.of(IssueStatus.DEPLOYMENT);
        REVIEW.next = List.of(IssueStatus.DEPLOYMENT);

        DEPLOYMENT.back = List.of(IssueStatus.REVIEW);
        DEPLOYMENT.next = List.of(IssueStatus.TESTING);

        TESTING.back = List.of(IssueStatus.FEEDBACK, IssueStatus.DEVELOPMENT);
        TESTING.next = List.of(IssueStatus.VERIFIED);

        FEEDBACK.back = List.of(IssueStatus.DEVELOPMENT);
        FEEDBACK.next = List.of(IssueStatus.TESTING);

        VERIFIED.back = List.of(IssueStatus.TESTING);
        VERIFIED.next = List.of(IssueStatus.DONE);

        DONE.back = List.of(IssueStatus.ANALYSIS, IssueStatus.TESTING);
        DONE.next = List.of();

        CLOSED.back = List.of();
        CLOSED.next = List.of(IssueStatus.NEW);
    }

    @Getter
    private List<IssueStatus> back;

    @Getter
    private List<IssueStatus> next;


    public static void checkOnPossibilityOfChanging(IssueStatus from, IssueStatus to) {
        if (from == null) {
            return;
        }

        if (to == null) {
            throw new BusinessRuleViolationException("Status flow violation: Status to change cannot be null");
        }

        if (!from.getBack().contains(to) && !from.getNext().contains(to)) {
            throw new BusinessRuleViolationException("Status flow violation: Status " + from + " cannot be changed to " + to);
        }
    }
}
