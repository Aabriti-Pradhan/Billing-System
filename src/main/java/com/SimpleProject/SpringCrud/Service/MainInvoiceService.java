package com.SimpleProject.SpringCrud.Service;

import com.SimpleProject.SpringCrud.Model.MainInvoiceModel;
import com.SimpleProject.SpringCrud.Repository.MainInvoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MainInvoiceService {

    @Autowired
    private MainInvoiceRepository mainInvoiceRepository;

    // Save a main invoice (cascades to products, services, and items)
    public MainInvoiceModel save(MainInvoiceModel mainInvoice) {
        return mainInvoiceRepository.save(mainInvoice);
    }

    // Get all main invoices
    public List<MainInvoiceModel> getAllInvoices() {
        return mainInvoiceRepository.findAll();
    }

    // Get a single main invoice by ID
    public MainInvoiceModel getInvoiceById(Long id) {
        Optional<MainInvoiceModel> invoice = mainInvoiceRepository.findById(id);
        return invoice.orElseThrow(() -> new RuntimeException("Main invoice not found"));
    }

    // Delete a main invoice by ID
    public void deleteInvoice(Long id) {
        if (!mainInvoiceRepository.existsById(id)) {
            throw new RuntimeException("Main invoice not found");
        }
        mainInvoiceRepository.deleteById(id);
    }

    // Optional: Update can be added if needed
    public MainInvoiceModel updateInvoice(MainInvoiceModel updatedInvoice) {
        if (updatedInvoice.getId() == null || !mainInvoiceRepository.existsById(updatedInvoice.getId())) {
            throw new RuntimeException("Main invoice not found for update");
        }
        return mainInvoiceRepository.save(updatedInvoice);
    }
}
