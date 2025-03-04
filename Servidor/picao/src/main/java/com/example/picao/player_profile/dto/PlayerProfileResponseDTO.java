package com.example.picao.player_profile.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PlayerProfileResponseDTO {

    String nickname;

    Integer stature;

    Integer weight;

    @JsonProperty("position_player_name")
    String positionPlayerName;

    @JsonProperty("dominant_foot_name")
    String dominantFootName;

    @JsonProperty("zone_name")
    String zoneName;

    @JsonProperty("city_name")
    String cityName;

}
