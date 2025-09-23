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

    @Column(nullable = false)
    private boolean archived = false;

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

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public List<ServiceInvoiceItemModel> getServiceInvoiceItems() {
        return serviceInvoiceItems;
    }

    public void setServiceInvoiceItems(List<ServiceInvoiceItemModel> serviceInvoiceItems) {
        this.serviceInvoiceItems = serviceInvoiceItems;
    }

    public boolean isArchived() {
        return archived;
    }

    public void setArchived(boolean archived) {
        this.archived = archived;
    }
}
