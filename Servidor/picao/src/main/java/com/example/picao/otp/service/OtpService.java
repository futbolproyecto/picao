package com.example.picao.otp.service;

public interface OtpService {

    Boolean validateOtp(String otp,String mobileNumber);
    String resendOtp(String mobileNumber);
    String sendOtp(String mobileNumber);
}
