package ru.otus.spring.diploma.issuetracker.web;

import lombok.Builder;
import lombok.Data;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.server.ServerWebInputException;
import ru.otus.spring.diploma.issuetracker.exception.BusinessRuleViolationException;

import javax.validation.ConstraintViolationException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static org.springframework.http.HttpStatus.BAD_REQUEST;

@RestControllerAdvice
public class GlobalExceptionHandler {
    private final static Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(ConstraintViolationException.class)
    @ResponseStatus(code = BAD_REQUEST)
    public ExceptionEntity validationException(ConstraintViolationException e) {
        logger.warn("Validation exception: {}", e.getMessage());
        return ExceptionEntity.builder().status(400).exception(e).message(e.getMessage()).build();
    }

    @ExceptionHandler(BusinessRuleViolationException.class)
    @ResponseStatus(code = BAD_REQUEST)
    public ExceptionEntity businessRuleViolationException(BusinessRuleViolationException e) {
        logger.warn("Business rule violation exception: {}", e.getMessage());
        return ExceptionEntity.builder().status(400).exception(e).message(e.getMessage()).build();
    }

    @ExceptionHandler({DuplicateKeyException.class, ServerWebInputException.class})
    @ResponseStatus(code = BAD_REQUEST)
    public ExceptionEntity commonBadRequestException(Exception e) {
        logger.warn("Common bad request exception: {}", e.getMessage());
        return ExceptionEntity.builder().status(400).exception(e).message(e.getMessage()).build();
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ExceptionEntity> commonException(Exception e) {
        if (ExceptionUtils.getRootCause(e) instanceof BusinessRuleViolationException) {
            return ResponseEntity.status(400).body(businessRuleViolationException((BusinessRuleViolationException) ExceptionUtils.getRootCause(e)));
        }

        logger.error("Unexpected exception", e);
        return ResponseEntity.status(500).body(ExceptionEntity.builder().status(500).exception(e).build());
    }


    @Data @Builder
    public static class ExceptionEntity {
        private final int status;
        private final Exception exception;
        private final String message;


        public String getException() {
            return this.exception.getClass().getName();
        }

        public String getTimestamp() {
            return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        }
    }
}
