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

<h1>Invoice: ${invoice.invoiceId}</h1>
<p>Date: ${invoice.invoiceDate}</p>
<p>Customer: ${invoice.customer.name} (ID: ${invoice.customer.customerId})</p>

<!-- ================== PRODUCT ITEMS ================== -->
<c:if test="${not empty invoice.invoiceItems}">
    <h2>Product Items</h2>
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
        <c:set var="productTotal" value="0"/>
        <c:forEach var="pitem" items="${invoice.invoiceItems}">
            <tr>
                <td>${pitem.product.name}</td>
                <td>${pitem.quantity}</td>
                <td>${pitem.product.price}</td>
                <td>
                    <c:set var="lineTotal" value="${pitem.quantity * pitem.product.price}"/>
                    ${lineTotal}
                    <c:set var="productTotal" value="${productTotal + lineTotal}"/>
                </td>
            </tr>
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

<!-- ================== SERVICE ITEMS ================== -->
<c:if test="${not empty invoice.serviceInvoiceItems}">
    <h2>Service Items</h2>
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
        <c:set var="serviceTotal" value="0"/>
        <c:forEach var="sitem" items="${invoice.serviceInvoiceItems}">
            <tr>
                <td>${sitem.service.serviceName}</td>
                <td>${sitem.amount}</td>
                <td>${sitem.vat}</td>
                <td>
                    <c:set var="lineTotal" value="${sitem.amount + (sitem.amount * sitem.vat / 100)}"/>
                    ${lineTotal}
                    <c:set var="serviceTotal" value="${serviceTotal + lineTotal}"/>
                </td>
            </tr>
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

<!-- ================== GRAND TOTAL ================== -->
<h2>
    Grand Total:
    <c:out value="${(productTotal != null ? productTotal : 0) + (serviceTotal != null ? serviceTotal : 0)}"/>
</h2>

</body>
</html>
