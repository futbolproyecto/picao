package com.example.picao.field.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
public class FieldResponseDTO {

    UUID id;

    String name;

    Integer capacity;

    @JsonProperty("is_available")
    Boolean isAvailable;

    @JsonProperty("is_roofed")
    Boolean isRoofed;

}
