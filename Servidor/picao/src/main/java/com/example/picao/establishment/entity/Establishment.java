package com.example.picao.establishment.entity;

import com.example.picao.city.entity.City;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.util.UUID;
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor()
@Getter
@Setter
@Table(name = "establishments")
@Entity
public class Establishment {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @Column(name = "name", length = 50, unique = true, nullable = false)
    String name;

    @Column(name = "address", length = 100, nullable = false)
    String address;

    @Column(length = 20, unique = true, nullable = false)
    String mobileNumber;

    @ManyToOne(fetch = FetchType.EAGER)
    City city;


}
