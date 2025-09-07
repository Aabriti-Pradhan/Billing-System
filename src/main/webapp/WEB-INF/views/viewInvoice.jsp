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
            <p><b>Name:</b> ${invoice.customer.name}</p>
            <p><b>Email:</b> ${invoice.customer.email}</p>
            <p><b>Phone:</b> ${invoice.customer.phone}</p>
        </div>
        <div class="date-info">
            <h2>Invoice</h2>
            <p><b>Date:</b> ${invoice.invoiceDate}</p>
            <p><b>Invoice ID:</b> ${invoice.invoiceId}</p>
        </div>
    </div>

    <h3>Purchased Items</h3>
    <table>
        <thead>
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Line Total</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="subTotal" value="0" />
        <c:forEach var="item" items="${invoice.invoiceItems}">
            <tr>
                <td>${item.product.name}</td>
                <td><fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00"/></td>
                <td>${item.quantity}</td>
                <td>
                    <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/>
                    <c:set var="subTotal" value="${subTotal + item.subtotal}" />
                </td>
            </tr>
        </c:forEach>

        <tr class="total-row">
            <td colspan="3" style="text-align:right;">Subtotal:</td>
            <td><fmt:formatNumber value="${subTotal}" pattern="#,##0.00"/></td>
        </tr>

        <tr class="total-row">
            <td colspan="3" style="text-align:right;">
                Discount
                <c:choose>
                    <c:when test="${invoice.percentage}">(${invoice.discount}%)</c:when>
                    <c:otherwise>(Flat)</c:otherwise>
                </c:choose>
            </td>
            <td>
                <fmt:formatNumber value="${subTotal - invoice.totalAmount}" pattern="#,##0.00"/>
            </td>
        </tr>

        <tr class="total-row">
            <td colspan="3" style="text-align:right;">Total Amount:</td>
            <td><fmt:formatNumber value="${invoice.totalAmount}" pattern="#,##0.00"/></td>
        </tr>
        </tbody>
    </table>

    <form action="${pageContext.request.contextPath}/invoices/pdf/${invoice.invoiceId}">
        <button>Download Invoice</button>
    </form>


    <div style="text-align:center;">
        <a href="/api/allInvoice" class="back-link">Back to All Invoices</a>
    </div>
</div>
</body>
</html>
