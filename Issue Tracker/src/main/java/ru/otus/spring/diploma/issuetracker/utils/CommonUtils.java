package ru.otus.spring.diploma.issuetracker.utils;

import com.netflix.hystrix.exception.HystrixBadRequestException;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.slf4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

@Component
@Validated
public class CommonUtils {
    private final BeanUtilsBean beanUtilsBean = new BeanUtilsBean() {
        @Override
        public void copyProperty(Object dest, String name, Object value) throws IllegalAccessException, InvocationTargetException {
            if(value != null) {
                super.copyProperty(dest, name, value);
            }
        }
    };

    public <T> void mergeObjects(T origin, T diff, Class<T> classForTypeCheck) {
        try {
            beanUtilsBean.copyProperties(origin, diff);

        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    public <T> void validate(@Valid T bean) {

    }

    public void logFallback(Logger logger, String methodName, List<Object> params, Throwable cause) {
        logger.error("Fallback invocation for {}({})", methodName, params.stream().reduce((p1, p2) -> p1 + ", " + p2).orElse(""), cause);
    }

    public void ignoreFallbackException(Throwable cause, Class<? extends Exception>... classes) {
        for (Class<? extends Exception> clazz : classes) {
            if (cause.getClass().equals(clazz)) {
                throw new HystrixBadRequestException("Ignored exception", cause);
            }
        }
    }

    public String extractDomain(Authentication auth) {
        return auth.getAuthorities().iterator().next().getAuthority();
    }
}
