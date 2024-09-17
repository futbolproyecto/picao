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
public class FilesByUserId implements java.io.Serializable {
    private static final long serialVersionUID = 2122582559669805465L;
    @Column(name = "file_id", nullable = false)
    private Integer fileId;

    @Column(name = "user_id", nullable = false)
    private Integer userId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        FilesByUserId entity = (FilesByUserId) o;
        return Objects.equals(this.userId, entity.userId) &&
                Objects.equals(this.fileId, entity.fileId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, fileId);
    }

}