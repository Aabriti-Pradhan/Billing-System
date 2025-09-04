package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.*;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import com.SimpleProject.SpringCrud.Repository.InvoiceRepository;
import com.SimpleProject.SpringCrud.Repository.InvoiceServiceRepository;
import com.SimpleProject.SpringCrud.Repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class ServiceService {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private ServiceRepository serviceRepository;

    @Autowired
    private InvoiceServiceRepository invoiceServiceRepository;

    @Autowired
    private InvoiceRepository invoiceRepository;

    public void saveService(Long customerId, List<String> serviceNames, List<Double> serviceAmounts, List<Double> serviceVats) {

        CustomerModel customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        // Create invoice
        InvoiceModel invoice = new InvoiceModel();
        invoice.setCustomer(customer);
        invoice.setInvoiceDate(LocalDate.now());
        invoiceRepository.save(invoice);

        // Loop through all service rows from form
        for (int i = 0; i < serviceNames.size(); i++) {
            String name = serviceNames.get(i);
            Double amount = serviceAmounts.get(i);
            Double vat = serviceVats.get(i);

            // Save service first
            ServiceModel service = new ServiceModel();
            service.setServiceName(name);
            service.setBaseAmount(amount);
            service.setCustomer(customer);
            serviceRepository.save(service);

            // Link service to invoice
            InvoiceServiceModel invoiceService = new InvoiceServiceModel();
            invoiceService.setInvoice(invoice);
            invoiceService.setService(service);
            invoiceService.setAmount(amount);
            invoiceService.setVat(vat);

            invoiceServiceRepository.save(invoiceService);
        }

        // Optionally, calculate total amount on invoice
        double total = serviceAmounts.stream().mapToDouble(Double::doubleValue).sum();
        invoice.setTotalAmount(total);
        invoiceRepository.save(invoice);
    }
}
