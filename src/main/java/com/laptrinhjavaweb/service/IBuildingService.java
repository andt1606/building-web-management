package com.laptrinhjavaweb.service;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.request.BuildingSearchRequest;
import com.laptrinhjavaweb.dto.response.BuildingSearchResponse;

import java.util.List;
import java.util.Map;

public interface IBuildingService {
    List<BuildingDTO> findAllBuilding();
    BuildingDTO saveBuilding(BuildingDTO buildingDTO);
    Map<String, String> getDistrictMaps();
    Map<String, String> getBuildingTypesMaps();
    List<BuildingSearchResponse> findAllBuildingResponse();
    List<BuildingSearchResponse> findBuildingSearch(BuildingSearchRequest buildingSearchRequest);
    void deleteBuilding(List<Long> ids);
    BuildingDTO getBuldingById(long id);
}
