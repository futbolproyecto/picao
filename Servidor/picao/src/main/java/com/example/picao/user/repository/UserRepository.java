package com.example.picao.user.repository;

import com.example.picao.user.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Clase repository para realizar interaccion con la tabla user de
 * la base de datos
 */

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {

    Optional<UserEntity> findByUsername(String username);

    Optional<UserEntity> findByMobileNumber(String mobileNumbre);

    Optional<UserEntity> findByEmail(String email);

    boolean existsByEmail(String email);

}
