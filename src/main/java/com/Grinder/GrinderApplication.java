package com.Grinder;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
public class GrinderApplication {

	public static void main(String[] args) {
		SpringApplication.run(GrinderApplication.class, args);
	}

}
