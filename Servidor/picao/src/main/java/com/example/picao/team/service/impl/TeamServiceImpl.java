package com.example.picao.team.service.impl;


import com.example.picao.city.repository.CityRepository;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.dto.TeamResponseDTO;
import com.example.picao.team.dto.UserTeamAddRequestDTO;
import com.example.picao.team.entity.Team;
import com.example.picao.team.mapper.TeamMapper;
import com.example.picao.team.repository.TeamRepository;
import com.example.picao.team.service.TeamService;
import com.example.picao.user.dto.UserResponseDTO;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.zone.repository.ZoneRepository;
import jakarta.persistence.Tuple;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.LinkedHashSet;

@RequiredArgsConstructor()
@Service
public class TeamServiceImpl implements TeamService {

    private static final TeamMapper MAPPER = Mappers.getMapper(TeamMapper.class);

    private final UserRepository userRepository;
    private final ZoneRepository zoneRepository;
    private final CityRepository cityRepository;
    private final TeamRepository teamRepository;

    @Transactional()
    @Override
    public TeamResponseDTO createTeam(CreateTeamRequestDTO requestDTO) {

        try {

            teamRepository.findByName(requestDTO.name()).ifPresent(
                    team -> {
                        throw new AppException(ErrorMessages.DUPLICATE_TEAM_NAME, HttpStatus.BAD_REQUEST);
                    });

            cityRepository.findById(requestDTO.cityId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Ciudad"));

            zoneRepository.findById(requestDTO.zoneId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Zona"));

            UserEntity user = userRepository.findById(requestDTO.userId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Usuario"));
            Team team = MAPPER.toTeam(requestDTO);

            team.setPlayers(new HashSet<>(Collections.singleton(user)));

            return MAPPER.toTeamResponseDTO(teamRepository.save(team));


        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }

    }

    @Transactional(readOnly = true)
    @Override
    public List<TeamResponseDTO> getByOwnerUserId(int userId) {
        try {

            return teamRepository.findByOwnerUserId(userId)
                    .orElseThrow(() -> new AppException(ErrorMessages.USER_NOT_EXIST, HttpStatus.NOT_FOUND));


        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());

        }
    }

    @Transactional()
    @Override
    public TeamResponseDTO addUserToTeam(UserTeamAddRequestDTO userTeamAddRequestDTO) {
        try {

            Team team = teamRepository.findById(userTeamAddRequestDTO.teamId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            UserEntity user = userRepository.findById(userTeamAddRequestDTO.userId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            Set<UserEntity> players = new HashSet<>(team.getPlayers());
            players.add(user);
            team.setPlayers(players);

            return MAPPER.toTeamResponseDTO(teamRepository.save(teamRepository.save(team)));

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());

        }
    }

    /**
     * metodo para buscar los equipos al cual esta asigando un jugador
     */
    @Transactional(readOnly = true)
    @Override
    public List<TeamResponseDTO> getTeamsByUserId(int userId) {
        try {
            List<Tuple> teams = teamRepository.findByUserId(userId);

            if (teams.isEmpty()) {
                throw new AppException(ErrorMessages.USER_WITHOUT_TEAM, HttpStatus.NOT_FOUND);
            }

            return teams.stream().map(respuesta ->
                    TeamResponseDTO.builder()
                            .id(Integer.parseInt(respuesta.get("id").toString()))
                            .name(respuesta.get("name").toString())
                            .numberOfPlayers(Integer.parseInt(respuesta.get("num_players").toString()))
                            .positionPlayer(respuesta.get("position_player").toString())
                            .build()
            ).toList();

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());

        }
    }

    /***
     * metodo para obtener el equipo al cual hago parte y la lista de jugadores
     * */
    @Transactional(readOnly = true)
    @Override
    public TeamResponseDTO getTeamByUserId(int userId, int teamId) {
        try {

            List<Tuple> teamsUser = teamRepository.findTeamsByUserId(userId, teamId);

            return TeamResponseDTO.builder()
                    .id(Integer.parseInt(teamsUser.get(0).get("team_id").toString()))
                    .name(teamsUser.get(0).get("team_name").toString())
                    .players(teamsUser.stream()
                            .map(player -> UserResponseDTO.builder()
                                    .name(player.get("user_name").toString())
                                    .lastName(player.get("last_name").toString())
                                    .nickName(player.get("nick_name").toString())
                                    .positionPlayer(player.get("position_player").toString())
                                    .build())
                            .collect(Collectors.toCollection(LinkedHashSet::new)))
                    .build();


        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());

        }
    }

    @Transactional()
    @Override
    public String leaveTheTeam(int userdId, int teamId) {
        try {
            if (Boolean.TRUE.equals(teamRepository.existsByOwnerUserIdAndId(userdId, teamId))) {
                throw new AppException(ErrorMessages.USER_OWNER, HttpStatus.BAD_REQUEST);
            }

            teamRepository.leaveTheTeam(userdId, teamId);
            return "Has salido exitosamente del equipo: " + teamId;

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());

        }
    }
}



