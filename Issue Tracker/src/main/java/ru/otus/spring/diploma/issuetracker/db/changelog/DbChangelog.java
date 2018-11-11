package ru.otus.spring.diploma.issuetracker.db.changelog;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.mongobee.changeset.ChangeLog;
import com.github.mongobee.changeset.ChangeSet;
import lombok.val;
import org.jongo.Jongo;
import ru.otus.spring.diploma.issuetracker.db.dpo.IssueDpo;

import java.util.Map;

import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.HIGH;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.LOW;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.MEDIUM;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.ANALYSIS;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.CLOSED;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.DEVELOPMENT;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.DONE;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.FEEDBACK;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.NEW;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.TESTING;
import static ru.otus.spring.diploma.issuetracker.domain.IssueStatus.VERIFIED;

@ChangeLog
public class DbChangelog {
    private final ObjectMapper jacksonMapper = new ObjectMapper();


    @ChangeSet(order = "001", id = "001", author = "dev")
    public void _001(Jongo jongo) {
        val collection = jongo.getCollection("issueDpo");

        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-1", "AOP, Spring AOP", DESC1, FEEDBACK.ordinal(), MEDIUM.ordinal(), "1")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-2", "DAO на Spring JDBC", DESC2, DEVELOPMENT.ordinal(), HIGH.ordinal(), "1")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-3", "JPQL, Spring ORM, DAO на основе Spring ORM + JPA", DESC3, DEVELOPMENT.ordinal(), MEDIUM.ordinal(), "1")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-4", "Транзакции, Spring Tx", DESC4, TESTING.ordinal(), MEDIUM.ordinal(), "2")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-5", "SQL и NoSQL базы данных", DESC5, NEW.ordinal(), LOW.ordinal(), "3")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-6", "Reactive Stack", DESC6, NEW.ordinal(), MEDIUM.ordinal(), "1")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-7", "Spring WebFlux", DESC7, ANALYSIS.ordinal(), MEDIUM.ordinal(), "3")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-8", "Spring Integration: Монолиты vs. Microservices Round 1, Messaging, Enterprise Integration Patterns (EIP)", DESC8, DONE.ordinal(), HIGH.ordinal(), "3")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-9", "Spring Integration: Endpoints и Flow Components", DESC9, DONE.ordinal(), MEDIUM.ordinal(), "3")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-10", "Docker, оркестрация, облака, облачные хостинги", DESC10, CLOSED.ordinal(), LOW.ordinal(), "3")
        ));
        collection.insert(toSpringDocument(
                new IssueDpo(null, "OTUS-11", "Spring Cloud Data Flow, Hystrix Circuit Breaker", DESC11, VERIFIED.ordinal(), HIGH.ordinal(), "2")
        ));
    }


    private Map<String, Object> toSpringDocument(Object dpo) {
        final Map<String, Object> map = jacksonMapper.convertValue(dpo, new TypeReference<Map<String, Object>>() {});
        map.put("_class", dpo.getClass());

        return map;
    }



    private static final String DESC1 = "Слушатели смогут познакомиться с аспектно-ориентированным программирование для создания crosscutting функциональностей в приложении с помощью Spring AOP. И, конечно, слушатели разберутся на чём базируются остальные фреймворки Spring.";
    private static final String DESC2 = "Слушатели смогут ориентироваться в архитекрутных паттернах, свзяанных с работой с БД.\nСлушатели смогут эффективно использовать Spring JDBC для разработки DAO в приложении.";
    private static final String DESC3 = "По окончанию данного модуля слушатели смогут разрабатывать ORM DAO в Spring-приложении с помощью Spring ORM + JPA + Hibernate (в качестве провайдера JPA).\n\nТакже слушатели узнаю про JPQL (аналог HQL).";
    private static final String DESC4 = "Слушатели погрузятся в теорию транзакций и поймут все особенности транзакций.\nТакже слушатели смогут использовать декларативное и императивное управление транзакциями в Spring-приложениях с помощью Spring Tx.";
    private static final String DESC5 = "По окончанию данного семинара слушатели начнут разбираться в особенностях реляционных и различных нереляционных (NoSQL) баз данных.\n\nТакже слушатели научатся правильно выбирать NoSQL БД для решения соответствующих задач.";
    private static final String DESC6 = "В данном модуле слушатели узнают, что такое Reactive программирование и познакомятся со Spring Reactive Stack для разработки веб-приложений.";
    private static final String DESC7 = "После данного занятия слушатели смогу создавать современные Reactive Web-приложения с помощью Spring WebFlux.";
    private static final String DESC8 = "По окончании данного модуля слушатели узнают два похода к разработке Enterprise-приложений - монолиты и микросервисы.\nУзнают, какие проблемы возникают при создании монолитов, что такое Messaging и Enterprise Integration Patterns (EIP) и где здесь Spring Integration.";
    private static final String DESC9 = "Слушатели также узнают про другие Endpoints и Flow Components и смогут разрабатывать сложные Enterprise-приложения c почти любой интеграцией.";
    private static final String DESC10 = "По окончании данного занятия слушатели смогут разбираться в вышеперечисленных словах, а также разбираться в современных принципах построения облачных систем.";
    private static final String DESC11 = "Слушатели смогут узнать как строятся огромные системы на Spring с использованием Spring Cloud Data Flow.\n\nТакже будет рассмотрен популярный фреймворк для использования внешних систем и ресурсов - Hystrix (+Hystrix Javanica) и его интеграция со Spring.";
}
