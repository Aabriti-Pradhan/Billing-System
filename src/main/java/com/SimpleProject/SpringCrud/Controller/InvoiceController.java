package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.InvoiceModel;
import com.SimpleProject.SpringCrud.Service.InvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")

public class InvoiceController {

    @Autowired
    private InvoiceService invoiceService;

    @PostMapping("/createI")
    public InvoiceModel createInvoice(@RequestBody InvoiceModel invoice) {
        return invoiceService.createInvoice(invoice.getCustomer(),
                invoice.getInvoiceItems(),
                invoice.getDiscount(),
                invoice.isPercentage());
    }

    @GetMapping("/allInvoice")
    public List<InvoiceModel> getAllInvoices() {
        return invoiceService.getAllInvoices();
    }

    @GetMapping("/invoice/{id}")
    public InvoiceModel getInvoiceById(@PathVariable Long id) {
        return invoiceService.getInvoiceById(id);
    }
}
