package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.DTO.CustomerDropdownDTO;
import com.SimpleProject.SpringCrud.DTO.ProductDropdownDTO;
import com.SimpleProject.SpringCrud.Model.*;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import com.SimpleProject.SpringCrud.Repository.ProductRepository;
import com.SimpleProject.SpringCrud.Repository.ServiceRepository;
import com.SimpleProject.SpringCrud.Service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

    @Autowired
    private CustomerService customerService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ServiceInvoiceService serviceInvoiceService;

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

        try {
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
            mainTotal = Math.ceil(mainTotal);
            mainInvoice.setTotalAmount(mainTotal);

            // Save main invoice with cascade
            mainInvoiceService.save(mainInvoice);

            model.addAttribute("mainInvoice", mainInvoice);
            model.addAttribute("productTotal", productTotal); // send to JSP
            model.addAttribute("serviceTotal", serviceTotal); // send to JSP

            return "viewInvoice"; // JSP page
        }
        catch (org.springframework.dao.DataIntegrityViolationException ex) {
            // This catches database-level unique constraint violations
            model.addAttribute("toastMessage", "ID or unique field already exists in the database!");
            model.addAttribute("toastType", "danger");

            return "allInvoices"; // stay on same page with toast
        }
    }

    @GetMapping("/allInvoice")
    public String getAllInvoices(@RequestParam(value = "showArchived", required = false) Boolean showArchived,
                                 @RequestParam(value = "sortField", defaultValue = "invoiceDate") String sortField,
                                 @RequestParam(value = "sortDir", defaultValue = "asc") String sortDir,
                                 Model model) {
        List<MainInvoiceModel> invoices = mainInvoiceService.getAllInvoices(sortField, sortDir);

        // If showArchived is null or false, filter archived invoices
        if (showArchived == null || !showArchived) {
            invoices = invoices.stream()
                    .filter(inv -> !inv.isArchived())
                    .toList();
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d MMMM, yyyy"); // 9 September, 2025

        // Populate formatted date
        for (MainInvoiceModel inv : invoices) {
            if (inv.getInvoiceDate() != null) {
                inv.setFormattedInvoiceDate(inv.getInvoiceDate().format(formatter));
            }
        }

        model.addAttribute("customers", customerService.getAllCustomers());
        model.addAttribute("products", productService.getAllProducts());
        model.addAttribute("services", serviceInvoiceService.getAllServices());

        model.addAttribute("invoices", invoices);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);
        return "allInvoices";
    }

    @PostMapping("/archive")
    @ResponseBody
    public ResponseEntity<String> archiveInvoices(@RequestBody List<Long> ids) {
        try {
            for(Long id : ids) {
                MainInvoiceModel invoice = mainInvoiceService.getInvoiceById(id);
                if(invoice != null) {
                    invoice.setArchived(true);
                    mainInvoiceService.saveInvoice(invoice); // or update
                }
            }
            return ResponseEntity.ok("Invoices archived successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error archiving invoices");
        }
    }

    @PostMapping("/unarchive")
    @ResponseBody
    public ResponseEntity<String> unarchiveInvoices(@RequestBody List<Long> ids) {
        mainInvoiceService.unarchiveInvoices(ids);
        return ResponseEntity.ok("Unarchived Successfully!");
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
        mainInvoiceService.deleteInvoice(id);
        return "redirect:/api/allInvoice";
    }

    @GetMapping("/invoice/view/{id}")
    public String viewInvoice(@PathVariable Long id, Model model) {
        MainInvoiceModel mainInvoice = mainInvoiceService.getInvoiceById(id);

        // product total = sum of each InvoiceModel.totalAmount
        double productTotal = mainInvoice.getProductInvoices().stream()
                .mapToDouble(InvoiceModel::getTotalAmount)
                .sum();

        // service total = mainTotal - productTotal (since you saved mainTotal already)
        double serviceTotal = mainInvoice.getTotalAmount() - productTotal;

        // Format invoice date as string
        if (mainInvoice.getInvoiceDate() != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d MMMM, yyyy"); // 9 September, 2025
            mainInvoice.setFormattedInvoiceDate(mainInvoice.getInvoiceDate().format(formatter));
        }

        model.addAttribute("mainInvoice", mainInvoice);
        model.addAttribute("productTotal", productTotal);
        model.addAttribute("serviceTotal", serviceTotal);

        return "viewInvoice";
    }

    @GetMapping("/invoices/search")
    public String searchInvoices(@RequestParam("keyword") String keyword, Model model) {
        List<MainInvoiceModel> invoices = mainInvoiceService.searchInvoices(keyword);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d MMMM, yyyy");
        for (MainInvoiceModel inv : invoices) {
            if (inv.getInvoiceDate() != null) {
                inv.setFormattedInvoiceDate(inv.getInvoiceDate().format(formatter));
            }
        }

        model.addAttribute("invoices", invoices);
        model.addAttribute("keyword", keyword);

        model.addAttribute("sortField", "invoiceDate");
        model.addAttribute("sortDir", "asc");

        return "allInvoices";
    }



}
