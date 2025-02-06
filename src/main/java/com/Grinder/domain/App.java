package com.Grinder.domain;

import java.lang.annotation.Annotation;
import java.lang.reflect.Modifier;
import java.util.Arrays;

public class App {
    public static void main(String[] args) {
        Class<?> bookClass = Book.class;
        Arrays.stream(bookClass.getDeclaredFields()).forEach(
                f -> {
                    Arrays.stream(f.getAnnotations()).forEach(a -> {
                        if (a instanceof MyAnnotation) {
                            MyAnnotation myAnnotation = (MyAnnotation) a;
                            System.out.println(myAnnotation.name());
                            System.out.println(myAnnotation.number());
                        }
                    });
                }
        );
    }
}
