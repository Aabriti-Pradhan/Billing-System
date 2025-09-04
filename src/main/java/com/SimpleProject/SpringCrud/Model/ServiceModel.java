package com.SimpleProject.SpringCrud.Model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "services")
public class ServiceModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long service_id;

    private String serviceName;
    private double baseAmount; // optional

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private CustomerModel customer;

    @OneToMany(mappedBy = "service", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<InvoiceServiceModel> invoiceServiceItems = new ArrayList<>();

    // Getters and Setters
    public Long getId() { return service_id; }
    public void setId(Long id) { this.service_id = id; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public double getBaseAmount() { return baseAmount; }
    public void setBaseAmount(double baseAmount) { this.baseAmount = baseAmount; }

    public CustomerModel getCustomer() { return customer; }
    public void setCustomer(CustomerModel customer) { this.customer = customer; }

    public List<InvoiceServiceModel> getInvoiceServiceItems() { return invoiceServiceItems; }
    public void setInvoiceServiceItems(List<InvoiceServiceModel> invoiceServiceItems) { this.invoiceServiceItems = invoiceServiceItems; }
}
