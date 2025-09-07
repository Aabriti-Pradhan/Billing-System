package com.SimpleProject.SpringCrud.Model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;

@Entity
@Table(name = "service_invoice_item")
public class ServiceInvoiceItemModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "service_id", nullable = false)
    @JsonBackReference("service-invoice-items")
    private ServiceModel service;

    @ManyToOne
    @JoinColumn(name = "invoice_id", nullable = false)
    @JsonBackReference("invoice-service-items")
    private ServiceInvoiceModel serviceInvoice;

    private Double amount;
    private Double vat;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public ServiceModel getService() {
        return service;
    }

    public void setService(ServiceModel service) {
        this.service = service;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getVat() {
        return vat;
    }

    public void setVat(Double vat) {
        this.vat = vat;
    }

    public ServiceInvoiceModel getServiceInvoice() {
        return serviceInvoice;
    }

    public void setServiceInvoice(ServiceInvoiceModel serviceInvoice) {
        this.serviceInvoice = serviceInvoice;
    }


}
