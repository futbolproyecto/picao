package com.example.picao.department.dto;

import com.example.picao.city.entity.City;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
@RequiredArgsConstructor
public class DepartmentResponseDTO {

    final Integer id;

    final String name;
    @JsonIgnore
    List<City> cities;
}
