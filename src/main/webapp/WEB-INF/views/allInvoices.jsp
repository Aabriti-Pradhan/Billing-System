<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>All Invoices</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #F7F4EA;
            margin: 0;
            padding: 0;
        }

        .content {
            padding: 15px 180px;
            margin-top: -210px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        h1 {
            color: #2F3E2F;
            margin: 0;
        }

        .add-button {
            background-color: #A8BBA3;
            color: #2F3E2F;
            font-weight: bold;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
            text-decoration: none;
        }

        .add-button:hover {
            background-color: #FFF0CE;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 14px;
            font-size: 15px;
            text-align: center;
        }

        th {
            background-color: #A8BBA3;
            color: #2F3E2F;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #EFF5D2;
        }

        tr:hover {
            background-color: #FFF0CE;
            transition: background 0.3s ease;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 18px;
            background-color: #A8BBA3;
            color: #2F3E2F;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
        }

        .back-link:hover {
            background-color: #FFF0CE;
        }

        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .update-btn {
            background-color: #FFD580;
            color: #2F3E2F;
        }

        .update-btn:hover {
            background-color: #FFC04C;
        }

        .delete-btn {
            background-color: #FF6B6B;
            color: white;
        }

        .delete-btn:hover {
            background-color: #E63946;
        }
    </style>
</head>
<body>
<jsp:include page="home.jsp"/>

<div class="content">
    <div class="header">
        <h1>Invoices List</h1>
        <a href="/addInvoice" class="add-button">Add Invoice</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Total Amount</th>
                <th>Discount</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inv" items="${invoices}">
                <tr>
                    <td>${inv.invoiceId}</td>
                    <td>${inv.invoiceDate}</td>
                    <td>${inv.totalAmount}</td>
                    <td>${inv.discount}</td>
                    <td>
                        <form action="/invoice/update/${inv.invoiceId}" method="get" style="display:inline;">
                            <a href="/api/invoice/view/${inv.invoiceId}" class="action-btn update-btn">View</a>
                        </form>
                        <form action="/invoice/delete/${inv.invoiceId}" method="post" style="display:inline;">
                            <button type="submit" class="action-btn delete-btn"
                                    onclick="return confirm('Are you sure you want to delete this invoice?');">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
