package com.example.picao.player_profile.mapper;

import com.example.picao.city.entity.City;
import com.example.picao.dominant_foot.entity.DominantFoot;
import com.example.picao.player_profile.dto.CreateUpdatePlayerProfileRequestDTO;
import com.example.picao.player_profile.dto.PlayerProfileResponseDTO;
import com.example.picao.player_profile.entity.PlayerProfile;
import com.example.picao.position_player.entity.PositionPlayer;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.user.mapper.UserMapper;
import com.example.picao.zone.entity.Zone;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

@Mapper(uses = {UserMapper.class})
public interface PlayerProfileMapper {

    @Mapping(source = "positionPlayerId", target = "positionPlayer", qualifiedByName = "mapPositionPlayer")
    @Mapping(source = "dominantFootId", target = "dominantFoot", qualifiedByName = "mapDominantFoot")
    @Mapping(source = "zoneId", target = "zone", qualifiedByName = "mapZone")
    @Mapping(source = "cityId", target = "city", qualifiedByName = "mapCity")
    @Mapping(source = "userId", target = "user", qualifiedByName = "mapUser")
    PlayerProfile toPlayerProfile(CreateUpdatePlayerProfileRequestDTO requestDTO);

    @Mapping(source = "positionPlayer.id", target = "positionPlayerId")
    @Mapping(source = "dominantFoot.id", target = "dominantFootId")
    @Mapping(source = "zone.id", target = "zoneId")
    @Mapping(source = "city.id", target = "cityId")
    PlayerProfileResponseDTO toPlayerProfileResponseDTO(PlayerProfile playerProfile);

    @Named("mapPositionPlayer")
    default PositionPlayer mapPositionPlayer(Integer id) {
        return new PositionPlayer(id);
    }

    @Named("mapDominantFoot")
    default DominantFoot mapDominantFoot(Integer id) {
        return new DominantFoot(id);
    }

    @Named("mapZone")
    default Zone mapZone(Integer id) {
        return new Zone(id);
    }

    @Named("mapCity")
    default City mapCity(Integer id) {
        return new City(id);
    }

    @Named("mapUser")
    default UserEntity mapUser(Integer id) {
        return new UserEntity(id);
    }
}
