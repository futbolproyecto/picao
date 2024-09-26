package com.example.picao.authentication.dto;

import com.example.picao.role.entity.Role;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.Set;

@Data
public class AuthResponseDTO {

    Integer id;
    @JsonProperty("mobile_number")
    String mobileNumber;
    String token;
    Set<Role> roles;

}
