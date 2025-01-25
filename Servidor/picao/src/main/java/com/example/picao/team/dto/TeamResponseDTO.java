package com.example.picao.team.dto;

import com.example.picao.city.entity.City;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.zone.entity.Zone;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TeamResponseDTO {
    Integer id;
    String name;
    City city;
    Zone zone;
    @JsonProperty("owner_user")
    UserEntity ownerUser;
    Set<UserEntity> players;

    public TeamResponseDTO(Integer id, String name) {
        this.id = id;
        this.name = name;
    }


}
