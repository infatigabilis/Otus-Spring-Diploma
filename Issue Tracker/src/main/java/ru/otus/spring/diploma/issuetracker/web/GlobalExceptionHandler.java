package ru.otus.spring.diploma.issuetracker.web;

import com.netflix.hystrix.exception.HystrixRuntimeException;
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
import ru.otus.spring.diploma.issuetracker.exception.EntityNotFoundException;
import ru.otus.spring.diploma.issuetracker.exception.ExternalServiceUnavailableException;

import javax.validation.ConstraintViolationException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static org.springframework.http.HttpStatus.BAD_REQUEST;
import static org.springframework.http.HttpStatus.INTERNAL_SERVER_ERROR;
import static org.springframework.http.HttpStatus.NOT_FOUND;

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

    @ExceptionHandler(ExternalServiceUnavailableException.class)
    @ResponseStatus(code = INTERNAL_SERVER_ERROR)
    public ExceptionEntity externalServiceUnavailableException(ExternalServiceUnavailableException e) {
        return ExceptionEntity.builder().status(500).exception(e).message("Some external service is unavailable. Please contact our support").build();
    }

    @ExceptionHandler(EntityNotFoundException.class)
    @ResponseStatus(code = NOT_FOUND)
    public ExceptionEntity entityNotFoundException(EntityNotFoundException e) {
        return ExceptionEntity.builder().status(404).exception(e).message("Entity not found").build();
    }

    @ExceptionHandler(HystrixRuntimeException.class)
    public ResponseEntity<ExceptionEntity> hystrixRuntimeException(HystrixRuntimeException e) {
        if (e.getCause() instanceof DuplicateKeyException) {
            return ResponseEntity.status(400).body(commonBadRequestException((DuplicateKeyException) e.getCause()));
        } else if (e.getCause() instanceof EntityNotFoundException) {
            return ResponseEntity.status(404).body(entityNotFoundException((EntityNotFoundException) e.getCause()));
        } else {
            return commonException((Exception) e.getCause());
        }
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
