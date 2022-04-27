package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.builder.CustomerSearchBuilder;
import com.laptrinhjavaweb.converter.CustomerConverter;
import com.laptrinhjavaweb.converter.TransactionConverter;
import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.dto.TransactionDTO;
import com.laptrinhjavaweb.dto.request.AddTransactionRequest;
import com.laptrinhjavaweb.dto.request.AssignmentCustomerRequest;
import com.laptrinhjavaweb.dto.request.CustomerSearchRequest;
import com.laptrinhjavaweb.dto.response.CustomerResponse;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.entity.TransactionEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.CustomerRepository;
import com.laptrinhjavaweb.repository.TransactionRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.ICustomerService;
import com.laptrinhjavaweb.service.IUserService;
import com.laptrinhjavaweb.utils.ValidateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CustomerService implements ICustomerService {

    @Autowired
    private CustomerConverter customerConverter;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private TransactionConverter transactionConverter;

    @Autowired
    private IUserService userService;

    @Override
    public List<CustomerResponse> findAll() {
        List<CustomerEntity> customers = customerRepository.findAll();

        if (customers.isEmpty()) {
            return new ArrayList<>();
        }

        return customers.stream().map(customerConverter::convertToResponse)
                .collect(Collectors.toList());
    }


    @Override
    @Transactional
    public CustomerDTO saveCustomer(CustomerDTO customerDTO) {
        Long customerId = customerDTO.getId();
        if(Objects.nonNull(customerDTO)){
            CustomerEntity customerEntity = customerConverter.convertToEntity(customerDTO);
            if(customerId != null){
                CustomerEntity customerFound = Optional.ofNullable(customerRepository.findOne(customerId))
                        .orElseThrow(() -> new NotFoundException("Customer not found"));

                customerEntity.setUsers(customerFound.getUsers());
            }
            CustomerDTO savedCustomer  = customerConverter.convertToDto(customerRepository.save(customerEntity));
            return savedCustomer;
        }
        return null;
    }

    @Override
    public List<CustomerResponse> findByCondition(CustomerSearchRequest customerSearchRequest) throws IllegalAccessException {
        CustomerSearchBuilder customerSearchBuilder = initCustomerSearchBuilder(customerSearchRequest);

        if (!ValidateUtils.isValidObject(customerSearchRequest)) {
            return findAll();
        }
        List<CustomerEntity> existCustomers = customerRepository.findByCondition(customerSearchBuilder);
        if (existCustomers.isEmpty()) {
            return new ArrayList<>();
        }
        return existCustomers.stream()
                .map(customerConverter::convertToResponse)
                .collect(Collectors.toList());
    }



    private CustomerSearchBuilder initCustomerSearchBuilder(
            CustomerSearchRequest customerSearchRequest) {
        return new CustomerSearchBuilder.Builder()
                .setFullname(customerSearchRequest.getFullname())
                .setPhone(customerSearchRequest.getPhone())
                .setEmail(customerSearchRequest.getEmail())
                .setStaffId(customerSearchRequest.getStaffId())
                .build();
    }

    @Override
    public CustomerDTO getCustomerById(long id) {
        CustomerEntity customerEntity = Optional.ofNullable(customerRepository.findOne(id))
                .orElseThrow(() -> new NotFoundException("Customer NOT FOUND!"));

        return customerConverter.convertToDto(customerEntity);
    }

    @Override
    @Transactional
    public void addTransaction(TransactionDTO transactionDTO) {
        Long customerId = transactionDTO.getCustomerId();
        if(Objects.nonNull(transactionDTO)){
            CustomerEntity customerEntity = Optional.ofNullable(customerRepository.findOne(customerId))
                    .orElseThrow(() -> new NotFoundException("Customer NOT FOUND!"));

            TransactionEntity transactionEntity = transactionConverter.convertToEntity(transactionDTO);
            transactionRepository.save(transactionEntity);

        }

    }

    @Override
    @Transactional
    public void deleteCustomer(List<Long> customerIds) {
        if(!customerIds.isEmpty()){
            Long count = customerRepository.countByIdIn(customerIds);
            if(count != customerIds.size()){
                throw new NotFoundException("Customer not found");
            }
        }
        customerRepository.deleteByIdIn(customerIds);
    }



}
