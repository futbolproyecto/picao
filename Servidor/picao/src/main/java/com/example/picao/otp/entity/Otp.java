package com.example.picao.otp.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "otp")
@Entity
public class Otp {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(nullable = false, length = 20)
    String code;

    @Column(length = 20)
    String mobileNumber;

    @Column(length = 100)
    String email;

    @Column(nullable = false)
    LocalDateTime createdAt;


}
