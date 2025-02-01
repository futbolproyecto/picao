package com.example.picao.user.dto;


import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserResponseDTO {
    Integer id;
    String name;
    String secondName;
    String lastName;
    String secondLastName;
    String mobileNumber;
    String email;
    String username;
    LocalDate dateOfBirth;
    String nickName;
}
