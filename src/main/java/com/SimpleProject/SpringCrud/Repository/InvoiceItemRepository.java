package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.InvoiceItemModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface InvoiceItemRepository extends JpaRepository<InvoiceItemModel, Long> {
    List<InvoiceItemModel> findByInvoiceInvoiceId(Long invoiceId);
}
