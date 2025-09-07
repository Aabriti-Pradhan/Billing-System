package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/api")

public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @PostMapping("/create")
    public String createCustomer(@RequestParam("name") String name,
                                 @RequestParam("email") String email,
                                 @RequestParam("phone") String phone,
                                 @RequestParam("address") String address) {

        CustomerModel customer = new CustomerModel();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);

        customerService.addCustomer(customer);

        return "redirect:/api/read";
    }

    @GetMapping("/read")
    public String readCustomer(Model model) {
        List<CustomerModel> customers = customerService.readAllCustomer();
        model.addAttribute("customers", customers);
        return "allCustomers";
    }


    @PostMapping("/update")
    public String updateCustomer(@RequestParam Long id,
                                 @RequestParam String name,
                                 @RequestParam String email,
                                 @RequestParam String phone,
                                 @RequestParam String address) {
        CustomerModel customer = new CustomerModel();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);
        customerService.updateCutomer(id, customer);
        return "redirect:/api/read";
    }


    @PostMapping("/delete/{id}")
    public String deleteCustomer(@PathVariable long id) {
        customerService.deleteCustomer(id);
        return "redirect:/api/read";
    }
}
