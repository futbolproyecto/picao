package com.example.picao;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "files")
public class File {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "file_type_id")
    private com.example.picao.FilesType fileType;

    @Column(name = "content", length = 100)
    private String content;

    @Column(name = "extension", length = 10)
    private String extension;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "status_id")
    private com.example.picao.Status status;

}