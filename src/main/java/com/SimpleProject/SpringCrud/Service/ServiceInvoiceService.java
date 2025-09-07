package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.*;
import com.SimpleProject.SpringCrud.Repository.CustomerRepository;
import com.SimpleProject.SpringCrud.Repository.ServiceInvoiceRepository;
import com.SimpleProject.SpringCrud.Repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class ServiceInvoiceService {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private ServiceRepository serviceRepository;

    @Autowired
    private ServiceInvoiceRepository serviceInvoiceRepository;

    public ServiceInvoiceModel createInvoice(Long customerId, List<Long> serviceIds, List<Double> amounts, Double vat) {

        CustomerModel customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        ServiceInvoiceModel invoice = new ServiceInvoiceModel();
        invoice.setCustomer(customer);
        invoice.setDate(LocalDate.now());

        List<ServiceInvoiceItemModel> items = new ArrayList<>();

        for (int i = 0; i < serviceIds.size(); i++) {
            Long serviceId = serviceIds.get(i);
            Double amount = amounts.get(i) != null ? amounts.get(i) : 0.0;

            ServiceModel service = serviceRepository.findById(serviceId)
                    .orElseThrow(() -> new RuntimeException("Service not found"));

            ServiceInvoiceItemModel item = new ServiceInvoiceItemModel();
            item.setService(service);
            item.setServiceInvoice(invoice);
            item.setAmount(amount);
            item.setVat(vat != null ? vat : 0.0);

            items.add(item);
        }

        invoice.setServiceInvoiceItems(items);

        return serviceInvoiceRepository.save(invoice);
    }


    public List<ServiceModel> getAllServices() {
        return serviceRepository.findAll();
    }
}
