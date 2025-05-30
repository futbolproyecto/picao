package com.example.picao.user.repository;

import com.example.picao.user.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Clase repository para realizar interaccion con la tabla user de
 * la base de datos
 */

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {

    Optional<UserEntity> findByMobileNumber(String mobileNumbre);

    Optional<UserEntity> findByEmail(String email);

    boolean existsByEmail(String email);

    @Query("SELECT u FROM UserEntity u where u.mobileNumber = :loginRequest or u.email = :loginRequest")
    Optional<UserEntity> findByMobileNumberOrEmail(String loginRequest);

}
