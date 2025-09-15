package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserModel, Long> {

    UserModel findByUsername(String username);
    UserModel findByEmail(String email);  // should return UserModel
    boolean existsByEmail(String email);  // optional if you only want boolean check
}

