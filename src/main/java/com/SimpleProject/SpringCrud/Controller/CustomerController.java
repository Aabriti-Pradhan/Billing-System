package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")

public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @PostMapping("/create")
    public void createCustomer(@RequestBody CustomerModel customerEntity) {
        customerService.addCustomer(customerEntity);
    }

    @GetMapping("read")
    public List<CustomerModel> readCustomer() {
        return customerService.readAllCustomer();
    }


    @PutMapping("/update/{id}")
    public CustomerModel updateCustomer(@PathVariable Long id, @RequestBody CustomerModel customerEntity) {
        return customerService.updateCutomer(id,customerEntity);
    }

    @DeleteMapping("/delete/{id}")
    public String deleteCustomer(@PathVariable long id) {
        customerService.deleteCustomer(id);
        return "Customer with id  "+id +"  Deleted";
    }
}
