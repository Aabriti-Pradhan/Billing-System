package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.UserModel;
import com.SimpleProject.SpringCrud.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;
    public UserModel findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public UserModel findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public UserModel registerUser(UserModel user) {

        return userRepository.save(user);
    }
}