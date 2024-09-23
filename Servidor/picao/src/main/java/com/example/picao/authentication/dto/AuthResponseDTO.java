package com.example.picao.authentication.dto;

import com.example.picao.role.entity.Role;
import lombok.Data;

import java.util.Set;

@Data
public class AuthResponseDTO {

    Integer id;
    String username;
    String token;
    Set<Role> roles;

}
