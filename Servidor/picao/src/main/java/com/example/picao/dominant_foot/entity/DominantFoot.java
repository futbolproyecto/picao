package com.example.picao.dominant_foot.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "dominant_foot")
@NoArgsConstructor()
public class DominantFoot {

    @Id
    Integer id;

    @Column(length = 30)
    String name;

    public DominantFoot(Integer id) {
        this.id = id;
    }
}

