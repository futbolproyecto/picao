package com.example.picao.otp.repository;

import com.example.picao.otp.entity.Otp;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface OtpRepository extends JpaRepository<Otp, Integer> {

    @Modifying
    @Query("DELETE FROM Otp o WHERE o.code = :code")
    void deleteOtp(String code);

    Optional<Otp> findByMobileNumberAndCode(String mobileNumber, String code);

    Optional<Otp> findByMobileNumber(String mobileNumber);

    Optional<Otp> findByEmailAndCode(String email, String code);
    Optional<Otp> findByEmail(String email);

}
