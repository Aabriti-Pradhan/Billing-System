package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.DTO.CustomerDropdownDTO;
import com.SimpleProject.SpringCrud.DTO.ProductDropdownDTO;
import com.SimpleProject.SpringCrud.Model.*;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import com.SimpleProject.SpringCrud.Repository.ProductRepository;
import com.SimpleProject.SpringCrud.Repository.ServiceRepository;
import com.SimpleProject.SpringCrud.Service.InvoiceService;
import com.SimpleProject.SpringCrud.Service.MainInvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/api")
public class InvoiceController {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private ServiceRepository serviceRepository;

    @Autowired
    private MainInvoiceService mainInvoiceService;

    @Autowired
    private InvoiceService invoiceService;

    @PostMapping("/createIForm")
    public String createInvoiceFromForm(
            @RequestParam("customerId") Long customerId,
            @RequestParam(value = "discount", required = false, defaultValue = "0") double discount,
            @RequestParam(value = "isPercentage", defaultValue = "false") boolean isPercentage,
            @RequestParam(required = false) List<Long> productId,
            @RequestParam(required = false) List<Integer> quantity,
            @RequestParam(required = false) List<Long> serviceId,
            @RequestParam(required = false) List<Double> amount,
            @RequestParam(required = false) Double vat,
            Model model
    ) {

        CustomerModel customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        MainInvoiceModel mainInvoice = new MainInvoiceModel();
        mainInvoice.setCustomer(customer);

        List<InvoiceModel> productInvoices = new ArrayList<>();
        double productTotal = 0.0;
        double serviceTotal = 0.0;
        double mainTotal = 0.0;

        // PRODUCT INVOICES
        if (productId != null && quantity != null && !productId.isEmpty()) {
            InvoiceModel invoice = new InvoiceModel();
            invoice.setCustomer(customer);
            invoice.setDiscount(discount);
            invoice.setPercentage(isPercentage);
            invoice.setMainInvoice(mainInvoice);
            invoice.setInvoiceDate(LocalDate.now());  // set date

            List<InvoiceItemModel> items = new ArrayList<>();

            for (int i = 0; i < productId.size(); i++) {
                if (productId.get(i) != null && quantity.get(i) != null && quantity.get(i) > 0) {
                    ProductModel product = productRepository.findById(productId.get(i))
                            .orElseThrow(() -> new RuntimeException("Product not found"));

                    InvoiceItemModel item = new InvoiceItemModel();
                    item.setProduct(product);
                    item.setQuantity(quantity.get(i));
                    item.setUnitPrice(product.getPrice());

                    double lineTotal = item.getUnitPrice() * item.getQuantity();
                    item.setSubtotal(lineTotal);  // raw line total (before invoice discount)

                    productTotal += lineTotal;  // accumulate invoice total

                    item.setInvoice(invoice);
                    items.add(item);
                }
            }

            // apply discount ON TOTAL
            if (isPercentage) {
                productTotal -= (productTotal * discount / 100);
            } else {
                productTotal -= discount;
            }

            // assign final discounted total to invoice
            invoice.setTotalAmount(productTotal);
            invoice.setInvoiceItems(items);

            productInvoices.add(invoice);
        }

        mainInvoice.setProductInvoices(productInvoices);

        // SERVICE INVOICES
        List<ServiceInvoiceModel> serviceInvoices = new ArrayList<>();
        if (serviceId != null && amount != null && !serviceId.isEmpty()) {
            for (int i = 0; i < serviceId.size(); i++) {
                if (serviceId.get(i) != null && amount.get(i) != null && amount.get(i) > 0) {

                    ServiceInvoiceModel serviceInvoice = new ServiceInvoiceModel();
                    serviceInvoice.setCustomer(customer);
                    serviceInvoice.setDate(LocalDate.now());
                    serviceInvoice.setMainInvoice(mainInvoice);

                    List<ServiceInvoiceItemModel> serviceItems = new ArrayList<>();
                    ServiceInvoiceItemModel item = new ServiceInvoiceItemModel();

                    // Fetch the actual service from the database
                    ServiceModel service = serviceRepository.findById(serviceId.get(i))
                            .orElseThrow(() -> new RuntimeException("Service not found"));
                    item.setService(service);

                    item.setAmount(amount.get(i));
                    item.setVat(vat != null ? vat : 0.0);

                    // line total = amount + vat
                    double vatAmount = item.getAmount() * item.getVat() / 100;
                    double lineTotal = item.getAmount() + vatAmount;

                    item.setServiceInvoice(serviceInvoice);
                    serviceItems.add(item);

                    serviceInvoice.setServiceInvoiceItems(serviceItems);
                    serviceInvoices.add(serviceInvoice);

                    serviceTotal += lineTotal; // add to service subtotal
                }
            }
        }
        mainInvoice.setServiceInvoices(serviceInvoices);


        // GRAND TOTAL
        mainTotal = productTotal + serviceTotal;
        mainInvoice.setTotalAmount(mainTotal);

        // Save main invoice with cascade
        mainInvoiceService.save(mainInvoice);

        model.addAttribute("mainInvoice", mainInvoice);
        model.addAttribute("productTotal", productTotal); // send to JSP
        model.addAttribute("serviceTotal", serviceTotal); // send to JSP

        return "viewInvoice"; // JSP page
    }

    @GetMapping("/allInvoice")
    public String getAllInvoices(Model model) {
        List<InvoiceModel> invoices = invoiceService.getAllInvoices();
        model.addAttribute("invoices", invoices);
        return "allInvoices";
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

    @PostMapping("/invoice/delete/{id}")
    public String deleteInvoice(@PathVariable Long id) {
        invoiceService.deleteInvoice(id);
        return "redirect:/api/allInvoice";
    }
}
