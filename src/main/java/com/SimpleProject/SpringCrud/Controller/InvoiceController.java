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

//    @PostMapping("/createInvoiceForm")
//    @ResponseBody
//    public String createInvoiceForm(
//            @RequestParam Long customerId,
//            @RequestParam double discount,
//            @RequestParam(value="isPercentage", required=false, defaultValue="false") boolean isPercentage,
//            @RequestParam Map<String,String> allParams
//    ) {
//        InvoiceModel invoice = new InvoiceModel();
//        CustomerModel customer = new CustomerModel();
//        customer.setCustomerId(customerId);
//        invoice.setCustomer(customer);
//        invoice.setDiscount(discount);
//        invoice.setPercentage(isPercentage);
//
//        List<InvoiceItemModel> items = new ArrayList<>();
//
//        for (int i = 1; i <= 10; i++) {
//            String productIdStr = allParams.get("productId" + i);
//            String quantityStr = allParams.get("quantity" + i);
//            if (productIdStr != null && !productIdStr.isEmpty() &&
//                    quantityStr != null && !quantityStr.isEmpty()) {
//
//                InvoiceItemModel item = new InvoiceItemModel();
//                ProductModel product = new ProductModel();
//                product.setProductId(Long.parseLong(productIdStr));
//                item.setProduct(product);
//                item.setQuantity(Integer.parseInt(quantityStr));
//                items.add(item);
//            }
//        }
//
//        invoice.setInvoiceItems(items);
//
//        invoiceService.createInvoice(customer, items, discount, isPercentage);
//
//        return "Invoice Created Successfully!";
//    }


    @PostMapping("/createI")
    public InvoiceModel createInvoice(@RequestBody InvoiceModel invoice) {
        return invoiceService.createInvoice(invoice.getCustomer(),
                invoice.getInvoiceItems(),
                invoice.getDiscount(),
                invoice.isPercentage());
    }

    @GetMapping("/allInvoice")
    public String getAllInvoices(Model model) {
        List<InvoiceModel> invoices = invoiceService.getAllInvoices();
        model.addAttribute("invoices", invoices);
        return "allInvoices";
    }

    @GetMapping("/invoice/{id}")
    public InvoiceModel getInvoiceById(@PathVariable Long id) {
        return invoiceService.getInvoiceById(id);
    }

    @DeleteMapping("/invoice/{id}")
    public String deleteInvoice(@PathVariable Long id) {
        invoiceService.deleteInvoice(id);
        return "Invoice deleted successfully";
    }
}
