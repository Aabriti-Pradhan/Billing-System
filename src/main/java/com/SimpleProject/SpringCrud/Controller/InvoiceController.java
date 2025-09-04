package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.InvoiceItemModel;
import com.SimpleProject.SpringCrud.Model.InvoiceModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Service.InvoiceService;
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

    @PostMapping("/createIForm")
    public String createInvoiceFromForm(
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

        invoiceService.createInvoice(customer, items, discount, isPercentage);

        return "redirect:/api/allInvoice";
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

}
