package com.example.picao.user.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.UsefulMethods;
import com.example.picao.user.mapper.UserMapper;
import com.example.picao.otp.repository.OtpRepository;
import com.example.picao.user.dto.ChangePasswordRequestDTO;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.dto.UserResponseDTO;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.user.service.UserService;

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
public class UserServiceImpl implements UserService, UserDetailsService {

    private static final UserMapper MAPPER = Mappers.getMapper(UserMapper.class);

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final OtpRepository otpRepository;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserEntity userEntity = userRepository.findByMobileNumber(username)
                .orElseThrow(() -> new UsernameNotFoundException("El usuario " + username + " no existe."));


        return new User(userEntity.getUsername(),
                userEntity.getPassword(),
                true,
                true,
                true,
                true,
                UsefulMethods.getAuthorities(userEntity.getRoles()));
    }

    @Transactional
    @Override
    public int createUser(CreateUserRequestDTO requestDTO) {
        try {

            userRepository.findByMobileNumber(requestDTO.mobileNumber()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_PHONE_NUMBER, HttpStatus.BAD_REQUEST);
                    });

            userRepository.findByEmail(requestDTO.email()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_EMAIL, HttpStatus.BAD_REQUEST);
                    });


            UserEntity userEntity = MAPPER.toUser(requestDTO);
            userEntity.setPassword(passwordEncoder.encode(userEntity.getPassword()));


            MAPPER.toUserResponseDTO(userRepository.save(userEntity));


            return 0;

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

    @Transactional
    @Override
    public int changePassword(ChangePasswordRequestDTO requestDTO) {
        try {

            if (otpRepository.findByEmailAndCode(requestDTO.email(), requestDTO.otp()).isEmpty())
                throw new AppException(ErrorMessages.INVALID_OTP, HttpStatus.NOT_FOUND);

            UserEntity user = userRepository.findByEmail(requestDTO.email()).orElseThrow(
                    () -> new AppException(ErrorMessages.USER_NOT_EXIST, HttpStatus.NOT_FOUND));

            otpRepository.deleteOtp(requestDTO.otp());
            user.setPassword(passwordEncoder.encode(requestDTO.password()));
            userRepository.save(user);
            return 0;

        } catch (
                AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

    @Transactional(readOnly = true)
    @Override
    public UserResponseDTO getUserById(int id) {
        try {

            UserEntity userEntity = userRepository.findById(id).orElseThrow(
                    () -> new AppException(ErrorMessages.USER_NOT_EXIST, HttpStatus.NOT_FOUND));

            return MAPPER.toUserResponseDTO(userEntity);

        } catch (
                AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }
}



