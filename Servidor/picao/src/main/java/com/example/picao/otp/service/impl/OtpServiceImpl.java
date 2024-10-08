package com.example.picao.otp.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.otp.entity.Otp;
import com.example.picao.otp.repository.OtpRepository;
import com.example.picao.otp.service.OtpService;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.concurrent.ThreadLocalRandom;

@Service
public class OtpServiceImpl implements OtpService {

    @Value("${twilio.accountSid}")
    private String accountSid;

    @Value("${twilio.authToken}")
    private String authToken;


    public OtpServiceImpl(OtpRepository otpRepository) {
        this.otpRepository = otpRepository;
    }

    private final OtpRepository otpRepository;


    @Transactional
    @Override
    public Boolean validateOtp(String otp, String mobileNumber) {
        return otpRepository.findByMobileNumberAndCode(mobileNumber, otp)
                .map(otpBD -> {
                    if (!isExpiredOtp(otpBD.getCreatedAt())) {
                        otpRepository.deleteOtp(otp);
                        return true;
                    } else {
                        throw new AppException(ErrorMessages.OTP_EXPIRED, HttpStatus.BAD_REQUEST);
                    }
                })
                .orElseThrow(() -> new AppException(ErrorMessages.INVALID_OTP, HttpStatus.NOT_FOUND));
    }

    @Override
    public String resendOtp(String mobileNumber) {

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

    @Override
    public String sendOtp(String mobileNumber) {

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
