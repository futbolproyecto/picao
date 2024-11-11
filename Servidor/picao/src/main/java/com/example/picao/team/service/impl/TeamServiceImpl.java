package com.example.picao.team.service.impl;


import com.example.picao.city.repository.CityRepository;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.entity.Team;
import com.example.picao.team.mapper.TeamMapper;
import com.example.picao.team.repository.TeamRepository;
import com.example.picao.team.service.TeamService;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.zone.repository.ZoneRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

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
}



