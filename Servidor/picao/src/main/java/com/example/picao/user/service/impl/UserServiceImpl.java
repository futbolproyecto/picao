package com.example.picao.user.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.UsefulMethods;
import com.example.picao.core.util.mapper.UserMapper;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.entity.Otp;
import com.example.picao.user.repository.OtpRepository;
import com.example.picao.user.repository.UserRepository;
import com.example.picao.user.service.UserService;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.concurrent.ThreadLocalRandom;


@Service
public class UserServiceImpl implements UserService, UserDetailsService {

    @Value("${twilio.accountSid}")
    private String accountSid;

    @Value("${twilio.authToken}")
    private String authToken;

    private static final UserMapper userMapper = Mappers.getMapper(UserMapper.class);


    public UserServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder,
                           OtpRepository otpRepository) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.otpRepository = otpRepository;
    }

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final OtpRepository otpRepository;


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

    @Transactional
    @Override
    public int createUser(CreateUserRequestDTO createUserRequestDTO) {
        try {

            userRepository.findByMobileNumber(createUserRequestDTO.mobileNumber()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_PHONE_NUMBER, HttpStatus.BAD_REQUEST);
                    });

            userRepository.findByMobileNumber(createUserRequestDTO.email()).ifPresent(
                    user -> {
                        throw new AppException(ErrorMessages.DUPLICATE_EMAIL, HttpStatus.BAD_REQUEST);
                    });

            String otp = generateOTP();

            com.example.picao.user.entity.User user = userMapper.toUser(createUserRequestDTO);
            user.setPassword(passwordEncoder.encode(user.getPassword()));

            user.setOtp(Otp.builder()
                    .code(otp)
                    .createdAt(LocalDateTime.now())
                    .user(user)
                    .build());

            userMapper.toUserResponseDTO(userRepository.save(user));
            sendOtpWhatsApp(user.getMobileNumber(), otp);


            return 0;

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

    @Transactional
    @Override
    public String validateOtp(String otp, String mobileNumber) {
        return userRepository.findOtpUser(otp, mobileNumber)
                .map(user -> {
                    if (!isExpiredOtp(user.getOtp().getCreatedAt())) {
                        otpRepository.deleteByUserId(user.getId());
                        return "Número de celular verificado con éxito.";
                    } else {
                        otpRepository.deleteByUserId(user.getId());
                        throw new AppException(ErrorMessages.OTP_EXPIRED, HttpStatus.BAD_REQUEST);
                    }
                })
                .orElseThrow(() -> new AppException(ErrorMessages.INVALID_OTP, HttpStatus.NOT_FOUND));
    }

    private void sendOtpWhatsApp(String destinationNumberPhone, String otp) {
        Twilio.init(accountSid, authToken);

        Message.creator(
                        new PhoneNumber("whatsapp:+" + destinationNumberPhone),
                        new PhoneNumber("whatsapp:+14155238886"),
                        "su codigo otp es: " + otp)
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

    private boolean isExpiredOtp(LocalDateTime createdAt) {
        return LocalDateTime.now().isAfter(createdAt.plusMinutes(1));
    }
}
