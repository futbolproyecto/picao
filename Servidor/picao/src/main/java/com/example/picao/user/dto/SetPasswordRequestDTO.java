package com.example.picao.user.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public record SetPasswordRequestDTO(
        @JsonProperty("id_user")
        Integer idUser,
        @JsonProperty("old_password")
        String oldPassword,
        @JsonProperty("new_password")
        String newPassword
) {
}
