//package com.SimpleProject.SpringCrud.Controller;
//
//import com.SimpleProject.SpringCrud.Model.ServiceInvoiceModel;
//import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
//import com.SimpleProject.SpringCrud.Service.ServiceInvoiceService;
//import jakarta.servlet.http.HttpServletRequest;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//
//@Controller
//@RequestMapping("/serviceApi")
//public class ServiceInvoiceController {
//
//    @Autowired
//    private CustomerRepository customerRepository;
//
//    @Autowired
//    private ServiceInvoiceService serviceInvoiceService;
//
//    @GetMapping("/entry")
//    public String showServiceEntryForm(Model model) {
//        model.addAttribute("customers", customerRepository.findAll());
//        return "service";
//    }
//
//    @PostMapping("/save")
//    public String saveServiceInvoice(HttpServletRequest request, Model model) {
//
//        Long customerId = Long.parseLong(request.getParameter("customerId"));
//
//        String[] serviceNames = request.getParameterValues("serviceName[]");
//        String[] amounts = request.getParameterValues("serviceAmount[]");
//        String vats = request.getParameter("serviceVat");
//
//        ServiceInvoiceModel invoice = serviceInvoiceService.createInvoice(
//                customerId, serviceNames, amounts, vats
//        );
//
//        model.addAttribute("invoice", invoice);
//        return "serviceInvoiceView"; // JSP to display invoice
//    }
//
//}
