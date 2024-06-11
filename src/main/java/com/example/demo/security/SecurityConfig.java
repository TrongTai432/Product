package com.example.demo.security;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
@Configuration
@Order(value = 99)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // User Permission
        http.authorizeRequests()
                .antMatchers("/css/**", "/js/**", "/images/**","/plugins/**", "/*", "/**/*", "/**/**/*").permitAll()
                .and()
                .csrf().disable();
    }
}
