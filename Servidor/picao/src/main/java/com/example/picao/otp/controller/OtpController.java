package com.example.picao.otp.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.otp.service.OtpService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@AllArgsConstructor
@RequestMapping("/otp")
public class OtpController {

    private final OtpService otpService;


    @PostMapping(value = "send-mobilenumber")
    public ResponseEntity<GenericResponseDTO> sendOtp(
            @RequestParam("mobile_number") String mobileNumber) {
        return GenericResponseDTO.genericResponse(otpService.sendMobileNumber(mobileNumber));
    }


    @PutMapping(value = "validate-mobilenumber")
    public ResponseEntity<GenericResponseDTO> validateOtp(
            @RequestParam("otp") String otp, @RequestParam("mobile_number") String mobileNumber) {
        return GenericResponseDTO.genericResponse(otpService.validateMobileNumber(otp, mobileNumber));
    }

    @PutMapping(value = "resend-mobilenumber")
    public ResponseEntity<GenericResponseDTO> validateOtp(
            @RequestParam("mobile_number") String mobileNumber) {
        return GenericResponseDTO.genericResponse(otpService.resendMobileNumber(mobileNumber));
    }

    @PostMapping(value = "send-email")
    public ResponseEntity<GenericResponseDTO> sendEmail(
            @RequestParam("email") String email) {
        return GenericResponseDTO.genericResponse(otpService.sendEmail(email));
    }

    @PostMapping(value = "validate-email")
    public ResponseEntity<GenericResponseDTO> validateEmail(
            @RequestParam("otp") String otp, @RequestParam("email") String email) {
        return GenericResponseDTO.genericResponse(otpService.validateEmail(otp, email));
    }

}
