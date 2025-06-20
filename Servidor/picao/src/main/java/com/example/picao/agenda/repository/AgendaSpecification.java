package com.example.picao.agenda.repository;

import com.example.picao.agenda.entity.Agenda;
import com.example.picao.agenda.entity.TimeStatus;
import com.example.picao.city.entity.City;
import com.example.picao.establishment.entity.Establishment;
import com.example.picao.field.entity.Field;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;


public class AgendaSpecification {

    private AgendaSpecification() {
    }

    public static Specification<Agenda> filterBy(
            String city,
            LocalDate date,
            LocalTime startTime,
            LocalTime endTime,
            String establishment) {

        return (agenda, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            // Join con Field
            Join<Agenda, Field> fieldJoin = agenda.join("field");

            // Join con Establishment
            Join<Field, Establishment> establishmentJoin = fieldJoin.join("establishment");

            // Join con City (para acceder a city.name)
            Join<Establishment, City> cityJoin = establishmentJoin.join("city");

            // ciudad es obligatoria
            predicates.add(cb.equal(cb.lower(cityJoin.get("name")), city.toLowerCase()));

            // estado DISPONIBLE obligatorio
            predicates.add(cb.equal(agenda.get("status"), TimeStatus.DISPONIBLE));

            // fecha opcional
            if (date != null) {
                predicates.add(cb.equal(agenda.get("date"), date));
            }

            // hora opcional
            // filtro por rango de horas
            if (startTime != null && endTime != null) {
                predicates.add(cb.between(agenda.get("startTime"), startTime, endTime));
            } else if (startTime != null) {
                predicates.add(cb.equal(agenda.get("startTime"), startTime));
            } else if (endTime != null) {
                predicates.add(cb.lessThanOrEqualTo(agenda.get("startTime"), endTime));
            }

            // nombre del establecimiento opcional
            if (establishment != null && !establishment.isEmpty()) {
                predicates.add(cb.like(
                        cb.lower(establishmentJoin.get("name")),
                        "%" + establishment.toLowerCase() + "%"
                ));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
