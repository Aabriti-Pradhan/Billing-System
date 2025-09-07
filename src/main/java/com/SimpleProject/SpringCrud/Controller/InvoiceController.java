package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.DTO.CustomerDropdownDTO;
import com.SimpleProject.SpringCrud.DTO.ProductDropdownDTO;
import com.SimpleProject.SpringCrud.Model.*;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import com.SimpleProject.SpringCrud.Repository.ProductRepository;
import com.SimpleProject.SpringCrud.Service.InvoiceService;
import com.SimpleProject.SpringCrud.Service.ServiceInvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/api")

public class InvoiceController {

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private ServiceInvoiceService serviceInvoiceService;

    @PostMapping("/createIForm")
    public String createInvoiceFromForm(
            @RequestParam("customerId") Long customerId,
            @RequestParam("discount") double discount,
            @RequestParam(value = "isPercentage", defaultValue = "false") boolean isPercentage,
            @RequestParam(required = false) List<Long> productId,
            @RequestParam(required = false) List<Integer> quantity,
            @RequestParam(required = false) List<Long> serviceId,
            @RequestParam(required = false) List<Double> amount,
            @RequestParam(required = false) Double vat,
            Model model
    ) {
        // handling product invoice
        if (productId != null && quantity != null && !productId.isEmpty()) {
            CustomerModel customer = new CustomerModel();
            customer.setCustomerId(customerId);

            List<InvoiceItemModel> items = new ArrayList<>();
            for (int i = 0; i < productId.size(); i++) {
                if (productId.get(i) != null && quantity.get(i) != null && quantity.get(i) > 0) {
                    InvoiceItemModel item = new InvoiceItemModel();
                    ProductModel product = new ProductModel();
                    product.setProductId(productId.get(i));
                    item.setProduct(product);
                    item.setQuantity(quantity.get(i));
                    items.add(item);
                }
            }
            if (!items.isEmpty()) {
                invoiceService.createInvoice(customer, items, discount, isPercentage);
            }
        }

        //handling service invoice
        if (serviceId != null && amount != null && !serviceId.isEmpty()) {
            List<ServiceInvoiceItemModel> serviceItems = new ArrayList<>();

            for (int i = 0; i < serviceId.size(); i++) {
                if (serviceId.get(i) != null && amount.get(i) != null && amount.get(i) > 0) {
                    ServiceInvoiceItemModel item = new ServiceInvoiceItemModel();
                    ServiceModel service = new ServiceModel();
                    service.setServiceId(serviceId.get(i));
                    item.setService(service);
                    item.setAmount(amount.get(i));
                    serviceItems.add(item);
                }
            }

            if (!serviceId.isEmpty() && !amount.isEmpty()) {
                serviceInvoiceService.createInvoice(customerId, serviceId, amount, vat != null ? vat : 0.0);
            }



        }


        InvoiceModel invoice = invoiceService.getLatestInvoice(); // or return the saved invoice
        model.addAttribute("invoice", invoice);

        return "serviceInvoiceView";
    }



//    @PostMapping("/createI")
//    public InvoiceModel createInvoice(@RequestBody InvoiceModel invoice) {
//        return invoiceService.createInvoice(invoice.getCustomer(),
//                invoice.getInvoiceItems(),
//                invoice.getDiscount(),
//                invoice.isPercentage());
//    }

    @GetMapping("/allInvoice")
    public String getAllInvoices(Model model) {
        List<InvoiceModel> invoices = invoiceService.getAllInvoices();
        model.addAttribute("invoices", invoices);
        return "allInvoices";
    }

    @GetMapping("/invoice/view/{id}")
    public String viewInvoice(@PathVariable Long id, Model model) {
        InvoiceModel invoice = invoiceService.getInvoiceById(id);
        model.addAttribute("invoice", invoice);
        return "viewInvoice"; // JSP page
    }


    @DeleteMapping("/invoice/{id}")
    public String deleteInvoice(@PathVariable Long id) {
        invoiceService.deleteInvoice(id);
        return "Invoice deleted successfully";
    }

    @PostMapping("/invoice/update/{id}")
    public String updateInvoiceFromForm(
            @PathVariable Long id,
            @RequestParam("customerId") Long customerId,
            @RequestParam("discount") double discount,
            @RequestParam(value = "isPercentage", defaultValue = "false") boolean isPercentage,
            @RequestParam(required = false) List<Long> productId,
            @RequestParam(required = false) List<Integer> quantity
    ) {
        CustomerModel customer = new CustomerModel();
        customer.setCustomerId(customerId);

        List<InvoiceItemModel> items = new ArrayList<>();
        if (productId != null && quantity != null) {
            for (int i = 0; i < productId.size(); i++) {
                if (productId.get(i) != null && quantity.get(i) != null && quantity.get(i) > 0) {
                    InvoiceItemModel item = new InvoiceItemModel();
                    ProductModel product = new ProductModel();
                    product.setProductId(productId.get(i));
                    item.setProduct(product);
                    item.setQuantity(quantity.get(i));
                    items.add(item);
                }
            }
        }

        invoiceService.updateInvoice(id, customer, items, discount, isPercentage);

        return "redirect:/api/allInvoice";
    }

    @GetMapping("/products/search")
    @ResponseBody
    public List<ProductDropdownDTO> searchProducts(@RequestParam String keyword) {
        return productRepository.searchProducts(keyword);
    }

    @GetMapping("/customers/search")
    @ResponseBody
    public List<CustomerDropdownDTO> searchCustomers(@RequestParam String keyword) {
        return customerRepository.searchCustomers(keyword);
    }


}
