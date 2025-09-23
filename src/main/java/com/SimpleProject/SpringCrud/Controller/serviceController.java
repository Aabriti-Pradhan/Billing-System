package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Model.ServiceModel;
import com.SimpleProject.SpringCrud.Service.ProductService;
import com.SimpleProject.SpringCrud.Service.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api")

public class serviceController {

    @Autowired
    private ServiceService serviceService;

    @PostMapping("/createS")
    public String createService(@RequestParam("name") String serviceName,
                                @RequestParam("amount") double amount,
                                RedirectAttributes redirectAttributes,
                                Model model) {

        try {
            ServiceModel service = new ServiceModel();
            service.setServiceName(serviceName);
            service.setAmount(amount);

            serviceService.addService(service);

            redirectAttributes.addFlashAttribute("toastMessage", "Product created successfully!");
            redirectAttributes.addFlashAttribute("toastType", "success");

            return "redirect:/api/readS";
        }
        catch (org.springframework.dao.DataIntegrityViolationException ex) {
            // This catches database-level unique constraint violations
            model.addAttribute("toastMessage", "ID or unique field already exists in the database!");
            model.addAttribute("toastType", "danger");

            return "allServices"; // stay on same page with toast
        }
    }

    @GetMapping("/readS")
    public String readService(
            @RequestParam(value = "showArchived", required = false) Boolean showArchived,
            @RequestParam(value = "sortField", required = false, defaultValue = "serviceName") String sortField,
            @RequestParam(value = "sortDir", required = false, defaultValue = "asc") String sortDir,
            Model model) {

        List<ServiceModel> services;

        //for archived as well as for sorting
        if (Boolean.TRUE.equals(showArchived)) {
            services = serviceService.readAllService(sortField, sortDir);
        } else {
            services = serviceService.readActiveServices(sortField, sortDir);
        }

        model.addAttribute("services", services);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);

        return "allServices";
    }


    @PostMapping("/updateS")
    public String updateServiceFromForm(
            @RequestParam("id") Long id,
            @RequestParam("name") String name,
            @RequestParam("amount") double amount) {

        ServiceModel service = new ServiceModel();
        service.setServiceName(name);
        service.setAmount(amount);

        serviceService.updateService(id, service);

        return "redirect:/api/readS";
    }

    @PostMapping("/service/archive")
    @ResponseBody
    public ResponseEntity<String> archiveServices(@RequestBody List<Long> serviceId) {
        try {
            for(Long id : serviceId) {
                ServiceModel service = serviceService.getServiceById(id);
                if(service != null) {
                    service.setArchived(true);
                    serviceService.saveService(service); // or update
                }
            }
            return ResponseEntity.ok("Services archived successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error archiving services");
        }
    }

    @PostMapping("/service/unarchive")
    @ResponseBody
    public ResponseEntity<String> unarchiveServices(@RequestBody List<Long> serviceId) {
        serviceService.unarchiveServices(serviceId);
        return ResponseEntity.ok("Restored Successfully!");
    }

    @GetMapping("/service/search")
    public String searchProducts(@RequestParam("keyword") String keyword, Model model) {
        List<ServiceModel> services = serviceService.searchServices(keyword);

        model.addAttribute("services", services);
        model.addAttribute("keyword", keyword);

        model.addAttribute("sortField", "serviceName");
        model.addAttribute("sortDir", "asc");

        return "allServices";
    }

    //getting service for update
    @GetMapping("/service/{id}")
    @ResponseBody
    public ResponseEntity<?> getService(@PathVariable Long id) {
        ServiceModel service = serviceService.getServiceById(id);
        if (service != null) {
            ServiceModel dto = new ServiceModel();
            dto.setServiceName(service.getServiceName());
            dto.setAmount(service.getAmount());
            return ResponseEntity.ok(dto);
        } else {
            Map<String, String> error = new HashMap<>();
            error.put("message", "Service not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
        }
    }
}
