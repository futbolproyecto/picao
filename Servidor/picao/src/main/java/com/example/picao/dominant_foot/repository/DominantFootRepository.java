package com.example.picao.dominant_foot.repository;

import com.example.picao.dominant_foot.entity.DominantFoot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DominantFootRepository extends JpaRepository<DominantFoot, Integer> {
}
