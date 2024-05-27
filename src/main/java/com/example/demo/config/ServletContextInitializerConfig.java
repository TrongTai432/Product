package com.example.demo.config;

import com.example.demo.constant.CommonUtil;
import com.example.demo.constant.Constants;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;

@Configuration
@ComponentScan(basePackages = "com.example")
public class ServletContextInitializerConfig implements ServletContextInitializer {

    public void onStartup(ServletContext servletContext) throws ServletException {
        System.setProperty(Constants.PROP_KEY_ROOT_FOLDER, CommonUtil.readProperties(Constants.PROP_KEY_ROOT_FOLDER, "application.properties"));

    }

}
