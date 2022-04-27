package com.laptrinhjavaweb.repository.custom;

import com.laptrinhjavaweb.builder.BuildingSearchBuilder;
import com.laptrinhjavaweb.dto.request.BuildingSearchRequest;
import com.laptrinhjavaweb.entity.BuildingEntity;

import java.util.List;

public interface BuildingRepositoryCustom {
    List<BuildingEntity> searchBuilding(BuildingSearchBuilder buildingSearchBuilder);
    void assignRentArea(Long buildingId, List<Long> oldRentArea, List<Long> newRentArea);
}
