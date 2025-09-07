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

import java.math.BigDecimal;
import java.math.RoundingMode;
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
        invoice.setDiscount(discount);
        invoice.setPercentage(isPercentage);

        // apply discount
        double finalTotal = isPercentage ? subtotal - (subtotal * discount / 100) : subtotal - discount;

        // round to 2 decimal places
        BigDecimal roundedTotal = BigDecimal.valueOf(finalTotal).setScale(2, RoundingMode.HALF_UP);
        invoice.setTotalAmount(roundedTotal.doubleValue());

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

    public InvoiceModel updateInvoice(Long id, CustomerModel customer, List<InvoiceItemModel> newItems,
                                      double discount, boolean isPercentage) {

        InvoiceModel existingInvoice = invoiceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Invoice not found"));

        for (InvoiceItemModel oldItem : existingInvoice.getInvoiceItems()) {
            ProductModel product = oldItem.getProduct();
            product.setStockQuantity(product.getStockQuantity() + oldItem.getQuantity());
            productRepo.save(product);

            invoiceItemRepository.delete(oldItem); // remove old items
        }

        // update invoice
        existingInvoice.setCustomer(customer);
        existingInvoice.setInvoiceDate(LocalDate.now()); // or keep old date
        existingInvoice.setDiscount(discount);
        existingInvoice.setPercentage(isPercentage);

        double subtotal = 0.0;
        for (InvoiceItemModel newItem : newItems) {
            ProductModel product = productRepo.findById(newItem.getProduct().getProductId())
                    .orElseThrow(() -> new RuntimeException("Product not found"));

            newItem.setUnitPrice(product.getPrice());
            newItem.setSubtotal(newItem.getQuantity() * product.getPrice());
            newItem.setInvoice(existingInvoice);
            subtotal += newItem.getSubtotal();

            // decrease stock
            product.setStockQuantity(product.getStockQuantity() - newItem.getQuantity());
            productRepo.save(product);
        }

        // recalc total
        double finalTotal = isPercentage ? subtotal - (subtotal * discount / 100) : subtotal - discount;

        // round to 2 decimal places
        BigDecimal roundedTotal = BigDecimal.valueOf(finalTotal).setScale(2, RoundingMode.HALF_UP);
        existingInvoice.setTotalAmount(roundedTotal.doubleValue());

        existingInvoice.setInvoiceItems(newItems);

        InvoiceModel savedInvoice = invoiceRepository.save(existingInvoice);

        for (InvoiceItemModel item : newItems) {
            invoiceItemRepository.save(item);
        }

        return savedInvoice;
    }

    public void deleteInvoice(Long id) {
        InvoiceModel invoice = invoiceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Invoice not found"));

        for (InvoiceItemModel item : invoice.getInvoiceItems()) {
            ProductModel product = item.getProduct();
            product.setStockQuantity(product.getStockQuantity() + item.getQuantity());
            productRepo.save(product);
        }

        invoiceRepository.delete(invoice);
    }

    public List<InvoiceModel> getAllCustomers() {
        return invoiceRepository.findAll();
    }

    public InvoiceModel getLatestInvoice() {
        return invoiceRepository.findTopByOrderByInvoiceDateDesc()
                .orElse(null);
    }

}
