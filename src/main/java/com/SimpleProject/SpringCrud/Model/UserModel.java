package com.SimpleProject.SpringCrud.Model;

import jakarta.persistence.*;
import lombok.Data;
@Entity
@Data
public class UserModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password; // store hashed password in real apps

    private String role = "USER"; // default role
}