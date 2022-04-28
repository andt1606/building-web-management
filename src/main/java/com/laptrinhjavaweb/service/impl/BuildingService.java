package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.builder.BuildingSearchBuilder;
import com.laptrinhjavaweb.converter.BuildingConverter;
import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.request.BuildingSearchRequest;
import com.laptrinhjavaweb.dto.response.BuildingSearchResponse;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.enums.BuildingTypesEnum;
import com.laptrinhjavaweb.enums.DistrictsEnum;
import com.laptrinhjavaweb.repository.BuildingRepository;
import com.laptrinhjavaweb.repository.RentareaRepository;
import com.laptrinhjavaweb.service.IBuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class BuildingService implements IBuildingService {

    @Autowired
    private RentareaRepository rentareaRepository;

    @Autowired
    private BuildingRepository buildingRepository;


    @Autowired
    private BuildingConverter buildingConverter;

    @Override
    public List<BuildingDTO> findAllBuilding() {
        List<BuildingDTO> results = new ArrayList<>();
        List<BuildingEntity> entities = buildingRepository.findAll();
        for(BuildingEntity item: entities){
            BuildingDTO buildingDTO = buildingConverter.convertToDto(item);
            results.add(buildingDTO);
        }
        return results;
    }

    @Override
    @Transactional
    public BuildingDTO saveBuilding(BuildingDTO buildingDTO) {

        Long buildingId = buildingDTO.getId();
        if(Objects.nonNull(buildingDTO)){
            BuildingEntity buildingEntity = buildingConverter.convertToEntity(buildingDTO);

            if(buildingId != null){
                BuildingEntity buildingFound = Optional.ofNullable(buildingRepository.findOne(buildingId))
                        .orElseThrow(() -> new NotFoundException("Building not found"));

                buildingEntity.setCreatedBy(buildingFound.getCreatedBy());
                buildingEntity.setCreatedDate(buildingFound.getCreatedDate());

                rentareaRepository.deleteByBuildingId(buildingId);
            }
            BuildingDTO savedBuilding  = buildingConverter.convertToDto(buildingRepository.save(buildingEntity));
            return savedBuilding;
        }
        return null;

    }


    @Override
    public Map<String, String> getDistrictMaps() {
        Map<String, String> districts = new HashMap<>();
        for (DistrictsEnum item: DistrictsEnum.values()) {
            districts.put(item.toString(), item.getDistrictValue());
        }
        return districts;
    }

    @Override
    public Map<String, String> getBuildingTypesMaps() {
        Map<String, String> buildingTypes = new HashMap<>();
        for (BuildingTypesEnum item: BuildingTypesEnum.values()) {
            buildingTypes.put(item.toString(), item.getBuildingTypeValue());
        }
        return buildingTypes;
    }

    @Override
    public List<BuildingSearchResponse> findAllBuildingResponse() {
        List<BuildingSearchResponse> results = new ArrayList<>();
        List<BuildingEntity> entities = buildingRepository.findAll();
        for(BuildingEntity item: entities){
            BuildingSearchResponse buildingSearchResponse = buildingConverter.convertToBuildingSearchResponse(item);
            results.add(buildingSearchResponse);
        }
        return results;
    }

    @Override
    public List<BuildingSearchResponse> findBuildingSearch(BuildingSearchRequest buildingSearchRequest) {
        BuildingSearchBuilder buildingSearchBuilder = convertDtoToBuilder(buildingSearchRequest);
        List<BuildingSearchResponse> results = new ArrayList<>();
        List<BuildingEntity> entities = buildingRepository.searchBuilding(buildingSearchBuilder);
        for(BuildingEntity item: entities){
            BuildingSearchResponse buildingSearchResponse = buildingConverter.convertToBuildingSearchResponse(item);
            results.add(buildingSearchResponse);
        }
        return results;
    }

    private BuildingSearchBuilder convertDtoToBuilder(BuildingSearchRequest buildingSearchRequest){
        BuildingSearchBuilder result = new BuildingSearchBuilder.Builder()
                .setName(buildingSearchRequest.getName())
                .setFloorArea(buildingSearchRequest.getFloorArea())
                .setDistrict(buildingSearchRequest.getDistrict())
                .setWard(buildingSearchRequest.getWard())
                .setStreet(buildingSearchRequest.getStreet())
                .setNumberOfBasement(buildingSearchRequest.getNumberOfBasement())
                .setDirection(buildingSearchRequest.getDirection())
                .setLevel(buildingSearchRequest.getLevel())
                .setRentAreaFrom(buildingSearchRequest.getRentAreaFrom())
                .setRentAreaTo(buildingSearchRequest.getRentAreaTo())
                .setRentPriceFrom(buildingSearchRequest.getRentPriceFrom())
                .setRentPriceTo(buildingSearchRequest.getRentPriceTo())
                .setManagerName(buildingSearchRequest.getManagerName())
                .setManagerPhone(buildingSearchRequest.getManagerPhone())
                .setStaffId(buildingSearchRequest.getStaffId())
                .setBuildingType(buildingSearchRequest.getBuildingType())
                .build();
        return result;
    }

    @Override
    @Transactional
    public void deleteBuilding(List<Long> buildingIds) {
        if(!buildingIds.isEmpty()){
            Long count = buildingRepository.countByIdIn(buildingIds);
            if(count != buildingIds.size()){
                throw new NotFoundException("Building not found");
            }
        }
        buildingRepository.deleteByIdIn(buildingIds);
    }

    @Override
    public BuildingDTO getBuldingById(long id) {
        BuildingEntity entity = buildingRepository.findById(id);
        BuildingDTO buildingDTO = buildingConverter.convertToDto(entity);
        return buildingDTO;
    }


}
