package com.laptrinhjavaweb.converter;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.dto.response.BuildingSearchResponse;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.RentareaEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.enums.BuildingTypesEnum;
import com.laptrinhjavaweb.enums.DistrictsEnum;
import com.laptrinhjavaweb.service.IBuildingService;
import com.laptrinhjavaweb.service.impl.BuildingService;
import com.laptrinhjavaweb.utils.RentareaUtils;
import org.apache.commons.lang.StringUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

@Component
public class BuildingConverter {

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private IBuildingService buildingService;

    public BuildingDTO convertToDto (BuildingEntity entity){
        BuildingDTO result = modelMapper.map(entity, BuildingDTO.class);
        List<RentareaEntity> rentareaEntities= entity.getRentareas();
        List<String> rentAreas = new ArrayList<>();
        for(RentareaEntity item : rentareaEntities){
            rentAreas.add(item.getValue());
        }
        result.setRentArea(String.join(",",rentAreas));
        result.setBuildingType(getBuildingType(entity.getType()));

        return result;
    }

    public BuildingEntity convertToEntity (BuildingDTO dto){
        BuildingEntity result = modelMapper.map(dto, BuildingEntity.class);
        result.setType(String.join(",", dto.getBuildingType()));
        if(StringUtils.isNotBlank(dto.getRentArea())){
            List<String> convertedRentAreas = Arrays.asList(dto.getRentArea().split(","));
            List<RentareaEntity> rentAreas = convertedRentAreas.stream().map((String value) -> {
                RentareaEntity rentareaEntity = new RentareaEntity();
                rentareaEntity.setValue(value);
                rentareaEntity.setBuilding(result);

                return rentareaEntity;
            }).collect(Collectors.toList());

            result.setRentareas(rentAreas);
        }

        return result;
    }

    public BuildingSearchResponse convertToBuildingSearchResponse (BuildingEntity entity){
        BuildingSearchResponse result = modelMapper.map(entity, BuildingSearchResponse.class);
        result.setAddress(entity.getStreet() + ", " + entity.getWard() + ", " + getDistrictName(entity.getDistrict()));

        return result;
    }

    public void toEntity(BuildingDTO dto, BuildingEntity entity){
        modelMapper.map(dto,entity);
        entity.setType(String.join(",", dto.getBuildingType()));
    }

    public List<String> getBuildingType (String str){
        List<String> types = new ArrayList<>();
        String[] split = str.split(",");
        for(int i=0; i< split.length;i++){
            types.add(split[i]);
        }
        return types;
    }


    public String getDistrictName(String str){
        DistrictsEnum district = DistrictsEnum.valueOf(str);
        switch (district) {
            case QUAN_1:
                return DistrictsEnum.QUAN_1.getDistrictValue();
            case QUAN_2:
                return DistrictsEnum.QUAN_2.getDistrictValue();
            case QUAN_3:
                return DistrictsEnum.QUAN_3.getDistrictValue();
            default:
                return DistrictsEnum.QUAN_4.getDistrictValue();
        }
    }

}























        /*List<String> rentAreas = getRentAreas(dto.getRentArea());
        List<RentareaEntity> rentareaEntityList = new ArrayList<>();
        for(String item: rentAreas){
            RentareaEntity rentareaEntity = new RentareaEntity();
            rentareaEntity.setValue(item);
            rentareaEntityList.add(rentareaEntity);
        }
        result.setRentareas(rentareaEntityList);*/