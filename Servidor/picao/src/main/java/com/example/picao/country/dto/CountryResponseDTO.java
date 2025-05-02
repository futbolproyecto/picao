package com.example.picao.country.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CountryResponseDTO {

    Integer id;

    String name;

    @JsonProperty("cell_prefix")
    String cellPrefix;
}
