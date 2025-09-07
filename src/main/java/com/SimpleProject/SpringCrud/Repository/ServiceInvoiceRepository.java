package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.ServiceInvoiceModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServiceInvoiceRepository extends JpaRepository<ServiceInvoiceModel, Long> {
}