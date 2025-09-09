package com.SimpleProject.SpringCrud.Model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Data

@Entity
@Table(name = "service_invoice")
public class ServiceInvoiceModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long invoiceId;

    private String invoiceNumber;
    private LocalDate date;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    @JsonBackReference("customer-service-invoice")
    private CustomerModel customer;

    @ManyToOne
    @JoinColumn(name = "main_invoice_id")
    @JsonBackReference("mainInvoice-serviceInvoices")
    private MainInvoiceModel mainInvoice;

    @OneToMany(mappedBy = "serviceInvoice", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference("invoice-service-items")
    private List<ServiceInvoiceItemModel> serviceInvoiceItems = new ArrayList<>();

    @PrePersist
    public void generateInvoiceNumber() {
        this.invoiceNumber = "INV-" + System.currentTimeMillis();
        if (this.date == null) this.date = LocalDate.now();
    }
}
