package com.example.picao.establishment.repository;

import com.example.picao.establishment.entity.Establishment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface EstablishmentRepository extends JpaRepository<Establishment, Integer> {

    Optional<Establishment> findByName(String name);
    Optional<Establishment> findByMobileNumber(String mobileNumber);

    List<Establishment> findByOwnerUserId(Integer userId);


}
