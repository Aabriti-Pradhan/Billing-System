<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Invoice</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background-color: #F7F4EA; padding: 20px; }
        h1, h2 { color: #2F3E2F; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #A8BBA3; color: #2F3E2F; }
        tfoot td { font-weight: bold; }
    </style>
</head>
<body>

<h1>Invoice</h1>

<c:set var="productTotal" value="0"/>
<c:set var="serviceTotal" value="0"/>

<!-- ========== PRODUCT INVOICE ========== -->
<c:if test="${not empty invoice}">
    <h2>Product Invoice: ${invoice.invoiceId}</h2>
    <p>Date: ${invoice.invoiceDate}</p>
    <p>Customer: ${invoice.customer.name} (ID: ${invoice.customer.customerId})</p>

    <c:if test="${not empty invoice.invoiceItems}">
        <h3>Product Items</h3>
        <table>
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Unit Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="pitem" items="${invoice.invoiceItems}">
                    <c:set var="lineTotal" value="${pitem.quantity * pitem.product.price}"/>
                    <tr>
                        <td>${pitem.product.name}</td>
                        <td>${pitem.quantity}</td>
                        <td>${pitem.product.price}</td>
                        <td>${lineTotal}</td>
                    </tr>
                    <c:set var="productTotal" value="${productTotal + lineTotal}"/>
                </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3">Product Total</td>
                    <td>${productTotal}</td>
                </tr>
            </tfoot>
        </table>
    </c:if>
</c:if>

<!-- ========== SERVICE INVOICE ========== -->
<c:if test="${not empty serviceInvoice}">
    <h2>Service Invoice: ${serviceInvoice.invoiceNumber}</h2>
    <p>Date: ${serviceInvoice.date}</p>
    <p>Customer: ${serviceInvoice.customer.name} (ID: ${serviceInvoice.customer.customerId})</p>

    <c:if test="${not empty serviceInvoice.serviceInvoiceItems}">
        <h3>Service Items</h3>
        <table>
            <thead>
                <tr>
                    <th>Service Name</th>
                    <th>Amount</th>
                    <th>VAT (%)</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="sitem" items="${serviceInvoice.serviceInvoiceItems}">
                    <c:set var="lineTotal" value="${sitem.amount + (sitem.amount * sitem.vat / 100)}"/>
                    <tr>
                        <td>${sitem.service.serviceName}</td>
                        <td>${sitem.amount}</td>
                        <td>${sitem.vat}</td>
                        <td>${lineTotal}</td>
                    </tr>
                    <c:set var="serviceTotal" value="${serviceTotal + lineTotal}"/>
                </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3">Service Total</td>
                    <td>${serviceTotal}</td>
                </tr>
            </tfoot>
        </table>
    </c:if>
</c:if>

<!-- ========== GRAND TOTAL (Rounded Up) ========== -->
<c:set var="grandTotal" value="${productTotal + serviceTotal}" />
<c:set var="grandTotalRounded" value="${(grandTotal + 0.9999) div 1}" />
<h2>Grand Total: ${grandTotalRounded}</h2>

</body>
</html>
