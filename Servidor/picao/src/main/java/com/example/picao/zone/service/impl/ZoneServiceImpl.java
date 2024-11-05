package com.example.picao.zone.service.impl;

import com.example.picao.zone.entity.Zone;
import com.example.picao.zone.repository.ZoneRepository;
import com.example.picao.zone.service.ZoneService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@AllArgsConstructor()
@Service
public class ZoneServiceImpl implements ZoneService {

    private final ZoneRepository zoneRepository;

    @Transactional(readOnly = true)
    @Override
    public List<Zone> getZones() {
        return zoneRepository.findAll();
    }
}
