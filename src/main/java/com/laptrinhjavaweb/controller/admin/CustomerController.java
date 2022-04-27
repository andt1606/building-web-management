package com.laptrinhjavaweb.controller.admin;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.dto.request.CustomerSearchRequest;
import com.laptrinhjavaweb.dto.response.CustomerResponse;
import com.laptrinhjavaweb.security.utils.SecurityUtils;
import com.laptrinhjavaweb.service.ICustomerService;
import com.laptrinhjavaweb.service.ITransactionService;
import com.laptrinhjavaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "customerControllerOfAdmin")
public class CustomerController {

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IUserService userService;

    @Autowired
    private ITransactionService transactionService;

    @RequestMapping(value = "/admin/customer-list", method = RequestMethod.GET)
    public ModelAndView customerList(@ModelAttribute("modelSearch") CustomerSearchRequest customerSearchRequest) throws IllegalAccessException {
        ModelAndView mav = new ModelAndView("admin/customer/customer-list");

        // check role is Staff
        if (SecurityUtils.getAuthorities().contains(SystemConstant.STAFF_ROLE)) {
            Long staffId = SecurityUtils.getPrincipal().getId();
            customerSearchRequest.setStaffId(staffId);
        }

        List<CustomerResponse> customerResponses;
        customerResponses = customerService.findByCondition(customerSearchRequest);

        mav.addObject("modelSearch", customerSearchRequest);
        mav.addObject("customers", customerResponses);
        mav.addObject("staffs", userService.findAllStaff());


        return mav;
    }


    @RequestMapping(value = "/admin/customer-edit", method = RequestMethod.GET)
    public ModelAndView customerEdit(@ModelAttribute("modelEdit") CustomerDTO customerDTO) {
        ModelAndView mav = new ModelAndView("admin/customer/customer-edit");
        mav.addObject("customerModel", new CustomerDTO());
        return mav;
    }

    @RequestMapping(value = "/admin/customer-edit-{id}", method = RequestMethod.GET)
    public ModelAndView customerEditDetail(@PathVariable("id") long id) {
        ModelAndView mav = new ModelAndView("admin/customer/customer-edit");
        mav.addObject("modelEdit", customerService.getCustomerById(id));
        mav.addObject("transactions",transactionService.getTransactions(id));
        mav.addObject("AllTransactionOfCustomer",transactionService.findAllTransaction(id));
        return mav;
    }
}
