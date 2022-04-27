package com.laptrinhjavaweb.repository.custom.impl;

import com.laptrinhjavaweb.builder.BuildingSearchBuilder;
import com.laptrinhjavaweb.builder.CustomerSearchBuilder;
import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.repository.custom.CustomerRepositoryCustom;
import com.laptrinhjavaweb.utils.SqlUtils;
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
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<CustomerEntity> findByCondition(CustomerSearchBuilder customerSearchBuilder) {
        String sql = buildQuery(customerSearchBuilder);
        Query query = entityManager.createNativeQuery(sql, CustomerEntity.class);
        List<CustomerEntity> result = query.getResultList();
        return result;
    }

    private String buildQuery (CustomerSearchBuilder customerSearchBuilder) {


        StringBuilder query = new StringBuilder("SELECT c.* FROM customer as c ");

        StringBuilder joinQuery = new StringBuilder();
        StringBuilder whereQuery = new StringBuilder();

        buildQueryWithJoin(customerSearchBuilder, joinQuery, whereQuery);
        buildQueryWithoutJoin(customerSearchBuilder, whereQuery);

        query.append(joinQuery).append(" WHERE 1 = 1 ").append(whereQuery).append(" group by c.id ");
        return query.toString();
    }

    private void buildQueryWithJoin(CustomerSearchBuilder customerSearchBuilder, StringBuilder joinQuery, StringBuilder whereQuery){

        if(ValidateUtils.isValidProperty(customerSearchBuilder.getStaffId())){
            joinQuery.append(" INNER JOIN assignmentcustomer as ac on c.id = ac.customerid" +
                    " INNER JOIN users as u on ac.staffid = u.id");
            whereQuery.append(" AND u.id = "+customerSearchBuilder.getStaffId()+" ");
        }

    }

    private void buildQueryWithoutJoin(CustomerSearchBuilder customerSearchBuilder, StringBuilder whereQuery){
        try{
            Field[] fields = CustomerSearchBuilder.class.getDeclaredFields();
            for(Field field : fields){
                field.setAccessible(true);
                String fieldName = field.getName();
                Object objectValue = field.get(customerSearchBuilder);
                if(!fieldName.equals("staffId")){
                    if(objectValue != null && objectValue != SystemConstant.EMPTY_STRING){
                        if(field.getType().getName().equals("java.lang.String")){
                            whereQuery.append(SqlUtils.buildQueryUsingLike("c",fieldName.toLowerCase(),objectValue.toString()));
                        }
                    }
                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
