package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.InvoiceItemModel;
import com.SimpleProject.SpringCrud.Model.MainInvoiceModel;
import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Model.ServiceInvoiceItemModel;
import com.SimpleProject.SpringCrud.Service.MainInvoiceService;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.stream.Stream;

@Controller
public class InvoicePdfController {

    private final MainInvoiceService mainInvoiceService;

    public InvoicePdfController(MainInvoiceService mainInvoiceService) {
        this.mainInvoiceService = mainInvoiceService;
    }

    @GetMapping("/invoices/pdf/{id}")
    public void exportInvoiceToPdf(@PathVariable("id") Long id, HttpServletResponse response) throws Exception {

        MainInvoiceModel invoice = mainInvoiceService.getInvoiceById(id);
        if (invoice == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invoice not found");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=invoice_" + id + ".pdf");

        Document document = new Document(PageSize.A4, 36, 36, 36, 36);
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.DARK_GRAY);
        Paragraph title = new Paragraph("Invoice Details", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));

        // Customer Info
        Font sectionFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
        document.add(new Paragraph("Customer Details", sectionFont));
        document.add(new Paragraph("Name: " + invoice.getCustomer().getName()));
        document.add(new Paragraph("Email: " + invoice.getCustomer().getEmail()));
        document.add(new Paragraph("Phone: " + invoice.getCustomer().getPhone()));
        document.add(new Paragraph(" "));

        // Invoice Info
        document.add(new Paragraph("Invoice Number: " + invoice.getInvoiceNumber()));
        document.add(new Paragraph("Invoice Date: " + invoice.getInvoiceDate()));
        document.add(new Paragraph(" "));

        // ---------------- PRODUCTS TABLE ----------------
        if (!invoice.getProductInvoices().isEmpty()) {
            PdfPTable productTable = new PdfPTable(5);
            productTable.setWidthPercentage(100);
            productTable.setWidths(new int[]{1, 4, 2, 2, 2});

            Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE);
            Stream.of("S.No", "Product", "Unit Price", "Quantity", "Line Total").forEach(column -> {
                PdfPCell header = new PdfPCell();
                header.setBackgroundColor(new BaseColor(168, 187, 163));
                header.setPhrase(new Phrase(column, headFont));
                header.setHorizontalAlignment(Element.ALIGN_CENTER);
                header.setPadding(5);
                productTable.addCell(header);
            });

            int count = 1;
            double productsTotal = 0.0;
            for (var prodInvoice : invoice.getProductInvoices()) {
                for (InvoiceItemModel item : prodInvoice.getInvoiceItems()) {
                    productTable.addCell(String.valueOf(count++));
                    productTable.addCell(item.getProduct().getName());
                    productTable.addCell(String.format("%.2f", item.getUnitPrice()));
                    productTable.addCell(String.valueOf(item.getQuantity()));
                    productTable.addCell(String.format("%.2f", item.getSubtotal()));
                    productsTotal += item.getSubtotal();
                }
                // Product invoice total
                PdfPCell totalCell = new PdfPCell(new Phrase("Products Total"));
                totalCell.setColspan(4);
                totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                productTable.addCell(totalCell);
                productTable.addCell(String.format("%.2f", prodInvoice.getTotalAmount()));
            }
            document.add(new Paragraph("Products:", sectionFont));
            document.add(productTable);
            document.add(new Paragraph(" "));
        }

        // ---------------- SERVICES TABLE ----------------
        if (!invoice.getServiceInvoices().isEmpty()) {
            PdfPTable serviceTable = new PdfPTable(5);
            serviceTable.setWidthPercentage(100);
            serviceTable.setWidths(new int[]{1, 4, 2, 2, 2});

            Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE);
            Stream.of("S.No", "Service", "Amount", "VAT %", "Line Total").forEach(column -> {
                PdfPCell header = new PdfPCell();
                header.setBackgroundColor(new BaseColor(168, 187, 163));
                header.setPhrase(new Phrase(column, headFont));
                header.setHorizontalAlignment(Element.ALIGN_CENTER);
                header.setPadding(5);
                serviceTable.addCell(header);
            });

            int count = 1;
            double servicesTotal = 0.0;
            for (var servInvoice : invoice.getServiceInvoices()) {
                for (ServiceInvoiceItemModel item : servInvoice.getServiceInvoiceItems()) {
                    serviceTable.addCell(String.valueOf(count++));
                    serviceTable.addCell(item.getService().getServiceName());
                    serviceTable.addCell(String.format("%.2f", item.getAmount()));
                    serviceTable.addCell(String.valueOf(item.getVat()));
                    double lineTotal = item.getAmount() + (item.getAmount() * item.getVat() / 100);
                    serviceTable.addCell(String.format("%.2f", lineTotal));
                    servicesTotal += lineTotal;
                }
            }
            document.add(new Paragraph("Services:", sectionFont));
            document.add(serviceTable);
            document.add(new Paragraph(" "));
        }

        // ---------------- GRAND TOTAL ----------------
        PdfPTable totalTable = new PdfPTable(2);
        totalTable.setWidthPercentage(40);
        totalTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
        totalTable.setSpacingBefore(10f);

        PdfPCell labelCell = new PdfPCell(new Phrase("Grand Total"));
        labelCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        labelCell.setBackgroundColor(new BaseColor(255, 213, 128));
        totalTable.addCell(labelCell);

        PdfPCell valueCell = new PdfPCell(new Phrase(String.format("%.2f", invoice.getTotalAmount())));
        valueCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        valueCell.setBackgroundColor(new BaseColor(255, 213, 128));
        totalTable.addCell(valueCell);

        document.add(totalTable);

        document.close();
    }
}
