package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;


@SpringBootApplication
//@PropertySource({"classpath:application.properties"})
@EnableTransactionManagement
@EnableJpaRepositories(basePackages = "com.example")
@ComponentScan(basePackages = "com.example")
@EntityScan("com.example")
public class Demo4Application extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(Demo4Application.class, args);
    }

}
