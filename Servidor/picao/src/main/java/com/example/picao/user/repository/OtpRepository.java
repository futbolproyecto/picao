package com.example.picao.user.repository;

import com.example.picao.user.entity.Otp;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface OtpRepository extends JpaRepository<Otp, Integer> {

    @Modifying
    @Query("DELETE FROM Otp o WHERE o.userEntity.id = :userId")
    void deleteByUserId(Integer userId);

}
