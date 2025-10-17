package org.example.healthhub.repository.Interfaces;

import org.example.healthhub.entity.User;
import org.example.healthhub.entity.Doctor;
import org.example.healthhub.repository.Enums.Role;

import java.util.List;


public interface UserRepository {
     User login(User user);

     User register(User user);

     User save(User user) ;

     public User update(User user);

}

