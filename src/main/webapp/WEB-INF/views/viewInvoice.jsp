<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Invoice Details</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background-color: #F7F4EA; margin: 0; padding: 0; }
        .content { padding: 20px 180px; margin-top:-210px }
        .header { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .customer-info { text-align: left; }
        .date-info { text-align: right; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: center; }
        th { background-color: #A8BBA3; color: #2F3E2F; }
        tr:nth-child(even) { background-color: #EFF5D2; }
        tr:hover { background-color: #FFF0CE; }
        .total-row { font-weight: bold; background-color: #FFD580; }
        .total-row-gramd { font-weight: bold; background-color: #415E72; }
        .back-link { display: inline-block; margin-top: 20px; padding: 10px 18px; background-color: #A8BBA3; color: #2F3E2F; text-decoration: none; border-radius: 8px; font-weight: bold; }
        .back-link:hover { background-color: #FFF0CE; }
    </style>
</head>
<body>
<jsp:include page="home.jsp"/>

<div class="content">
    <div class="header">
        <div class="customer-info">
            <h2>Customer Details</h2>
            <p><b>Name:</b> ${mainInvoice.customer.name}</p>
            <p><b>Email:</b> ${mainInvoice.customer.email}</p>
            <p><b>Phone:</b> ${mainInvoice.customer.phone}</p>
        </div>
        <div class="date-info">
            <h2>Invoice</h2>
            <p><b>Date:</b> ${mainInvoice.formattedInvoiceDate}</p>
            <p><b>Invoice #:</b> ${mainInvoice.invoiceNumber}</p>
        </div>
    </div>

    <h3>Purchased Items & Services</h3>
    <c:if test="${not empty mainInvoice.productInvoices}">
        <table>
            <thead>
            <tr>
                <th>Sno.</th>
                <th>Name</th>
                <th>Unit/Price</th>
                <th>Quantity</th>
                <th>Line Total</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="prodInvoice" items="${mainInvoice.productInvoices}">
                <c:forEach var="item" items="${prodInvoice.invoiceItems}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${item.product.name}</td>
                        <td><fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00"/></td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
                    </tr>
                </c:forEach>
                <tr class="total-row">
                    <td colspan="4" style="text-align:right;">Products Total:</td>
                    <td><fmt:formatNumber value="${prodInvoice.totalAmount}" pattern="#,##0.00"/></td>
                </tr>
            </c:forEach>


            </tbody>
        </table>
    </c:if>
    <c:if test="${not empty mainInvoice.serviceInvoices}">
        <table>
            <thead>
            <tr>
                <th>Sno.</th>
                <th>Name</th>
                <th>Amount</th>
                <th>Vat</th>
                <th>Line Total</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="servInvoice" items="${mainInvoice.serviceInvoices}">
                <c:forEach var="item" items="${servInvoice.serviceInvoiceItems}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${item.service.serviceName}</td>
                        <td><fmt:formatNumber value="${item.amount}" pattern="#,##0.00"/></td>
                        <td>${item.vat}</td>
                        <td><fmt:formatNumber value="${item.amount + (item.amount * item.vat / 100)}" pattern="#,##0.00"/></td>
                    </tr>
                </c:forEach>
            </c:forEach>

            <tr class="total-row">
                <td colspan="4" style="text-align:right;">Services Total:</td>
                <td><fmt:formatNumber value="${serviceTotal}" pattern="#,##0.00"/></td>
            </tr>


            </tbody>
        </table>
    </c:if>

    <table>
        <tr class="total-row-grand">
            <td colspan="4" style="text-align:right;">Grand Total:</td>
            <td><fmt:formatNumber value="${mainInvoice.totalAmount}" pattern="#,##0.00"/></td>
        </tr>
    </table>

    <form action="/invoices/pdf/${mainInvoice.id}" method="get" style="display:inline;">
        <button type="submit" class="back-link">Download PDF</button>
    </form>


    <div style="text-align:center;">
        <a href="/api/allInvoice" class="back-link">Back to All Invoices</a>
    </div>
</div>
</body>
</html>
