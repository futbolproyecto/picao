package com.example.picao;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.util.Objects;

@Getter
@Setter
@Embeddable
public class UsersByFieldId implements java.io.Serializable {
    private static final long serialVersionUID = 157902715997857853L;
    @Column(name = "user_id", nullable = false)
    private Integer userId;

    @Column(name = "field_id", nullable = false)
    private Integer fieldId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        UsersByFieldId entity = (UsersByFieldId) o;
        return Objects.equals(this.userId, entity.userId) &&
                Objects.equals(this.fieldId, entity.fieldId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, fieldId);
    }

}