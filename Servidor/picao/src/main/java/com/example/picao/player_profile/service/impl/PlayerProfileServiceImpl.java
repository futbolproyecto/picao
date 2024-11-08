package com.example.picao.player_profile.service.impl;

import com.example.picao.city.repository.CityRepository;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.player_profile.entity.PlayerProfile;
import com.example.picao.player_profile.mapper.PlayerProfileMapper;
import com.example.picao.dominant_foot.repository.DominantFootRepository;
import com.example.picao.player_profile.dto.CreatePlayerProfileRequestDTO;
import com.example.picao.player_profile.repository.PlayerProfileRepository;
import com.example.picao.player_profile.service.PlayerProfileService;
import com.example.picao.position_player.repository.PositionPlayerRepository;
import com.example.picao.zone.repository.ZoneRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor()
@Service
public class PlayerProfileServiceImpl implements PlayerProfileService {

    private static final PlayerProfileMapper MAPPER = Mappers.getMapper(PlayerProfileMapper.class);

    private final ZoneRepository zoneRepository;
    private final CityRepository cityRepository;
    private final PositionPlayerRepository positionPlayerRepository;
    private final DominantFootRepository dominantFootRepository;
    private final PlayerProfileRepository playerProfileRepository;

    @Override
    public PlayerProfile createPlayerProfile(CreatePlayerProfileRequestDTO requestDTO) {
        try {

            playerProfileRepository.findByNickname(requestDTO.nickname()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_NIKCNAME, HttpStatus.BAD_REQUEST);
                    });

            dominantFootRepository.findById(requestDTO.dominantFootId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            positionPlayerRepository.findById(requestDTO.positionPlayerId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            cityRepository.findById(requestDTO.cityId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            zoneRepository.findById(requestDTO.zoneId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND));

            return  playerProfileRepository.save(MAPPER.toPlayerProfile(requestDTO));

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

}



