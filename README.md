# Otus Spring Diploma

![Example 1](doc/example1.gif?raw=true)

![Example 2](doc/example2.gif?raw=true)

В проекте реализуется **Тикет-трекер** - облачный сервис в котором несколько компаний работают в разных пространствах. 
Функционал по типу Jira. Реализован и фронтенд, и бекенд. 
 
#### Функционал:
 - создания, редактирование, просмотр таски(поля: ид, название, описание, статус, приоритет, исполнитель, метки).
 - изменение статуса тикета (по единому флоу).
 - назначение исполнителя.
 - оставление комментариев.
 - дашборд тикетов исполнителя с сортировкой по приоритетам и статусам.
 - обзор всех тикетов с сортировкой и поиском по меткам и исполнителям.
 
#### Особенности:
 - бекенд построен на реактивно архитектуре (Project Reactor).
 - основное приложение(Issue Tracker) балансится на несколько нод (Zuul).
 - деплой в docker-compose одной командой.
 - Signle Sing-On (Keycloak).
 - бекенд - Json REST API, фронтенд - SPA.
 - поддержка роутинга в SPA, в частности открытие страницы тикета по ссылке.
 
#### Стек:
 - бекенд: Spring WebFlux, Spring Data Reactive MongoDB, Spring Reactive Security, Spring Cache, Hystrix, Keycloak, Zuul,
  Eureka, Mongobee, Swagger.
 - фронтенд: ReactJS, React Router, Material UI.
 - ops: Docker, Docker Compose, Nginx(для фронтенда), Reactive MongoDB(основная бд), PosrgreSQL(бд Keycloak'a).
 
### Deploy
```
docker-compose build
docker-compose up -d
```

> Credential'ы пользователей для теста:
> * `user1:user1` - Scott Matthews, пространство: _programming_
> * `user2:user2` - Tilly Frank, пространство: _programming_
> * `user3:user3` - Arnold Timms, пространство: _programming_
> * `user4:user4` - Aiden Mansell, пространство: _business_
> * `user5:user5` - Wiktoria Orozco, пространство: _business_
