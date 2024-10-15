package com.example.picao.authentication.service.impl;

import com.example.picao.authentication.dto.AuthResponseDTO;
import com.example.picao.authentication.dto.LoginRequestDTO;
import com.example.picao.authentication.service.AuthenticationService;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.security.jwt.JwtUtils;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.UsefulMethods;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.core.util.mapper.UserMapper;
import com.example.picao.user.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@AllArgsConstructor
@Service
public class AuthenticationServiceImpl implements AuthenticationService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtils jwtUtils;

    @Transactional(readOnly = true)
    @Override
    public AuthResponseDTO login(LoginRequestDTO loginRequestDTO) {

        UserEntity userEntity = userRepository.findByMobileNumberOrEmail(loginRequestDTO.emailOrMobileNumber())
                .orElseThrow(() -> new AppException(
                        ErrorMessages.AUTHENTICATION_ERROR, HttpStatus.BAD_REQUEST));

        if (!passwordEncoder.matches(loginRequestDTO.password(), userEntity.getPassword())) {
            throw new AppException(
                    ErrorMessages.AUTHENTICATION_ERROR, HttpStatus.BAD_REQUEST);
        }

        try {
            AuthResponseDTO authResponse = UserMapper.USER.toAuthResponseDTO(userEntity);
            authResponse.setToken(generateToken(userEntity));

            return authResponse;

        } catch (AppException ex) {
            throw new AppException(ex.getErrorMessages(), ex.getHttpStatus());
        }

    }

    private String generateToken(UserEntity userEntity) {

        Authentication authentication = new UsernamePasswordAuthenticationToken(
                userEntity.getEmail(), null,
                UsefulMethods.getAuthorities(userEntity.getRoles()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        return jwtUtils.createToken(authentication);
    }
}
