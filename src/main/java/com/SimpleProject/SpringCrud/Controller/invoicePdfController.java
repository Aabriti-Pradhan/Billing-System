package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Model.InvoiceModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
import com.SimpleProject.SpringCrud.Service.InvoiceService;
import com.itextpdf.text.*;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.awt.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Stream;

@Controller

public class invoicePdfController {

    @Autowired
    private final InvoiceService invoiceService;

    public invoicePdfController(InvoiceService invoiceService) {
        this.invoiceService = invoiceService;
    }

    @GetMapping("/invoices/pdf/{id}")
    public void exportSingleInvoiceToPdf(@PathVariable("id") Long id,
                                         HttpServletResponse response)
            throws IOException, DocumentException {

        InvoiceModel invoice = invoiceService.getInvoiceById(id);
        if (invoice == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invoice not found");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=invoice_" + id + ".pdf");

        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Title
        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.DARK_GRAY);
        Paragraph title = new Paragraph("Invoice Details", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));

        // Customer info
        Font sectionFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
        document.add(new Paragraph("Customer Details", sectionFont));
        document.add(new Paragraph("Name: " + invoice.getCustomer().getName()));
        document.add(new Paragraph("Email: " + invoice.getCustomer().getEmail()));
        document.add(new Paragraph("Phone: " + invoice.getCustomer().getPhone()));
        document.add(new Paragraph(" "));

        // Invoice info
        document.add(new Paragraph("Invoice ID: " + invoice.getInvoiceId()));
        document.add(new Paragraph("Date: " + invoice.getInvoiceDate()));
        document.add(new Paragraph(" "));

        // Items table
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setWidths(new int[]{4, 2, 2, 2});

        Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE);
        Stream.of("Product", "Price", "Quantity", "Line Total").forEach(columnTitle -> {
            PdfPCell header = new PdfPCell();
            header.setBackgroundColor(new BaseColor(168, 187, 163));
            header.setPhrase(new Phrase(columnTitle, headFont));
            header.setHorizontalAlignment(Element.ALIGN_CENTER);
            header.setPadding(8);
            table.addCell(header);
        });

        double subTotal = 0.0;
        for (var item : invoice.getInvoiceItems()) {
            table.addCell(item.getProduct().getName());
            table.addCell(String.format("%.2f", item.getUnitPrice()));
            table.addCell(String.valueOf(item.getQuantity()));
            table.addCell(String.format("%.2f", item.getSubtotal()));
            subTotal += item.getSubtotal();
        }

        // Subtotal row
        PdfPCell cell = new PdfPCell(new Phrase("Subtotal"));
        cell.setColspan(3);
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(cell);
        table.addCell(String.format("%.2f", subTotal));

        // Discount row
        cell = new PdfPCell(new Phrase("Discount (" +
                (invoice.isPercentage() ? invoice.getDiscount() + "%" : "Flat") + ")"));
        cell.setColspan(3);
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(cell);
        table.addCell(String.format("%.2f", subTotal - invoice.getTotalAmount()));

        // Total row
        cell = new PdfPCell(new Phrase("Total Amount"));
        cell.setColspan(3);
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(cell);
        table.addCell(String.format("%.2f", invoice.getTotalAmount()));

        document.add(table);

        document.close();
    }

}
