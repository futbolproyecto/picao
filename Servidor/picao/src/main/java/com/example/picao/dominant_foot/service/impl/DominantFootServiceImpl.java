package com.example.picao.dominant_foot.service.impl;

import com.example.picao.dominant_foot.entity.DominantFoot;
import com.example.picao.dominant_foot.repository.DominantFootRepository;
import com.example.picao.dominant_foot.service.DominantFootService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;


@AllArgsConstructor()
@Service
public class DominantFootServiceImpl implements DominantFootService {

    private final DominantFootRepository dominantFootRepository;

    @Override
    public List<DominantFoot> getDominantFoot() {
        return dominantFootRepository.findAll();
    }
}
