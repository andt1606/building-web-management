package com.laptrinhjavaweb.api.admin;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.dto.TransactionDTO;
import com.laptrinhjavaweb.dto.request.AddTransactionRequest;
import com.laptrinhjavaweb.dto.request.AssignmentBuildingRequest;
import com.laptrinhjavaweb.dto.request.AssignmentCustomerRequest;
import com.laptrinhjavaweb.dto.response.CustomerResponse;
import com.laptrinhjavaweb.dto.response.ResponseDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.security.utils.SecurityUtils;
import com.laptrinhjavaweb.service.ICustomerService;
import com.laptrinhjavaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController(value = "customerAPIOfAdmin")
@RequestMapping("/api")
public class CustomerAPI {

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IUserService userService;

//    @PostMapping("/customer")
//    public CustomerDTO createCustomer(@RequestBody CustomerDTO newCustomer){
//        customerService.saveCustomer(newCustomer);
//        return newCustomer;
//
//    }

    @PostMapping("/customer")
    public ResponseEntity<CustomerDTO> createCustomer(@RequestBody CustomerDTO newCustomer) {
        CustomerDTO customerDTO = new CustomerDTO();
        if (SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)) {
            customerDTO = customerService.saveCustomer(newCustomer);
        }
        return ResponseEntity.ok(customerDTO);
    }

    @GetMapping("/customer/{customerId}/staffs")
    public ResponseDTO loadStaff(@PathVariable("customerId") long id){
        ResponseDTO result = new ResponseDTO();
        List<StaffResponseDTO> staffs = userService.getCustomerStaffs(id);
        result.setMessage("success");
        result.setData(staffs);
        return result;
    }

    @PostMapping("/customer-assignment")
    public ResponseEntity<Void> updateAssignmentUser(@RequestBody AssignmentCustomerRequest request){
        if (SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)) {
            userService.assignmentCustomer(request);
        }
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/customer-add-transaction")
    public ResponseEntity<Void> updateTransaction(@RequestBody TransactionDTO request){
        customerService.addTransaction(request);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/customer")
    public void deleteCustomers(@RequestBody List<Long> ids) {
        if (SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)) {
            customerService.deleteCustomer(ids);
        }
    }
}
