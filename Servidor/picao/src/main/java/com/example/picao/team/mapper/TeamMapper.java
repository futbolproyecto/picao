package com.example.picao.team.mapper;

import com.example.picao.city.entity.City;
import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.entity.Team;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.zone.entity.Zone;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

@Mapper
public interface TeamMapper {

    @Mapping(source = "zoneId", target = "zone", qualifiedByName = "mapZone")
    @Mapping(source = "cityId", target = "city", qualifiedByName = "mapCity")
    @Mapping(source = "userId", target = "ownerUser", qualifiedByName = "mapUser")
    Team toTeam(CreateTeamRequestDTO requestDTO);

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
