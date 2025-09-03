package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.InvoiceItemModel;
import com.SimpleProject.SpringCrud.Model.InvoiceModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Repository.InvoiceItemRepository;
import com.SimpleProject.SpringCrud.Repository.InvoiceRepository;
import com.SimpleProject.SpringCrud.Repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service

public class InvoiceService {

    @Autowired
    private InvoiceRepository invoiceRepository;

    @Autowired
    private InvoiceItemRepository invoiceItemRepository;

    @Autowired
    private ProductRepository productRepo;

    public InvoiceModel createInvoice(CustomerModel customer, List<InvoiceItemModel> items,
                                      double discount, boolean isPercentage) {

        InvoiceModel invoice = new InvoiceModel();
        invoice.setCustomer(customer);
        invoice.setInvoiceDate(LocalDate.now());

        double subtotal = 0.0;
        for (InvoiceItemModel item : items) {
            ProductModel product = productRepo.findById(item.getProduct().getProductId())
                    .orElseThrow(() -> new RuntimeException("Product not found"));
            item.setUnitPrice(product.getPrice());
            item.setSubtotal(item.getQuantity() * product.getPrice());
            item.setInvoice(invoice);
            subtotal += item.getSubtotal();

            // decrease stock
            product.setStockQuantity(product.getStockQuantity() - item.getQuantity());
            productRepo.save(product);
        }

        invoice.setInvoiceItems(items);
        invoice.setTotalAmount(subtotal);
        invoice.setDiscount(discount);
        invoice.setPercentage(isPercentage);

        // apply discount
        double finalTotal = isPercentage ? subtotal - (subtotal * discount / 100) : subtotal - discount;
        invoice.setTotalAmount(finalTotal);

        InvoiceModel savedInvoice = invoiceRepository.save(invoice);

        for (InvoiceItemModel item : invoice.getInvoiceItems()) {
            item.setInvoice(savedInvoice);
            item.setSubtotal(item.getQuantity() * item.getUnitPrice());
            invoiceItemRepository.save(item);
        }

        return savedInvoice;
    }

    public List<InvoiceModel> getAllInvoices() {

        return invoiceRepository.findAll();
    }

    public InvoiceModel getInvoiceById(Long id) {

        return invoiceRepository.findById(id).orElse(null);
    }

    public void deleteInvoice(Long id) {
        invoiceRepository.deleteById(id);
    }
}
