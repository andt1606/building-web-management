package com.laptrinhjavaweb.converter;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.dto.response.CustomerResponse;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.entity.RentareaEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.service.IUserService;
import com.laptrinhjavaweb.utils.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class CustomerConverter {

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private IUserService userService;

    public CustomerEntity convertToEntity (CustomerDTO dto){
        CustomerEntity result = modelMapper.map(dto, CustomerEntity.class);
        return result;
    }

    public CustomerDTO convertToDto (CustomerEntity entity){
        CustomerDTO result = modelMapper.map(entity, CustomerDTO.class);
        return result;
    }

    public CustomerResponse convertToResponse(CustomerEntity customerEntity) {
        CustomerResponse response = modelMapper.map(customerEntity, CustomerResponse.class);
        List<UserEntity> staffs = customerEntity.getUsers();
        StringBuilder staffsManage = new StringBuilder();
        for(UserEntity item: staffs){
            staffsManage.append(item.getFullName()).append(", ");
        }
        // createdDate
        response.setCreatedDate(DateUtils.convertDateToString(customerEntity.getCreatedDate()));
        response.setStatus("Đang xử lý");
        response.setManagerAssignedName(staffsManage.toString());

        return response;
    }
}
