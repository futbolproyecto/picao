package com.example.picao.otp.service;

public interface OtpService {

    Boolean validateMobileNumber(String otp, String mobileNumber);

    String resendMobileNumber(String mobileNumber);

    String sendMobileNumber(String mobileNumber);

    String sendEmail(String emailUser);

    Boolean validateEmail(String otp, String emailUser);
}
