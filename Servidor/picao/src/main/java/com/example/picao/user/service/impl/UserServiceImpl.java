package com.example.picao.user.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.UsefulMethods;
import com.example.picao.core.util.mapper.UserMapper;
import com.example.picao.otp.entity.Otp;
import com.example.picao.otp.repository.OtpRepository;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.user.service.UserService;

import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@RequiredArgsConstructor()
@Service
public class UserServiceImpl implements UserService, UserDetailsService {

    @Value("${spring.mail.username}")
    private String email;

    private static final UserMapper userMapper = Mappers.getMapper(UserMapper.class);

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JavaMailSender mailSender;
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
    public int createUser(CreateUserRequestDTO createUserRequestDTO) {
        try {

            userRepository.findByMobileNumber(createUserRequestDTO.mobileNumber()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_PHONE_NUMBER, HttpStatus.BAD_REQUEST);
                    });

            userRepository.findByEmail(createUserRequestDTO.email()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_EMAIL, HttpStatus.BAD_REQUEST);
                    });


            UserEntity userEntity = userMapper.toUser(createUserRequestDTO);
            userEntity.setPassword(passwordEncoder.encode(userEntity.getPassword()));


            userMapper.toUserResponseDTO(userRepository.save(userEntity));


            return 0;

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

    @Transactional
    @Override
    public int recoverPassword(String emailUser) {
        try {
            if (!userRepository.existsByEmail(emailUser))
                throw new AppException(ErrorMessages.EMAIL_DOES_NOT_EXIST, HttpStatus.BAD_REQUEST);

            String otp = UsefulMethods.generateOTP();
            otpRepository.save(Otp.builder()
                    .code(otp)
                    .email(emailUser)
                    .createdAt(LocalDateTime.now())
                    .build());

            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(emailUser);
            message.setSubject("Recuperacion contraseña");
            message.setText("se le olvido la contraseña papi, tenga su codigo " + otp);
            message.setFrom(email);

            mailSender.send(message);

            return 0;
        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }

    }

    private boolean isExpiredOtp(LocalDateTime createdAt) {
        return LocalDateTime.now().isAfter(createdAt.minusHours(24));
    }

}
