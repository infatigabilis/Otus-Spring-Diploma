package ru.otus.spring.diploma.issuetracker.web;

import com.mongodb.DuplicateKeyException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import ru.otus.spring.diploma.issuetracker.exception.BusinessRuleViolationException;

import javax.validation.ConstraintViolationException;

@RestControllerAdvice
public class GlobalExceptionHandler {
    private final static Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(ConstraintViolationException.class)
    @ResponseStatus(code = HttpStatus.BAD_REQUEST)
    public String validationException(ConstraintViolationException e) {
        logger.warn("Validation exception: {}", e.getMessage());
        return e.getMessage();
    }

//    FIXME: not callable
    @ExceptionHandler(BusinessRuleViolationException.class)
    @ResponseStatus(code = HttpStatus.BAD_REQUEST)
    public String businessRuleViolationException(BusinessRuleViolationException e) {
        logger.warn("Business rule violation exception: {}", e.getMessage());
        return e.getMessage();
    }

//    FIXME: not callable
    @ExceptionHandler(DuplicateKeyException.class)
    @ResponseStatus(code = HttpStatus.BAD_REQUEST)
    public String commonBadRequestException(DuplicateKeyException e) {
        logger.warn("Common bad request exception: {}", e.getMessage());
        return e.getMessage();
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
    public void commonException(Exception e) {
        logger.error("Unexpected exception", e);
    }
}
