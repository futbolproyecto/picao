package com.example.picao.user.dto;


import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserResponseDTO {
    String name;
    String secondName;
    String lastName;
    String secondLastName;
    String mobileNumber;
    String email;
    LocalDate dateOfBirth;
}
