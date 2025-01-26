package com.example.picao.otp.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.otp.entity.Otp;
import com.example.picao.otp.repository.OtpRepository;
import com.example.picao.otp.service.OtpService;
import com.example.picao.user.repository.UserRepository;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.concurrent.ThreadLocalRandom;

@RequiredArgsConstructor()
@Service
public class OtpServiceImpl implements OtpService {

    @Value("${twilio.accountSid}")
    private String accountSid;

    @Value("${twilio.authToken}")
    private String authToken;


    private final OtpRepository otpRepository;
    private final UserRepository userRepository;
    private final JavaMailSender mailSender;


    @Transactional
    @Override
    public Boolean validateMobileNumber(String otp, String mobileNumber) {
        return otpRepository.findByMobileNumberAndCode(mobileNumber, otp)
                .map(otpBD -> {
                    if (!isExpiredOt(otpBD.getCreatedAt(), false)) {
                        otpRepository.deleteOtp(otp);
                        return true;
                    } else {
                        throw new AppException(ErrorMessages.OTP_EXPIRED, HttpStatus.BAD_REQUEST);
                    }
                })
                .orElseThrow(() -> new AppException(ErrorMessages.INVALID_OTP, HttpStatus.NOT_FOUND));
    }

    @Transactional
    @Override
    public String resendMobileNumber(String mobileNumber) {

        try {
            Otp otpBD = otpRepository.findByMobileNumber(mobileNumber).orElseThrow(
                    () -> new AppException(ErrorMessages.PHONE_NUMBER_NOT_EXIST, HttpStatus.NOT_FOUND));

            String otp = generateOTP();
            otpBD.setCode(otp);
            otpBD.setCreatedAt(LocalDateTime.now());
            otpRepository.save(otpBD);

            sendOtpWhatsApp(mobileNumber, otp);

            return "Codigo enviado nuevamente";

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }

    }

    @Transactional
    @Override
    public String sendMobileNumber(String mobileNumber) {

        otpRepository.findByMobileNumber(mobileNumber).ifPresent(
                otpBD -> {
                    throw new AppException(ErrorMessages.GENERATED_OTP, HttpStatus.BAD_REQUEST);
                });

        String otp = generateOTP();
        otpRepository.save(Otp.builder()
                .code(otp)
                .mobileNumber(mobileNumber)
                .createdAt(LocalDateTime.now())
                .build());

        sendOtpWhatsApp(mobileNumber, otp);

        return "Codigo enviado nuevamente";

    }

    @Transactional
    @Override
    public String sendEmail(String emailUser) {
        try {
            if (!userRepository.existsByEmail(emailUser))
                throw new AppException(ErrorMessages.EMAIL_DOES_NOT_EXIST, HttpStatus.BAD_REQUEST);

            String otpGenerated = generateOTP();

            otpRepository.findByEmail(emailUser).ifPresentOrElse(
                    otpBD -> {
                        otpBD.setCode(otpGenerated);
                        otpBD.setCreatedAt(LocalDateTime.now());
                        otpRepository.save(otpBD);
                    }
                    , () ->
                            otpRepository.save(Otp.builder()
                                    .code(otpGenerated)
                                    .email(emailUser)
                                    .createdAt(LocalDateTime.now())
                                    .build()));

            sendEmailOtp(otpGenerated, emailUser);

            return "Codigo enviado correctamente";

        } catch (
                AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

    @Transactional(readOnly = true)
    @Override
    public Boolean validateEmail(String otp, String emailUser) {
        return otpRepository.findByEmailAndCode(emailUser, otp)
                .map(otpBD -> {
                    if (!isExpiredOt(otpBD.getCreatedAt(), true)) {
                        return true;
                    } else {
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

    private boolean isExpiredOt(LocalDateTime createdAt, boolean validateEmail) {
        if (validateEmail) {
            return LocalDateTime.now().isAfter(createdAt.plusMinutes(2));
        } else {
            return LocalDateTime.now().isAfter(createdAt.plusMinutes(1));
        }
    }

    private String generateOTP() {
        int length = 6;
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otp.append(ThreadLocalRandom.current().nextInt(0, 10));
        }
        return otp.toString();
    }

    private void sendEmailOtp(String otp, String email) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Recuperación contraseña");
        message.setText("Para restablecer tu contraseña, por favor ingresa el siguiente código de validación. " + otp);
        message.setFrom(email);

        mailSender.send(message);
    }


}
