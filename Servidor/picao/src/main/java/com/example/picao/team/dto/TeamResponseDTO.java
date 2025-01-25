package com.example.picao.team.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TeamResponseDTO {
    Integer id;
    String name;

    public TeamResponseDTO(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

    @JsonProperty("user_id")
    Integer userId;
}
