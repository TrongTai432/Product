package com.example.demo.model;

import org.springframework.http.HttpStatus;

public class ResponseDataModel {
    private HttpStatus status;
    private String message;
    private Object data;

    public ResponseDataModel() {}

    public ResponseDataModel(HttpStatus status, String message) {
        this.status = status;
        this.message = message;
    }

    public ResponseDataModel(HttpStatus status, String message, Object data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    // Getters and Setters
    public HttpStatus getStatus() {
        return status;
    }

    public void setStatus(HttpStatus status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
