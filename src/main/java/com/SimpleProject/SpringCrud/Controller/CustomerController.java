package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.DTO.CustomerDTO;
import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api")

public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @GetMapping("/read")
    public String readCustomer(Model model) {
        List<CustomerModel> customers = customerService.readAllCustomer();
        model.addAttribute("customers", customers);
        return "allCustomers";
    }


    @PostMapping("/create")
    public String createCustomer(@RequestParam("name") String name,
                                 @RequestParam("email") String email,
                                 @RequestParam("phone") String phone,
                                 @RequestParam("address") String address,
                                 @Valid CustomerDTO customerDTO,
                                 BindingResult bindingResult,
                                 RedirectAttributes redirectAttributes,
                                 Model model) {

        if (bindingResult.hasErrors()) {
            List<String> list = new ArrayList<>();
            for (ObjectError objectError : bindingResult.getAllErrors()) {
                list.add(objectError.getDefaultMessage());
            }
            //return toast here
        }

        // Check uniqueness of phone and email
        if (customerService.existsByPhone(customerDTO.getPhone())) {
            model.addAttribute("toastMessage", "Phone already exists!");
            model.addAttribute("toastType", "danger");
            // Add the previously entered values so the form can be prefilled
            model.addAttribute("name", name);
            model.addAttribute("email", email);
            model.addAttribute("phone", phone);
            model.addAttribute("address", address);
            return "addCustomers"; // reload the same add page
        }

        if (customerService.existsByEmail(customerDTO.getEmail())) {
            model.addAttribute("toastMessage", "Email already exists!");
            model.addAttribute("toastType", "danger");
            model.addAttribute("name", name);
            model.addAttribute("email", email);
            model.addAttribute("phone", phone);
            model.addAttribute("address", address);
            return "addCustomers";
        }

        CustomerModel customer = new CustomerModel();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);

        customerService.addCustomer(customer);

        redirectAttributes.addFlashAttribute("toastMessage", "Customer created successfully!");
        redirectAttributes.addFlashAttribute("toastType", "success");

        redirectAttributes.addFlashAttribute("toastMessage", "Customer created successfully!");
        redirectAttributes.addFlashAttribute("toastType", "success");
        return "redirect:/api/read";

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
