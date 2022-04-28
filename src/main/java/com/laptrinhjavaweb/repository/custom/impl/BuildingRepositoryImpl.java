package com.laptrinhjavaweb.repository.custom.impl;

import com.laptrinhjavaweb.builder.BuildingSearchBuilder;
import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.dto.request.BuildingSearchRequest;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.repository.custom.BuildingRepositoryCustom;
import com.laptrinhjavaweb.utils.ValidateUtils;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;


    @Override
    public List<BuildingEntity> searchBuilding(BuildingSearchBuilder buildingSearchBuilder) {
        String sql = buildQuery(buildingSearchBuilder);
        Query query = entityManager.createNativeQuery(sql, BuildingEntity.class);

//        Object[] objects = query.getResultList().toArray();
        List<BuildingEntity> result = query.getResultList();
        return result;

    }

    private String buildQuery (BuildingSearchBuilder buildingSearchBuilder) {


        StringBuilder query = new StringBuilder("SELECT * FROM building as b");

        StringBuilder joinQuery = new StringBuilder();
        StringBuilder whereQuery = new StringBuilder();

        buildQueryWithJoin(buildingSearchBuilder, joinQuery, whereQuery);
        buildQueryWithoutJoin(buildingSearchBuilder, whereQuery);

        query.append(joinQuery).append(" WHERE 1 = 1 ").append(whereQuery).append(" group by b.id ");
        return query.toString();
    }


    private void buildQueryWithJoin(BuildingSearchBuilder buildingSearchBuilder, StringBuilder joinQuery, StringBuilder whereQuery){

        if(ValidateUtils.isValidProperty(buildingSearchBuilder.getStaffId())){
            joinQuery.append(" INNER JOIN assignmentbuilding as ab on b.id = ab.buildingid" +
                    " INNER JOIN users as u on ab.staffid = u.id");
            whereQuery.append(" AND u.id = "+buildingSearchBuilder.getStaffId()+" ");
        }

        if(ValidateUtils.isValid(buildingSearchBuilder.getRentAreaFrom()) || ValidateUtils.isValid(buildingSearchBuilder.getRentAreaTo()) ) {

            whereQuery.append(" and exists (select ra.value from rentarea as ra where b.id = ra.buildingid ");

            if(ValidateUtils.isValid(buildingSearchBuilder.getRentAreaFrom())) {
                whereQuery.append(" and ra.value >= "+buildingSearchBuilder.getRentAreaFrom()+" ");
            }
            if(ValidateUtils.isValid(buildingSearchBuilder.getRentAreaTo())) {
                whereQuery.append(" and ra.value <= "+buildingSearchBuilder.getRentAreaTo()+" ");
            }
            whereQuery.append(" ) ");
        }

        if(buildingSearchBuilder.getBuildingType() != null && buildingSearchBuilder.getBuildingType().size()>0) {
            String[] types = buildingSearchBuilder.getBuildingType().toArray(new String[0]);
            whereQuery.append(" and ( ");
            String sqlTypes = Arrays.stream(types).map(item -> " b.type like '%"+item+"%'").collect(Collectors.joining(" or "));
            whereQuery.append(sqlTypes);
            whereQuery.append(" ) ");
        }

    }

    private void buildQueryWithoutJoin(BuildingSearchBuilder buildingSearchBuilder, StringBuilder whereQuery){
        if(ValidateUtils.isValid(buildingSearchBuilder.getRentPriceFrom()) || ValidateUtils.isValid(buildingSearchBuilder.getRentPriceTo())) {
            if(ValidateUtils.isValid(buildingSearchBuilder.getRentPriceFrom())) {
                whereQuery.append(" and b.rentprice >= "+buildingSearchBuilder.getRentPriceFrom()+"");
            }
            if(ValidateUtils.isValid(buildingSearchBuilder.getRentPriceTo())) {
                whereQuery.append(" and b.rentprice <= "+buildingSearchBuilder.getRentPriceTo()+"");
            }
        }

        try{
            Field[] fields = BuildingSearchBuilder.class.getDeclaredFields();
            for(Field field : fields){
                field.setAccessible(true);
                String fieldName = field.getName();
                if(!fieldName.startsWith("rentArea") && !fieldName.startsWith("rentPrice")
                        && !fieldName.equals("userAssignment") && !fieldName.equals("buildingType") ){
                    Object objectValue = field.get(buildingSearchBuilder);
                    if(objectValue != null && objectValue != SystemConstant.EMPTY_STRING){
                        if(field.getType().getName().equals("java.lang.String")){
                            whereQuery.append(" and b."+fieldName.toLowerCase()+" like '%"+objectValue+"%' ");
                        }else if(field.getType().getName().equals("java.lang.Integer")){
                            whereQuery.append(" and b."+fieldName.toLowerCase()+" = "+objectValue+" ");
                        }
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }


    @Override
    public void assignRentArea(Long buildingId, List<Long> oldRentArea, List<Long> newRentArea) {
        /*//Delete Old rentArea
        if(oldRentArea.size() > 0) {
            for(Long item : oldRentArea) {
                Query query = entityManager.createNativeQuery("Delete  from rentarea WHERE  buildingid = :b");
                query.setParameter("b",buildingId);
                int rows = query.executeUpdate();
            }
        }


        //Insert New rentArea
        if(newRentArea.size() > 0) {
            for(Long item : newRentArea) {
                Query query = entityManager.createNativeQuery("INSERT INTO rentarea (value,buildingid) VALUES (?,?)");
                query.setParameter(1,item);
                query.setParameter(2,buildingId);
                int rows = query.executeUpdate();
            }
        }*/
    }
}
