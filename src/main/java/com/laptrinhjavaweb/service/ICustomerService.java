package com.laptrinhjavaweb.service;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.dto.TransactionDTO;
import com.laptrinhjavaweb.dto.request.AddTransactionRequest;
import com.laptrinhjavaweb.dto.request.AssignmentBuildingRequest;
import com.laptrinhjavaweb.dto.request.CustomerSearchRequest;
import com.laptrinhjavaweb.dto.response.CustomerResponse;

import java.util.List;

public interface ICustomerService {
    CustomerDTO saveCustomer(CustomerDTO customerDTO);
    List<CustomerResponse> findByCondition(CustomerSearchRequest customerSearchRequest)
            throws IllegalAccessException;

    List<CustomerResponse> findAll();
    CustomerDTO getCustomerById(long id);

    void addTransaction(TransactionDTO request);
    void deleteCustomer(List<Long> customerIds);

}
