package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.InvoiceModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import com.SimpleProject.SpringCrud.Service.InvoiceService;
import com.SimpleProject.SpringCrud.Service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller

public class HomeController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private ProductService productService;

    @Autowired
    private InvoiceService invoiceService;

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

    @GetMapping("/service")
    public String servicePage(Model model) {
        model.addAttribute("customers", customerService.readAllCustomer());
        return "service";
    }

    @GetMapping("/addInvoice")
    public String showAddInvoicePage(Model model) {
        model.addAttribute("customers", customerService.readAllCustomer());
        model.addAttribute("products", productService.readAllProduct());
        return "addInvoice";
    }

    @GetMapping("/invoice/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        InvoiceModel invoice = invoiceService.getInvoiceById(id);
        model.addAttribute("invoice", invoice);
        return "updateInvoice";
    }

    @PostMapping("/invoice/delete/{id}")
    public String deleteInvoice(@PathVariable Long id) {
        invoiceService.deleteInvoice(id);
        return "/allInvoices";
    }


}
