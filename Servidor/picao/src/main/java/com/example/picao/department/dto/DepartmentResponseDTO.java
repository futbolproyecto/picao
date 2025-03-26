package com.example.picao.department.dto;

import com.example.picao.city.dto.CityResponseDTO;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DepartmentResponseDTO {

    Integer id;

    String name;

    List<CityResponseDTO> cities;

    public DepartmentResponseDTO(Integer id, String name) {
        this.id = id;
        this.name = name;
    }
}
