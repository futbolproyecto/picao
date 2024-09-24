package com.example.picao.user.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.Constants;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.UsefulMethods;
import com.example.picao.core.util.mapper.UserMapper;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.dto.UserResponseDTO;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.user.service.UserService;
import lombok.AllArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.regex.Pattern;

/**
 * Clase impl para implementar logica de negocio para usuario
 */
@AllArgsConstructor
@Service
public class UserServiceImpl implements UserService, UserDetailsService {

    private final UserRepository userRepository;
    private static final Pattern pattern = Pattern.compile(Constants.PASSWORD_PATTERN);
    private static final UserMapper userMapper = Mappers.getMapper(UserMapper.class);


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        com.example.picao.user.entity.User userEntity = userRepository.findByMobileNumber(username)
                .orElseThrow(() -> new UsernameNotFoundException("El usuario " + username + " no existe."));


        return new User(userEntity.getUsername(),
                userEntity.getPassword(),
                true,
                true,
                true,
                true,
                UsefulMethods.getAuthorities(userEntity.getRoles()));
    }


    @Override
    public UserResponseDTO createUser(CreateUserRequestDTO createUserRequestDTO) {

        userRepository.findByMobileNumber(createUserRequestDTO.mobileNumber()).ifPresent(
                user -> {
                    throw new AppException(ErrorMessages.DUPLICATE_PHONE_NUMBER, HttpStatus.BAD_REQUEST);
                });

        userRepository.findByMobileNumber(createUserRequestDTO.email()).ifPresent(
                user -> {
                    throw new AppException(ErrorMessages.DUPLICATE_EMAIL, HttpStatus.BAD_REQUEST);
                });

        if (pattern.matcher(createUserRequestDTO.password()).matches()) {
            throw new AppException(ErrorMessages.INVALID_PASSWORD_PATTERN, HttpStatus.BAD_REQUEST);
        }

        try {
            com.example.picao.user.entity.User user = userMapper.toUser(createUserRequestDTO);
            return userMapper.toUserResponseDTO(user);

        } catch (RuntimeException e) {
            throw new RuntimeException(e.getMessage());
        }


    }
}
