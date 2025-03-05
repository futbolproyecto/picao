package com.example.picao.user.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.UsefulMethods;
import com.example.picao.user.dto.*;
import com.example.picao.user.mapper.UserMapper;
import com.example.picao.otp.repository.OtpRepository;
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

import java.util.List;


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
    public UserResponseDTO createUser(CreateUserRequestDTO requestDTO) {
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


            return MAPPER.toUserResponseDTO(userRepository.save(userEntity));


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
    public UserResponseDTO getById(int id) {
        try {
            UserEntity userEntity = userRepository.findById(id).orElseThrow(
                    () -> new AppException(ErrorMessages.USER_NOT_EXIST, HttpStatus.NOT_FOUND));

            return MAPPER.toUserResponseDTO(userEntity);

        } catch (
                AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

    @Transactional(readOnly = true)
    @Override
    public UserResponseDTO getByMobileNumber(String mobileNumber) {
        try {

            UserEntity userEntity = userRepository.findByMobileNumber(mobileNumber)
                    .orElseThrow(() -> new AppException(ErrorMessages.PHONE_NUMBER_NOT_EXIST, HttpStatus.NOT_FOUND));

            UserResponseDTO userResponseDTO = MAPPER.toUserResponseDTO(userEntity);

            if (userEntity.getPlayerProfile() == null) {
                throw new AppException(ErrorMessages.USER_WITHOUT_PROFILE, HttpStatus.NOT_FOUND);
            }
            userResponseDTO.setNickName(userEntity.getPlayerProfile().getNickname());

            return userResponseDTO;

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

    @Transactional(readOnly = true)
    @Override
    public List<UserResponseDTO> getAll() {
        try {

            return userRepository.findAll().stream().map(MAPPER::toUserResponseDTO).toList();

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }

    }

    @Transactional
    @Override
    public UserResponseDTO update(UpdateUserRequestDTO requestDTO) {
        try {
            UserEntity userEntity = userRepository.findById(requestDTO.id()).orElseThrow(
                    () -> new AppException(ErrorMessages.USER_NOT_EXIST, HttpStatus.NOT_FOUND));

            if (!userEntity.getMobileNumber().equals(requestDTO.mobileNumber())) {
                userRepository.findByMobileNumber(requestDTO.mobileNumber()).ifPresent(
                        user -> {
                            throw new AppException(ErrorMessages.DUPLICATE_PHONE_NUMBER, HttpStatus.BAD_REQUEST);
                        });
            }

            if (!userEntity.getEmail().equals(requestDTO.email())) {
                userRepository.findByEmail(requestDTO.email()).ifPresent(
                        user -> {
                            throw new AppException(ErrorMessages.DUPLICATE_EMAIL, HttpStatus.BAD_REQUEST);
                        });
            }

            UserEntity userModified = UserMapper.USER.toUserFromUpdateUserRequestDTO(requestDTO);
            userModified.setPassword(userEntity.getPassword());

            return UserMapper.USER.toUserResponseDTO(userRepository.save(userModified));
        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }

    }

    @Transactional
    @Override
    public int setPassword(SetPasswordRequestDTO setPasswordRequestDTO) {
        try {
            UserEntity user = userRepository.findById(setPasswordRequestDTO.idUser()).orElseThrow(
                    () -> new AppException(ErrorMessages.USER_NOT_EXIST, HttpStatus.NOT_FOUND));

            if (!passwordEncoder.matches(setPasswordRequestDTO.oldPassword(), user.getPassword())) {
                throw new AppException(ErrorMessages.INVALID_OLD_PASSWORD, HttpStatus.NOT_FOUND);
            }

            user.setPassword(passwordEncoder.encode(setPasswordRequestDTO.newPassword()));
            userRepository.save(user);
            return 0;

        } catch (
                AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }
}



