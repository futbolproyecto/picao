package com.example.picao.user.dto;


import com.example.picao.player_profile.dto.PlayerProfileResponseDTO;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserResponseDTO {
    Integer id;
    String name;
    @JsonProperty("second_name")
    String secondName;
    @JsonProperty("last_name")
    String lastName;
    @JsonProperty("second_last_name")
    String secondLastName;
    @JsonProperty("mobile_number")
    String mobileNumber;
    String email;
    String username;
    @JsonProperty("date_of_birth")
    LocalDate dateOfBirth;
    @JsonProperty("nick_name")
    String nickName;
    @JsonProperty("position_player")
    String positionPlayer;
    @JsonProperty("player_profile")
    PlayerProfileResponseDTO playerProfile;


}
