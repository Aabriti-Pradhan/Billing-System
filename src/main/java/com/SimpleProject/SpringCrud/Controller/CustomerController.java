package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.DTO.CustomerDTO;
import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.MainInvoiceModel;
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

import java.time.format.DateTimeFormatter;
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
    public String readCustomer(
            @RequestParam(value = "showArchived", required = false) Boolean showArchived,
            @RequestParam(value = "sortField", required = false, defaultValue = "name") String sortField,
            @RequestParam(value = "sortDir", required = false, defaultValue = "asc") String sortDir,
            Model model) {

        List<CustomerModel> customers;

        //for archived as well as for sorting
        if (Boolean.TRUE.equals(showArchived)) {
            customers = customerService.readAllCustomer(sortField, sortDir);
        } else {
            customers = customerService.readActiveCustomers(sortField, sortDir);
        }

        model.addAttribute("customers", customers);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);

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

    @PostMapping("/customer/archive")
    @ResponseBody
    public ResponseEntity<String> archiveCustomers(@RequestBody List<Long> customerId) {
        try {
            for(Long id : customerId) {
                CustomerModel customer = customerService.getCustomerById(id);
                if(customer != null) {
                    customer.setArchived(true);
                    customerService.saveCustomer(customer); // or update
                }
            }
            return ResponseEntity.ok("Customers archived successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error archiving customers");
        }
    }

    @PostMapping("/customer/unarchive")
    @ResponseBody
    public ResponseEntity<String> unarchiveInvoices(@RequestBody List<Long> customerId) {
        customerService.unarchiveCustomers(customerId);
        return ResponseEntity.ok("Unarchived Successfully!");
    }

    @GetMapping("/customer/search")
    public String searchCustomers(@RequestParam("keyword") String keyword, Model model) {
        List<CustomerModel> customers = customerService.searchCustomers(keyword);

        model.addAttribute("customers", customers);
        model.addAttribute("keyword", keyword);

        model.addAttribute("sortField", "name");
        model.addAttribute("sortDir", "asc");

        return "allCustomers";
    }

}
