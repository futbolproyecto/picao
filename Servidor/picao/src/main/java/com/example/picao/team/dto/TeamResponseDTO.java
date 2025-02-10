package com.example.picao.team.dto;

import com.example.picao.city.entity.City;
import com.example.picao.user.dto.UserResponseDTO;
import com.example.picao.zone.entity.Zone;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
public class TeamResponseDTO {
    Integer id;
    String name;
    City city;
    Zone zone;
    @JsonProperty("owner_user")
    UserResponseDTO ownerUser;
    Set<UserResponseDTO> players;
    @JsonProperty("number_of_players")
    Integer numberOfPlayers;
    @JsonProperty("position_player")
    String positionPlayer;

    public TeamResponseDTO(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

}
