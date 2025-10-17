package org.example.healthhub.service;

import org.example.healthhub.dto.UserRegisterRequestDTO;
import org.example.healthhub.dto.UserRequestDTO;
import org.example.healthhub.dto.UserResponseDTO;
import org.example.healthhub.entity.User;
import org.example.healthhub.repository.implement.UserDAO;
import org.modelmapper.ModelMapper;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    public UserResponseDTO login(UserRequestDTO userRequestDTO){
        ModelMapper modelMapper = new ModelMapper();
        User user = modelMapper.map(userRequestDTO, User.class);
        User userResponse = userDAO.login(user);
        if(userResponse == null){
            throw new IllegalArgumentException("Email or Password  not found!");
        }
        UserResponseDTO userResponseDTO = modelMapper.map(userResponse,UserResponseDTO.class);
         return userResponseDTO;
    }
    public UserRegisterRequestDTO register(UserRegisterRequestDTO userRegisterRequestDTO){
        ModelMapper modelMapper = new ModelMapper();
        User user = modelMapper.map(userRegisterRequestDTO, User.class);
        User userResponse = userDAO.register(user);
         userRegisterRequestDTO = modelMapper.map(userResponse,UserRegisterRequestDTO.class);
        return userRegisterRequestDTO;
    }

}
