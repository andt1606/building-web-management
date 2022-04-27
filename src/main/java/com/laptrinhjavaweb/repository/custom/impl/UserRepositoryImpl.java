package com.laptrinhjavaweb.repository.custom.impl;

import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.custom.UserRepositoryCustom;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

public class UserRepositoryImpl implements UserRepositoryCustom {

//    @PersistenceContext
//    private EntityManager entityManager;
//
//    @Override
//    public List<UserEntity> getAllStaffs() {
//        String sql = "select * "
//                + " from users as u inner join user_role as ur on u.id = ur.user_id inner join role as r on ur.role_id = r.id"
//                + " where r.code = 'STAFF' " ;
//        Query query = entityManager.createNativeQuery(sql,UserEntity.class);
//        List<UserEntity> result = query.getResultList();
//        return result;
//    }
//
//    @Override
//    public List<UserEntity> getStaffIds(Long buildingId) {
//        String sql = buildQuery(buildingId);
//        Query query = entityManager.createNativeQuery(sql, UserEntity.class);
//        List<UserEntity> result = query.getResultList();
//        return result;
//    }
//
//    @Override
//    public void assignBuilding(Long buildingId, List<Long> oldStaff, List<Long> newStaff) {
//
//        //Delete Old Staff
//        if(oldStaff.size() > 0) {
//            for(Long item : oldStaff) {
//                Query query = entityManager.createNativeQuery("Delete  from assignmentbuilding WHERE staffid =:s and buildingid = :b");
//                query.setParameter("s", item);
//                query.setParameter("b",buildingId);
//                int rows = query.executeUpdate();
//            }
//        }
//
//
//        //Insert New Staff
//        if(newStaff.size() > 0) {
//            for(Long item : newStaff) {
//                Query query = entityManager.createNativeQuery("INSERT INTO assignmentbuilding (staffid,buildingid) VALUES (?,?)");
//                query.setParameter(1,item);
//                query.setParameter(2,buildingId);
//                int rows = query.executeUpdate();
//            }
//        }
//
//    }
//
//    private String buildQuery (Long buildingId) {
//
//        if(buildingId != null && buildingId > 0) {
//            StringBuilder query = new StringBuilder("SELECT * from users as u "
//                    + " inner join user_role as ur on u.id = ur.user_id "
//                    + " inner join role as r on ur.role_id = r.id and r.code ='STAFF' "
//                    + " inner join assignmentbuilding as amb on u.id = amb.staffid and amb.buildingid = " + buildingId);
//            return query.toString();
//        }
//        return null;
//    }
}
