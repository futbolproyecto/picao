package com.example.picao.establishment.dto;

import com.example.picao.city.dto.CityResponseDTO;
import com.example.picao.department.dto.DepartmentResponseDTO;
import com.example.picao.user.dto.UserResponseDTO;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Set;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EstablishmentResponseDTO {

    UUID id;
    String name;
    String address;
    String mobileNumber;
    DepartmentResponseDTO department;
    CityResponseDTO city;
    Set<UserResponseDTO> users;

    public EstablishmentResponseDTO(UUID id, String name, String address, String mobileNumber) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.mobileNumber = mobileNumber;
    }
}
