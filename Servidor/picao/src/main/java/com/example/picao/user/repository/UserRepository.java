package com.example.picao.user.repository;

import com.example.picao.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Clase repository para realizar interaccion con la tabla user de
 * la base de datos
 */

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    Optional<User> findByUsername(String username);

    Optional<User> findByMobileNumber(String mobileNumbre);

    Optional<User> findByEmail(String email);

    @Query("select u from User u where u.mobileNumber= :mobileNumber and u.otp.code = :otpCode")
    Optional<User> findOtpUser(String otpCode, String mobileNumber);



}
