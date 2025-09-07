package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.InvoiceModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;


public interface InvoiceRepository extends JpaRepository<InvoiceModel, Long> {
    List<InvoiceModel> findByCustomerCustomerId(Long customerId);

    Optional<InvoiceModel> findTopByOrderByInvoiceDateDesc();
}
