package com.example.demo.service;

import com.example.demo.entity.UserEntity;

public interface IUserService {
    UserEntity login(String username, String password);
}
