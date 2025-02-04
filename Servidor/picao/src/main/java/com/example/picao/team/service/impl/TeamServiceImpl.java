package com.example.picao.team.service.impl;


import com.example.picao.city.repository.CityRepository;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.dto.TeamResponseDTO;
import com.example.picao.team.dto.UserTeamAddDTO;
import com.example.picao.team.entity.Team;
import com.example.picao.team.mapper.TeamMapper;
import com.example.picao.team.repository.TeamRepository;
import com.example.picao.team.service.TeamService;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.zone.repository.ZoneRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@RequiredArgsConstructor()
@Service
public class TeamServiceImpl implements TeamService {

    private static final TeamMapper MAPPER = Mappers.getMapper(TeamMapper.class);

    private final UserRepository userRepository;
    private final ZoneRepository zoneRepository;
    private final CityRepository cityRepository;
    private final TeamRepository teamRepository;


    @Override
    public Team createTeam(CreateTeamRequestDTO requestDTO) {

        try {

            teamRepository.findByName(requestDTO.name()).ifPresent(
                    team -> {
                        throw new AppException(ErrorMessages.DUPLICATE_TEAM_NAME, HttpStatus.BAD_REQUEST);
                    });

            cityRepository.findById(requestDTO.cityId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            zoneRepository.findById(requestDTO.zoneId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            userRepository.findById(requestDTO.userId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            return teamRepository.save(MAPPER.toTeam(requestDTO));

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }

    }

    @Override
    public List<TeamResponseDTO> getByUserId(int userId) {
        try {

            return teamRepository.findByOwnerUserId(userId)
                    .orElseThrow(() -> new AppException(ErrorMessages.USER_NOT_EXIST, HttpStatus.NOT_FOUND));


        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());

        }
    }

    @Override
    public TeamResponseDTO addUserToTeam(UserTeamAddDTO userTeamAddDTO) {
        try {

            Team team = teamRepository.findById(userTeamAddDTO.teamId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            UserEntity user = userRepository.findById(userTeamAddDTO.userId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            Set<UserEntity> players = new HashSet<>(team.getPlayers());
            players.add(user);
            team.setPlayers(players);

            return MAPPER.toTeamResponseDTO(teamRepository.save(teamRepository.save(team)));

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());

        }
    }
}



