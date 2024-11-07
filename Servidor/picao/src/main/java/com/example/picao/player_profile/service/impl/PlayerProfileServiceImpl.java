package com.example.picao.player_profile.service.impl;

import com.example.picao.city.repository.CityRepository;
import com.example.picao.core.util.mapper.UserMapper;
import com.example.picao.dominant_foot.repository.DominantFootRepository;
import com.example.picao.player_profile.dto.CreatePlayerProfileRequestDTO;
import com.example.picao.player_profile.repository.PlayerProfileRepository;
import com.example.picao.player_profile.service.PlayerProfileService;
import com.example.picao.position_player.repository.PositionPlayerRepository;
import com.example.picao.zone.repository.ZoneRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor()
@Service
public class PlayerProfileServiceImpl implements PlayerProfileService {

    private static final UserMapper userMapper = Mappers.getMapper(UserMapper.class);

    private final ZoneRepository zoneRepository;
    private final CityRepository cityRepository;
    private final PositionPlayerRepository positionPlayerRepository;
    private final DominantFootRepository dominantFootRepository;
    private final PlayerProfileRepository playerProfileRepository;

    @Override
    public int createPlayerProfile(CreatePlayerProfileRequestDTO createPlayerProfileRequestDTO) {
        return 0;
    }
}



