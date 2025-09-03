package com.SimpleProject.SpringCrud.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller

public class HomeController {
    @GetMapping("/")
    public String home() {
        return "home"; //will automatically detect home.jsp
    }

    @GetMapping("/customer")
    public String customerPage() {
        return "customer";
    }

    @GetMapping("/product")
    public String productPage() {
        return "product";
    }

    @GetMapping("/invoice")
    public String invoicePage() {
        return "invoice";
    }

    @GetMapping("/addCustomers")
    public String addCustomerPage() {
        return "addCustomers";
    }

    @GetMapping("/addProducts")
    public String addProductPage() {
        return "addProducts";
    }

    @GetMapping("/updateCustomers")
    public String updateCustomersPage() {
        return "updateCustomers";
    }

    @GetMapping("/updateProducts")
    public String updateProductsPage() {
        return "updateProducts";
    }

    @GetMapping("/deleteCustomer")
    public String deleteCustomersPage() {
        return "deleteCustomers";
    }

    @GetMapping("/deleteProducts")
    public String deleteProductsPage() {
        return "deleteProducts";
    }
}
