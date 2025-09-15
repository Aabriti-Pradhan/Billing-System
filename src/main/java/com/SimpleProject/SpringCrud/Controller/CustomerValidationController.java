package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/customer")
public class CustomerValidationController {

    private final CustomerRepository customerRepository;

    public CustomerValidationController(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    @GetMapping("/check-email")
    public boolean checkEmail(@RequestParam String email) {
        return customerRepository.existsByEmail(email);
    }

    @GetMapping("/check-phone")
    public boolean checkPhone(@RequestParam String phone) {
        return customerRepository.existsByPhone(phone);
    }
}
