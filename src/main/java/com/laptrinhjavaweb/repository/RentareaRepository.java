package com.laptrinhjavaweb.repository;

import com.laptrinhjavaweb.entity.RentareaEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RentareaRepository extends JpaRepository<RentareaEntity, Long> {
    void deleteByBuildingId(long buildingId);
    void deleteByBuildingIdIn(List<Long> ids);
}
