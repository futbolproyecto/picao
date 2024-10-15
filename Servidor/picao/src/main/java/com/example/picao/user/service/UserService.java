package com.example.picao.user.service;

import com.example.picao.user.dto.ChangePasswordRequestDTO;
import com.example.picao.user.dto.CreateUserRequestDTO;

public interface UserService {

    int createUser(CreateUserRequestDTO createUserRequestDTO);

    int changePassword(ChangePasswordRequestDTO changePasswordRequestDTO);

}
