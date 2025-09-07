package com.SimpleProject.SpringCrud.Model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "service_invoice")
public class ServiceInvoiceModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long invoiceId;

    private String invoiceNumber;
    private LocalDate date;

    @OneToMany(mappedBy = "serviceInvoice", cascade = CascadeType.ALL)
    @JsonManagedReference("invoice-service-items")
    private List<ServiceInvoiceItemModel> serviceInvoiceItems;

    public Long getInvoiceId() {
        return invoiceId;
    }

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    @JsonBackReference("customer-service-invoice")
    private CustomerModel customer;

    @PrePersist
    public void generateInvoiceNumber() {
        this.invoiceNumber = "INV-" + System.currentTimeMillis();
    }

    public void setInvoiceId(Long invoiceId) {
        this.invoiceId = invoiceId;
    }

    public String getInvoiceNumber() {
        return invoiceNumber;
    }

    public void setInvoiceNumber(String invoiceNumber) {
        this.invoiceNumber = invoiceNumber;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public List<ServiceInvoiceItemModel> getServiceInvoiceItems() {
        return serviceInvoiceItems;
    }

    public void setServiceInvoiceItems(List<ServiceInvoiceItemModel> serviceInvoiceItems) {
        this.serviceInvoiceItems = serviceInvoiceItems;
    }

    public CustomerModel getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerModel customer) {
        this.customer = customer;
    }


}

