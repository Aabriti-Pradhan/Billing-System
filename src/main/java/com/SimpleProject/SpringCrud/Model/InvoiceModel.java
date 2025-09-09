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
public class InvoiceModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long invoiceId;

    private LocalDate invoiceDate;
    private Double totalAmount = 0.0;
    private double discount;
    private boolean isPercentage;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    @JsonBackReference("customer-invoice")
    private CustomerModel customer;

    @ManyToOne
    @JoinColumn(name = "main_invoice_id")
    @JsonBackReference("mainInvoice-productInvoices")
    private MainInvoiceModel mainInvoice;

    @OneToMany(mappedBy = "invoice", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference("invoice-invoiceItem")
    private List<InvoiceItemModel> invoiceItems = new ArrayList<>();
}
