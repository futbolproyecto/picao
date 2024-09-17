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
public class FilesByFieldId implements java.io.Serializable {
    private static final long serialVersionUID = -6951895577598689508L;
    @Column(name = "file_id", nullable = false)
    private Integer fileId;

    @Column(name = "field_id", nullable = false)
    private Integer fieldId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        FilesByFieldId entity = (FilesByFieldId) o;
        return Objects.equals(this.fileId, entity.fileId) &&
                Objects.equals(this.fieldId, entity.fieldId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(fileId, fieldId);
    }

}