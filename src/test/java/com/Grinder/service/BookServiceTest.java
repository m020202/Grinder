package com.Grinder.service;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class BookServiceTest {

    @Autowired
    BookService bookService;

    @Test
    public void di() {
        Assertions.assertNotNull(bookService);
        Assertions.assertNotNull(bookService.bookRepository);
    }
}