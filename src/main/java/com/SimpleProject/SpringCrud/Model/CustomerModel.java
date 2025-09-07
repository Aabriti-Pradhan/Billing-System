package com.SimpleProject.SpringCrud.Model;


import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "Customer")

public class CustomerModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long customerId;

    private String name;
    private String email;
    private String phone;
    private String address;

    @OneToMany(mappedBy = "customer")
    @JsonManagedReference("customer-invoice")
    private List<InvoiceModel> invoices;

    @OneToMany(mappedBy = "customer", cascade = CascadeType.ALL)
    @JsonManagedReference("customer-service-invoice")
    private List<ServiceInvoiceModel> serviceInvoices;


    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<InvoiceModel> getInvoices() {
        return invoices;
    }

    public void setInvoices(List<InvoiceModel> invoices) {
        this.invoices = invoices;
    }

    public List<ServiceInvoiceModel> getServiceInvoices() {
        return serviceInvoices;
    }

    public void setServiceInvoices(List<ServiceInvoiceModel> serviceInvoices) {
        this.serviceInvoices = serviceInvoices;
    }
}
