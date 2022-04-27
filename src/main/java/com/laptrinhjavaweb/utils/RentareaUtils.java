package com.laptrinhjavaweb.utils;

import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.RentareaEntity;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;


public class RentareaUtils {


    public static List<RentareaEntity> getRentAreas(String rentAreaStr, BuildingEntity entity){
        List<RentareaEntity> rentareaEntities = new ArrayList<>();
        String[] split = rentAreaStr.split(",");
        for(int i=0; i< split.length;i++){
            if(split[i] != null && !split[i].equals("")){
                RentareaEntity rentareaEntity = new RentareaEntity();
                rentareaEntity.setValue(split[i]);
                rentareaEntity.setBuilding(entity);
                rentareaEntities.add(rentareaEntity);
            }
        }
        return rentareaEntities;
    }
}
