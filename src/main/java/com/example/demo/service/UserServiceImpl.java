package com.example.demo.service;

import com.example.demo.dao.UserDAO;
import com.example.demo.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements IUserService{

    @Autowired
    UserDAO userDao;
    @Override
    public UserEntity login(String username, String password) {
        UserEntity userEntity = userDao.getUserByUserName(username);
        if(userEntity == null) {
            throw new UsernameNotFoundException("error");
        }
        return userEntity;
    }

}
