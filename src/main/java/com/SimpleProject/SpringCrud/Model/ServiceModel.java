package com.SimpleProject.SpringCrud.Model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "services")
public class ServiceModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long serviceId;

    private String serviceName;

    @Column(nullable = false)
    private Double amount;

    private Double baseAmount; // optional

    @OneToMany(mappedBy = "service")
    @JsonManagedReference("service-invoice-items")
    private List<ServiceInvoiceItemModel> serviceInvoiceItems;

    public Long getServiceId() {
        return serviceId;
    }

    public void setServiceId(Long serviceId) {
        this.serviceId = serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public double getBaseAmount() {
        return baseAmount;
    }

    public void setBaseAmount(double baseAmount) {
        this.baseAmount = baseAmount;
    }

    public List<ServiceInvoiceItemModel> getServiceInvoiceItems() {
        return serviceInvoiceItems;
    }

    public void setServiceInvoiceItems(List<ServiceInvoiceItemModel> serviceInvoiceItems) {
        this.serviceInvoiceItems = serviceInvoiceItems;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public void setBaseAmount(Double baseAmount) {
        this.baseAmount = baseAmount;
    }
}
