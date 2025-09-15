package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.InvoiceModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import com.SimpleProject.SpringCrud.Service.InvoiceService;
import com.SimpleProject.SpringCrud.Service.ProductService;
import com.SimpleProject.SpringCrud.Service.ServiceInvoiceService;
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

    @Autowired
    private ServiceInvoiceService serviceInvoiceService;

    @GetMapping("/")
    public String home() {
        return "home"; //will automatically detect home.jsp
    }

    @GetMapping("/customer")
    public String customerPage() {
        return "redirect:/api/read";
    }

    @GetMapping("/product")
    public String productPage() {
        return "redirect:/api/readP";
    }

    @GetMapping("/invoice")
    public String invoicePage(Model model) {
        model.addAttribute("customers", customerService.getAllCustomers());
        model.addAttribute("products", productService.getAllProducts());
        model.addAttribute("services", serviceInvoiceService.getAllServices());
        return "forward:/api/allInvoice";
    }

    @GetMapping("/addCustomers")
    public String addCustomerPage() {
        return "addCustomers";
    }

    @GetMapping("/addProducts")
    public String addProductPage() {
        return "addProducts";
    }

    @GetMapping("/updateCustomer/{id}")
    public String showUpdateCustomer(@PathVariable Long id, Model model) {
        CustomerModel customer = customerService.readCustomerById(id);
        model.addAttribute("customer", customer);
        return "updateCustomers";
    }

    @GetMapping("/updateProduct/{id}")
    public String showUpdateProducts(@PathVariable Long id, Model model) {
        ProductModel product = productService.readProductById(id);
        model.addAttribute("product", product);
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
        model.addAttribute("customers", customerService.getAllCustomers());
        model.addAttribute("products", productService.getAllProducts());
        model.addAttribute("services", serviceInvoiceService.getAllServices());
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
