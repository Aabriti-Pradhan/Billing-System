package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.ServiceInvoiceItemModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServiceInvoiceItemRepository extends JpaRepository<ServiceInvoiceItemModel, Long> {
}
