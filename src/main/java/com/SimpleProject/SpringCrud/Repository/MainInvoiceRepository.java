package com.SimpleProject.SpringCrud.Repository;

import com.SimpleProject.SpringCrud.Model.MainInvoiceModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MainInvoiceRepository extends JpaRepository<MainInvoiceModel, Long> {
    @Query("SELECT m FROM MainInvoiceModel m " +
            "WHERE LOWER(m.invoiceNumber) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "   OR STR(m.totalAmount) LIKE CONCAT('%', :keyword, '%') " +
            "   OR STR(m.invoiceDate) LIKE CONCAT('%', :keyword, '%')")
    List<MainInvoiceModel> searchInvoices(String keyword);
}
