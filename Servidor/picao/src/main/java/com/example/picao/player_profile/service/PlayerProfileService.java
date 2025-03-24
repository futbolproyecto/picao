package com.example.picao.player_profile.service;

import com.example.picao.player_profile.dto.CreateUpdatePlayerProfileRequestDTO;
import com.example.picao.player_profile.dto.PlayerProfileResponseDTO;

public interface PlayerProfileService {

    PlayerProfileResponseDTO createPlayerProfile(CreateUpdatePlayerProfileRequestDTO requestDTO);

    PlayerProfileResponseDTO update(CreateUpdatePlayerProfileRequestDTO requestDTO);










}
