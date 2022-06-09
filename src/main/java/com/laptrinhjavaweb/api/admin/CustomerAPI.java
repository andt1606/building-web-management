package com.laptrinhjavaweb.api.admin;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.dto.TransactionDTO;
import com.laptrinhjavaweb.dto.request.AddTransactionRequest;
import com.laptrinhjavaweb.dto.request.AssignmentBuildingRequest;
import com.laptrinhjavaweb.dto.request.AssignmentCustomerRequest;
import com.laptrinhjavaweb.dto.request.AvatarRequest;
import com.laptrinhjavaweb.dto.response.CustomerResponse;
import com.laptrinhjavaweb.dto.response.ResponseDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.security.utils.SecurityUtils;
import com.laptrinhjavaweb.service.ICustomerService;
import com.laptrinhjavaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;
import java.io.IOException;
import java.util.List;

@RestController(value = "customerAPIOfAdmin")
@RequestMapping("/api")
public class CustomerAPI {

    @Autowired
    ServletContext servletContext;

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
//            newCustomer.setThumbnail("/Public/Imgs/Avts/avatar7.png");
            customerDTO = customerService.saveCustomer(newCustomer);
        }
        return ResponseEntity.ok(customerDTO);
    }

    /*@PutMapping("/customer/{id}")
    public ResponseEntity<CustomerDTO> updateCustomer(@PathVariable("id") long id,@RequestBody CustomerDTO updateCustomer) {
        CustomerDTO customerDTO = new CustomerDTO();
        if (SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)) {
            customerDTO = customerService.updateCustomer(updateCustomer);
        }
        return ResponseEntity.ok(customerDTO);
    }*/
    /*@GetMapping("/customer/{customerId}/staffs")
    public ResponseDTO loadStaff(@PathVariable("customerId") long id){
        ResponseDTO result = new ResponseDTO();
        List<StaffResponseDTO> staffs = userService.getCustomerStaffs(id);
        result.setMessage("success");
        result.setData(staffs);
        return result;
    }*/

    @GetMapping("/customer/{customerId}/staffs")
    public ResponseEntity<ResponseDTO> loadStaff(@PathVariable("customerId") long id){
        ResponseDTO result = new ResponseDTO();
        List<StaffResponseDTO> staffs = userService.getCustomerStaffs(id);
        result.setMessage("success");
        result.setData(staffs);
        return ResponseEntity.ok(result);
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

    /*@DeleteMapping("/customer")
    public void deleteCustomers(@RequestBody List<Long> ids) {
        if (SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)) {
            customerService.deleteCustomer(ids);
        }
    }*/

    @DeleteMapping("/customer")
    public ResponseEntity<Void> deleteCustomers(@RequestBody List<Long> ids) {
        customerService.deleteCustomer(ids);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/customer/{customerId}")
    public ResponseEntity<String> updateAvatarCustomer(@PathVariable("customerId") long id, @RequestPart(value = "file") MultipartFile file,
                                                       HttpServletRequest request) throws ServletException, IOException {

        String imgurl="";
        for (Part part : request.getParts()) {
            String contentDisp = part.getHeader("content-disposition");
            String[] items = contentDisp.split(";");
            for(String s : items){
                String tmp = s.trim();
                if (tmp.startsWith("filename")){
                    int idx = tmp.indexOf('=') + 2;
                    String filename = tmp.substring(idx, tmp.length() - 1);
                    String targetDir = servletContext.getRealPath("Public/Imgs/Avts");
                    String destination = targetDir + "/" + filename;

                    part.write(destination);
                    imgurl ="/Public/Imgs/Avts/"+ filename;

                    System.out.println(targetDir);
                    System.out.println(imgurl);
                    System.out.println(destination);
                }
            }
        }
        CustomerDTO customerDTO = customerService.getCustomerById(id);
        customerDTO.setThumbnail(imgurl);
        customerService.updateCustomerAvatar(customerDTO);

        return new ResponseEntity<>("File uploaded!!", HttpStatus.OK);
    }
}
