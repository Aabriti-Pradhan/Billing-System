package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.InvoiceServiceModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InvoiceServiceRepository extends JpaRepository<InvoiceServiceModel, Long> {

    // Fetch services by invoice
    List<InvoiceServiceModel> findByInvoice_InvoiceId(Long invoiceId);

    // Fetch invoices by service
    List<InvoiceServiceModel> findByService_Id(Long serviceId);
}

