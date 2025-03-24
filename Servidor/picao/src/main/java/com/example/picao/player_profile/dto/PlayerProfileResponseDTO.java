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

    @JsonProperty("position_player_id")
    Integer positionPlayerId;

    @JsonProperty("dominant_foot_id")
    Integer dominantFootId;

    @JsonProperty("zone_id")
    Integer zoneId;

    @JsonProperty("city_id")
    Integer cityId;

}
