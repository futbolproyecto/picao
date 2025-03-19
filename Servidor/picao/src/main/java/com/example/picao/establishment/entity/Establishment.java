package com.example.picao.establishment.entity;

import com.example.picao.city.entity.City;
import com.example.picao.department.entity.Department;
import com.example.picao.user.entity.UserEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.util.Set;
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

    @Column(length = 50, unique = true, nullable = false)
    String name;

    @Column(length = 100, nullable = false)
    String address;

    @Column(length = 20, unique = true, nullable = false)
    String mobileNumber;

    @ManyToOne(fetch = FetchType.EAGER)
    City city;

    @ManyToOne(fetch = FetchType.EAGER)
    Department department;

    @ManyToOne(fetch = FetchType.LAZY)
    UserEntity ownerUser;

    @ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST,
            CascadeType.REFRESH})
    @JoinTable(name = "establishments_user",
            joinColumns = @JoinColumn(
                    name = "establishment_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
    Set<UserEntity> users;


}
