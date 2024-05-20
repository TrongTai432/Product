package com.example.demo.entity;

import javax.persistence.*;

@Entity
@Table(name = "user")
public class UserEntity {

    @Id
    @Column(name = "USERNAME",nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String username;

    @Column(name = "PASSWORD",nullable = true)
    private String password;

    @Column(name = "ROLE" , nullable = true)
    private String role;

    public UserEntity() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
