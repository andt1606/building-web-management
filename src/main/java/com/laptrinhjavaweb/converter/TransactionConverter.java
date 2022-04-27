package com.laptrinhjavaweb.converter;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.TransactionDTO;
import com.laptrinhjavaweb.dto.response.TransactionResponse;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.entity.RentareaEntity;
import com.laptrinhjavaweb.entity.TransactionEntity;
import com.laptrinhjavaweb.repository.CustomerRepository;
import com.laptrinhjavaweb.utils.DateUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class TransactionConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private CustomerRepository customerRepository;

    public TransactionResponse convertToResponse (TransactionEntity entity){
        TransactionResponse result = modelMapper.map(entity, TransactionResponse.class);
        result.setCreatedDate(DateUtils.convertDateToString(entity.getCreatedDate()));
        return result;
    }

    public TransactionEntity convertToEntity(TransactionDTO dto){
        TransactionEntity result = modelMapper.map(dto,TransactionEntity.class);
        return result;
    }
}
