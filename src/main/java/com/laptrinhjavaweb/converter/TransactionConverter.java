package com.laptrinhjavaweb.converter;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.TransactionDTO;
import com.laptrinhjavaweb.dto.response.TransactionResponse;
import com.laptrinhjavaweb.entity.*;
import com.laptrinhjavaweb.repository.CustomerRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.utils.DateUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Component
public class TransactionConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;
    public TransactionResponse convertToResponse (TransactionEntity entity){
        TransactionResponse result = modelMapper.map(entity, TransactionResponse.class);
        result.setCreatedDate(DateUtils.convertDateToString(entity.getCreatedDate()));
        result.setStaffName(entity.getUser().getFullName());
        return result;
    }

    public TransactionEntity convertToEntity(TransactionDTO dto){
        TransactionEntity result = modelMapper.map(dto,TransactionEntity.class);
        UserEntity userEntity = Optional.ofNullable(userRepository.findOne(dto.getStaffId()))
                .orElseThrow(() -> new NotFoundException("Staff NOT FOUND!"));
        result.setUser(userEntity);
        return result;
    }
}
