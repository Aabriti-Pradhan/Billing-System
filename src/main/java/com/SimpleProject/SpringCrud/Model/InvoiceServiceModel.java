package com.SimpleProject.SpringCrud.Model;

import jakarta.persistence.*;

@Entity
public class InvoiceServiceModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "invoice_id")
    private InvoiceModel invoice;

    @ManyToOne
    @JoinColumn(name = "service_id")
    private ServiceModel service;

    private double amount;
    private double vat;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public InvoiceModel getInvoice() { return invoice; }
    public void setInvoice(InvoiceModel invoice) { this.invoice = invoice; }

    public ServiceModel getService() { return service; }
    public void setService(ServiceModel service) { this.service = service; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public double getVat() { return vat; }
    public void setVat(double vat) { this.vat = vat; }
}
