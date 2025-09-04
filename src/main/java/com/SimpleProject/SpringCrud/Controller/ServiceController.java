package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ServiceModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import com.SimpleProject.SpringCrud.Service.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/serviceApi")
public class ServiceController {

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private CustomerService customerService;

    // Show Service Page
    @GetMapping
    public String servicePage(Model model) {
        model.addAttribute("customers", customerService.readAllCustomer());
        return "service";
    }

    // Save services from form
    @PostMapping("/save")
    public String saveServices(
            @RequestParam("customerId") Long customerId,
            @RequestParam("serviceName") List<String> serviceNames,
            @RequestParam("serviceAmount") List<Double> serviceAmounts,
            @RequestParam("serviceVat") List<Double> serviceVats
    ) {
        // Call service layer to save
        serviceService.saveService(customerId, serviceNames, serviceAmounts, serviceVats);

        return "redirect:/serviceEntry"; // or wherever you want to redirect
    }
}
