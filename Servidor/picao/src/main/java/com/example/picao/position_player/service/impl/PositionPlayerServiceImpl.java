package com.example.picao.position_player.service.impl;

import com.example.picao.position_player.entity.PositionPlayer;
import com.example.picao.position_player.repository.PositionPlayerRepository;
import com.example.picao.position_player.service.PositionPlayerService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@AllArgsConstructor()
@Service
public class PositionPlayerServiceImpl implements PositionPlayerService {

    private final PositionPlayerRepository positionPlayerRepository;

    @Transactional(readOnly = true)
    @Override
    public List<PositionPlayer> getPositionPlayers() {
        return positionPlayerRepository.findAll();
    }
}
