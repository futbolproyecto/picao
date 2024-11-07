package com.example.picao.player_details.service.impl;

import com.example.picao.city.repository.CityRepository;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.UsefulMethods;
import com.example.picao.core.util.mapper.UserMapper;
import com.example.picao.dominant_foot.repository.DominantFootRepository;
import com.example.picao.otp.repository.OtpRepository;
import com.example.picao.player_details.dto.CreatePlayerDetailsRequestDTO;
import com.example.picao.player_details.repository.PlayerDetailsRepository;
import com.example.picao.player_details.service.PlayerDetailsService;
import com.example.picao.position_player.repository.PositionPlayerRepository;
import com.example.picao.user.dto.ChangePasswordRequestDTO;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.dto.UserResponseDTO;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.zone.repository.ZoneRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@RequiredArgsConstructor()
@Service
public class PlayerDetailsServiceImpl implements PlayerDetailsService {

    private static final UserMapper userMapper = Mappers.getMapper(UserMapper.class);

    private final ZoneRepository zoneRepository;
    private final CityRepository cityRepository;
    private final PositionPlayerRepository positionPlayerRepository;
    private final DominantFootRepository dominantFootRepository;
    private final PlayerDetailsRepository playerDetailsRepository;

    @Override
    public int createPlayerDetails(CreatePlayerDetailsRequestDTO createPlayerDetailsRequestDTO) {
        return 0;
    }
}



