package com.example.picao.player_profile.service.impl;

import com.example.picao.city.repository.CityRepository;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.player_profile.dto.PlayerProfileResponseDTO;
import com.example.picao.player_profile.entity.PlayerProfile;
import com.example.picao.player_profile.mapper.PlayerProfileMapper;
import com.example.picao.dominant_foot.repository.DominantFootRepository;
import com.example.picao.player_profile.dto.CreateUpdatePlayerProfileRequestDTO;
import com.example.picao.player_profile.repository.PlayerProfileRepository;
import com.example.picao.player_profile.service.PlayerProfileService;
import com.example.picao.position_player.repository.PositionPlayerRepository;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.zone.repository.ZoneRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@RequiredArgsConstructor()
@Service
public class PlayerProfileServiceImpl implements PlayerProfileService {

    private static final PlayerProfileMapper MAPPER = Mappers.getMapper(PlayerProfileMapper.class);

    private final ZoneRepository zoneRepository;
    private final CityRepository cityRepository;
    private final PositionPlayerRepository positionPlayerRepository;
    private final DominantFootRepository dominantFootRepository;
    private final PlayerProfileRepository playerProfileRepository;
    private final UserRepository userRepository;

    @Transactional
    @Override
    public PlayerProfileResponseDTO createPlayerProfile(CreateUpdatePlayerProfileRequestDTO requestDTO) {
        try {

            playerProfileRepository.findByNickname(requestDTO.nickname()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_NIKCNAME, HttpStatus.BAD_REQUEST);
                    });

            dominantFootRepository.findById(requestDTO.dominantFootId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "¨Pie dominante"));

            positionPlayerRepository.findById(requestDTO.positionPlayerId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Posicion de jugador"));

            zoneRepository.findById(requestDTO.zoneId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Zona"));

            cityRepository.findById(requestDTO.cityId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Ciudad"));

            userRepository.findById(requestDTO.userId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Usuario"));

            return MAPPER.toPlayerProfileResponseDTO(
                    playerProfileRepository.save(MAPPER.toPlayerProfile(requestDTO)));

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }
    }


    @Transactional()
    @Override
    public PlayerProfileResponseDTO update(CreateUpdatePlayerProfileRequestDTO requestDTO) {
        try {
            PlayerProfile playerProfile = playerProfileRepository.findByUserId(requestDTO.userId()).orElseThrow(
                    () -> new AppException(ErrorMessages.USER_NOT_EXIST, HttpStatus.NOT_FOUND));

            if (!playerProfile.getNickname().equals(requestDTO.nickname())) {
                playerProfileRepository.findByNickname(requestDTO.nickname()).ifPresent(
                        user -> {
                            throw new AppException(ErrorMessages.DUPLICATE_NIKCNAME, HttpStatus.BAD_REQUEST);
                        });
            }

            PlayerProfile playerProfileModified = MAPPER.toPlayerProfile(requestDTO);
            playerProfileModified.setUser(playerProfile.getUser());
            playerProfileModified.setId(playerProfile.getId());

            return MAPPER.toPlayerProfileResponseDTO(playerProfileRepository.save(playerProfileModified));

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }

    }


}



