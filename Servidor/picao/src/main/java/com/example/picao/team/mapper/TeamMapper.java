package com.example.picao.team.mapper;

import com.example.picao.city.entity.City;
import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.dto.TeamResponseDTO;
import com.example.picao.team.entity.Team;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.user.mapper.UserMapper;
import com.example.picao.zone.entity.Zone;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

@Mapper(uses = {UserMapper.class})
public interface TeamMapper {

    @Mapping(source = "zoneId", target = "zone", qualifiedByName = "mapZone")
    @Mapping(source = "cityId", target = "city", qualifiedByName = "mapCity")
    @Mapping(source = "userId", target = "ownerUser", qualifiedByName = "mapUser")
    Team toTeam(CreateTeamRequestDTO requestDTO);

    @Mapping(target = "id", source = "team.id")
    @Mapping(target = "name", source = "team.name")
    @Mapping(target = "city", source = "team.city")
    @Mapping(target = "zone", source = "team.zone")
    TeamResponseDTO toTeamResponseDTO(Team team);

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
