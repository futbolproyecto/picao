package com.example.picao.user.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.UsefulMethods;
import com.example.picao.core.util.mapper.UserMapper;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.dto.UserResponseDTO;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.user.service.UserService;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.rest.verify.v2.service.Verification;
import com.twilio.type.PhoneNumber;
import lombok.AllArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.concurrent.ThreadLocalRandom;


/**
 * Clase impl para implementar logica de negocio para usuario
 */
@Service
public class UserServiceImpl implements UserService, UserDetailsService {

    @Value("${twilio.accountSid}")
    private String accountSid;

    @Value("${twilio.authToken}")
    private String authToken;

    private static final UserMapper userMapper = Mappers.getMapper(UserMapper.class);


    public UserServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;


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

        try {
            com.example.picao.user.entity.User user = userMapper.toUser(createUserRequestDTO);
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            sendOtpViaWhatsApp("573104657100");
            return userMapper.toUserResponseDTO(userRepository.save(user));

        } catch (RuntimeException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    private void sendOtpViaWhatsApp(String destinationNumberPhone) {
        Twilio.init(accountSid, authToken);

        Message.creator(
                        new PhoneNumber("whatsapp:+573148321761"),
                        new PhoneNumber("whatsapp:+14155238886"),
                        "su codigo otp es: " + generateOTP())
                .create();

    }

    private String generateOTP() {
        int length = 6;
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otp.append(ThreadLocalRandom.current().nextInt(0, 10));
        }
        return otp.toString();
    }
}
