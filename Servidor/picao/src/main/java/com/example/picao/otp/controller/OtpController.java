package com.example.picao.otp.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.otp.service.OtpService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@AllArgsConstructor
@RequestMapping("/otp")
public class OtpController {

    private final OtpService otpService;

    @PostMapping(value = "validate-otp")
    public ResponseEntity<GenericResponseDTO> validateOtp(
            @RequestParam("otp") String otp, @RequestParam("mobile_number") String mobileNumber) {
        return GenericResponseDTO.genericResponse(otpService.validateOtp(otp, mobileNumber));
    }

    @PostMapping(value = "resend-otp")
    public ResponseEntity<GenericResponseDTO> validateOtp(
            @RequestParam("mobile_number") String mobileNumber) {
        return GenericResponseDTO.genericResponse(otpService.resendOtp(mobileNumber));
    }
}
