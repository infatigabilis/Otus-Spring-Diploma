package ru.otus.spring.diploma.issuetracker.utils;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.lang.reflect.InvocationTargetException;

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
}
