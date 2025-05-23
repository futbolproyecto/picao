package com.example.picao.agenda.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum DayOfWeek {
    LUNES(1),
    MARTES(2),
    MIERCOLES(3),
    JUEVES(4),
    VIERNES(5),
    SABADO(6),
    DOMINGO(7);

    private final int id;

    public static DayOfWeek fromId(int id) {
        for (DayOfWeek day : values()) {
            if (day.id == id) {
                return day;
            }
        }
        throw new IllegalArgumentException("ID de día inválido: " + id);
    }
}
