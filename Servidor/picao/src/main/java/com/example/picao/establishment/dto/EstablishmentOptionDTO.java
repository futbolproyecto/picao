package com.example.picao.establishment.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.UUID;

@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class EstablishmentOptionDTO {
    UUID id;

    String name;
}
