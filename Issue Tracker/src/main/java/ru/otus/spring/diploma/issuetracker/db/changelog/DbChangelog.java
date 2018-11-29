package ru.otus.spring.diploma.issuetracker.db.changelog;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.mongobee.changeset.ChangeLog;
import com.github.mongobee.changeset.ChangeSet;
import lombok.val;
import org.jongo.Jongo;
import org.jongo.MongoCollection;
import ru.otus.spring.diploma.issuetracker.db.dpo.CommentDpo;
import ru.otus.spring.diploma.issuetracker.db.dpo.IssueDpo;
import ru.otus.spring.diploma.issuetracker.domain.Label;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.HIGH;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.LOW;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.MEDIUM;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.VERY_HIGH;
import static ru.otus.spring.diploma.issuetracker.domain.Issue.Priority.VERY_LOW;
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
    private final ObjectMapper jacksonMapper = new ObjectMapper().configure(MapperFeature.USE_ANNOTATIONS, false);

    private MongoCollection issueCollection;
    private MongoCollection labelCollection;
    private MongoCollection commentCollection;

    private void initCollections(Jongo jongo) {
        issueCollection = jongo.getCollection("issueDpo");
        labelCollection = jongo.getCollection("label");
        commentCollection = jongo.getCollection("commentDpo");
    }

    @ChangeSet(order = "001", id = "001", author = "dev")
    public void _001(Jongo jongo) {
        initCollections(jongo);
        
        insertLabels();
        insertIssues();
        insertComments();
    }


    private void insertIssues() {
        val lables = new ArrayList<String>(){{ labelCollection.find().as(Map.class).forEach(v -> add(v.get("_id").toString())); }}.toArray(new String[8]);

        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-1", "AOP, Spring AOP", DESC1, FEEDBACK.ordinal(), MEDIUM.ordinal(), List.of(lables[1], lables[5], lables[7]), "user1", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-2", "DAO на Spring JDBC", DESC2, DEVELOPMENT.ordinal(), HIGH.ordinal(), List.of(lables[1]), "user2", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-3", "JPQL, Spring ORM, DAO на основе Spring ORM + JPA", DESC3, DEVELOPMENT.ordinal(), MEDIUM.ordinal(), List.of(lables[1]), "user2", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-4", "Транзакции, Spring Tx", DESC4, TESTING.ordinal(), VERY_LOW.ordinal(), List.of(lables[1], lables[6]), "user1", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-5", "SQL и NoSQL базы данных", DESC5, NEW.ordinal(), LOW.ordinal(), List.of(lables[1], lables[7]), "user3", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-6", "Reactive Stack", DESC6, NEW.ordinal(), MEDIUM.ordinal(), List.of(lables[2], lables[5], lables[7]), "user1", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-7", "Spring WebFlux", DESC7, ANALYSIS.ordinal(), MEDIUM.ordinal(), List.of(lables[2]), "user2", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-8", "Spring Integration: Монолиты vs. Microservices Round 1", DESC8, DONE.ordinal(), HIGH.ordinal(), List.of(lables[2], lables[6]), "user3", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-9", "Spring Integration: Endpoints и Flow Components", DESC9, DONE.ordinal(), MEDIUM.ordinal(), List.of(lables[2]), "user2", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-10", "Docker, оркестрация, облака, облачные хостинги", DESC10, CLOSED.ordinal(), LOW.ordinal(), List.of(lables[3]), "user1", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "SPRING-11", "Spring Cloud Data Flow, Hystrix Circuit Breaker", DESC11, VERIFIED.ordinal(), HIGH.ordinal(), List.of(lables[3], lables[5]), "user1", "programming")
        ));

        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "JAVASE-1", "Байт код", DESC12, VERIFIED.ordinal(), MEDIUM.ordinal(), List.of(lables[1]), "user1", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "JAVASE-2", "Углубленные основы", DESC13, FEEDBACK.ordinal(), MEDIUM.ordinal(), List.of(lables[1]), "user2", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "JAVASE-3", "Remote debug", DESC14, FEEDBACK.ordinal(), HIGH.ordinal(), List.of(lables[1], lables[7]), "user3", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "JAVASE-4", "Контейнеры и алгоритмы", DESC15, TESTING.ordinal(), VERY_HIGH.ordinal(), List.of(lables[1], lables[5]), "user3", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "JAVASE-5", "Инструменты для преобразования контейнеров", DESC16, TESTING.ordinal(), LOW.ordinal(), List.of(lables[1]), "user2", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "JAVASE-6", "Сборщик мусора", DESC17, NEW.ordinal(), LOW.ordinal(), List.of(lables[2]), "user1", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "JAVASE-7", "QA и тестирование", DESC18, DONE.ordinal(), MEDIUM.ordinal(), List.of(lables[2], lables[6]), "user2", "programming")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "JAVASE-8", "Аннотации", DESC19, DONE.ordinal(), HIGH.ordinal(), List.of(lables[2]), "user1", "programming")
        ));


        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "PM-1", "Роль и цели", DESC20, ANALYSIS.ordinal(), VERY_HIGH.ordinal(), List.of(), "user4", "business")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "PM-2", "Качества и навыки", DESC21, CLOSED.ordinal(), VERY_LOW.ordinal(), List.of(), "user5", "business")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "PM-3", "Культура исполнения: про то как успевать больше", DESC22, CLOSED.ordinal(), MEDIUM.ordinal(), List.of(), "user4", "business")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "PM-4", "Культура выполнения: как не налажать в мелочах", DESC23, VERIFIED.ordinal(), LOW.ordinal(), List.of(), "user4", "business")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "PM-5", "Командообразование", DESC24, NEW.ordinal(), MEDIUM.ordinal(), List.of(), "user5", "business")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "PM-6", "Культура поведения и атмосфера", DESC25, VERIFIED.ordinal(), MEDIUM.ordinal(), List.of(), "user5", "business")
        ));
        issueCollection.insert(toSpringDocument(
                new IssueDpo(null, "PM-7", "Коммуникации", DESC26, DONE.ordinal(), VERY_HIGH.ordinal(), List.of(), "user4", "business")
        ));
    }

    private void insertLabels() {
        labelCollection.insert(toSpringDocument(
                new Label(null, "Month 1", "programming")
        ));
        labelCollection.insert(toSpringDocument(
                new Label(null, "Month 2", "programming")
        ));
        labelCollection.insert(toSpringDocument(
                new Label(null, "Month 3", "programming")
        ));
        labelCollection.insert(toSpringDocument(
                new Label(null, "Month 4", "programming")
        ));
        labelCollection.insert(toSpringDocument(
                new Label(null, "Month 5", "programming")
        ));
        labelCollection.insert(toSpringDocument(
                new Label(null, "Sample label 1", "programming")
        ));
        labelCollection.insert(toSpringDocument(
                new Label(null, "Sample label 2", "programming")
        ));
        labelCollection.insert(toSpringDocument(
                new Label(null, "Sample label 3", "programming")
        ));
    }

    private void insertComments() {
        val issues = new ArrayList<String>(){{ issueCollection.find().as(Map.class).forEach(v -> add(v.get("_id").toString())); }};

        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT1, "user2", issues.get(0))
        ));
        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT2, "user2", issues.get(0))
        ));
        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT3, "user1", issues.get(0))
        ));

        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT4, "user1", issues.get(1))
        ));
        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT5, "user3", issues.get(1))
        ));

        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT6, "user2", issues.get(3))
        ));
        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT7, "user3", issues.get(3))
        ));
        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT8, "user3", issues.get(3))
        ));
        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT9, "user2", issues.get(3))
        ));

        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT9, "user4", issues.get(19))
        ));
        commentCollection.insert(toSpringDocument(
                new CommentDpo(null, TEXT10, "user5", issues.get(19))
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

    private static final String DESC12 = "Байт код. Содержание .class. Декомпиляция. Обфускация. История изменений языка Java от версии к версии. Разбор ДЗ.";
    private static final String DESC13 = "Углубленные основы. Загрузка классов. Виды и задачи class loader-ов. Класс Class&lt;?&gt;. Примитивные типы, строки, массивы. Память, которую занимают объекты.";
    private static final String DESC14 = "Hot swap. Remote debug. Сборщик мусора. Instrumentation. Разбор примеров и ДЗ.";
    private static final String DESC15 = "Generics. Контейнеры и алгоритмы. Обзор устройства и работы контейнеров из java.util. Сравнение контейнеров. Карты на основе хэш функции и на основе дерева. Разбор алгоритмов из java.util.Collections.";
    private static final String DESC16 = "Инструменты для преобразования контейнеров. Apache Commons. Google Guava. Разбор примеров и ДЗ.";
    private static final String DESC17 = "Параметры запуска VM. Сборщик мусора. Виды сборок. Разделение памяти под разные поколения объектов. Виды сборщиков. JMX. Управление приложением из jconsole. OutOfMemory. dump памяти. Исседование thread dump и heap dump.";
    private static final String DESC18 = "QA, тестирование. Виды тестов. \"Заглушки\". Testing frameworks: junit, mockito. Разбор примеров и ДЗ.";
    private static final String DESC19 = "Аннотации. Стандартные аннотации. Применение аннотаций. Типы аннотаций. Синтаксис. Создание своих аннтатаций. Reflection.";

    private static final String DESC20 = "В каких ролях выступает руководитель (их, кстати, немало); какие функции выполняет в каждой из ролей; какие цели стоят перед руководителем; кто ставит эти цели.";
    private static final String DESC21 = "Какими качествами должен обладать руководитель для успешной работы; какие навыки должен в себе развивать.";
    private static final String DESC22 = "Почему так важно выполнять намеченное; что этому мешает; в какую сторону и как \"прокачиваться";
    private static final String DESC23 = "Почему так важно не упускать детали; как этого избегать; как помогать в этом окружающим.";
    private static final String DESC24 = "Что делает команду командой; как организовать коллектив в команду.";
    private static final String DESC25 = "Что представляет из себя культура поведения в команде; как ее формировать и надо ли; от чего зависит атмосфера в команде и какой она должна быть.";
    private static final String DESC26 = "Как отстраивать процессы обмена информацией; за какими коммуникационными потоками надо следить отдельно; чем отличается хорошо налаженное взаимодействие";


    private static final String TEXT1 = "Maecenas laoreet sapien quis hendrerit sodales. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.\nVivamus in ultrices orci. In hac habitasse platea dictumst. Pellentesque fermentum nunc eu mollis sodales. Phasellus pulvinar velit in porttitor dictum.";
    private static final String TEXT2 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit";
    private static final String TEXT3 = "Vivamus sed aliquam magna";
    private static final String TEXT4 = "Proin vitae enim eget neque lobortis rhoncus. Duis placerat dolor elit";
    private static final String TEXT5 = "Suspendisse nulla ante, ultrices ac ligula vel, iaculis auctor arcu. Vestibulum pellentesque est quis dui tincidunt volutpat. Donec ac tincidunt est. Vestibulum sollicitudin laoreet velit ac ullamcorper. Sed molestie tristique elementum. Aliquam rhoncus dolor dolor, sed mollis erat maximus eu.";
    private static final String TEXT6 = "Vestibulum sollicitudin laoreet velit ac ullamcorper. Sed molestie tristique elementum. Aliquam rhoncus dolor dolor, sed mollis erat maximus eu";
    private static final String TEXT7 = "Aliquam sed urna nibh. Nunc tincidunt consequat magna vel tempus. Nam interdum, sapien a consequat vehicula, purus felis blandit ipsum, quis egestas diam diam nec neque";
    private static final String TEXT8 = "Nam interdum, sapien a consequat vehicula, purus felis blandit ipsum, quis egestas diam diam nec neque. Vivamus gravida mauris in risus vulputate dignissim. Phasellus hendrerit laoreet auctor.";
    private static final String TEXT9 = "Morbi varius ante a erat ultrices";
    private static final String TEXT10 = "Sed porttitor luctus libero ac luctus. Nullam quis fringilla ex";
}
