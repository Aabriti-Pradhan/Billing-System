package com.SimpleProject.SpringCrud.Model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class MainInvoiceModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String invoiceNumber;
    private LocalDate invoiceDate;
    private Double totalAmount = 0.0;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private CustomerModel customer;

    @OneToMany(mappedBy = "mainInvoice", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference("mainInvoice-productInvoices")
    private List<InvoiceModel> productInvoices = new ArrayList<>();

    @OneToMany(mappedBy = "mainInvoice", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference("mainInvoice-serviceInvoices")
    private List<ServiceInvoiceModel> serviceInvoices = new ArrayList<>();

    @PrePersist
    public void generateInvoiceNumber() {
        this.invoiceNumber = "MAIN-" + System.currentTimeMillis();
        this.invoiceDate = LocalDate.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getInvoiceNumber() { return invoiceNumber; }
    public void setInvoiceNumber(String invoiceNumber) { this.invoiceNumber = invoiceNumber; }

    public LocalDate getInvoiceDate() { return invoiceDate; }
    public void setInvoiceDate(LocalDate invoiceDate) { this.invoiceDate = invoiceDate; }

    public Double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }

    public CustomerModel getCustomer() { return customer; }
    public void setCustomer(CustomerModel customer) { this.customer = customer; }

    public List<InvoiceModel> getProductInvoices() { return productInvoices; }
    public void setProductInvoices(List<InvoiceModel> productInvoices) { this.productInvoices = productInvoices; }

    public List<ServiceInvoiceModel> getServiceInvoices() { return serviceInvoices; }
    public void setServiceInvoices(List<ServiceInvoiceModel> serviceInvoices) { this.serviceInvoices = serviceInvoices; }
}
