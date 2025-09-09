package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.MainInvoiceModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MainInvoiceRepository extends JpaRepository<MainInvoiceModel, Long> {
    // You can add custom query methods here if needed in the future
}
