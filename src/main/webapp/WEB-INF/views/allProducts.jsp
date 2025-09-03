<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>All Products</title>
    <style>
                body {
                    font-family: 'Segoe UI', Tahoma, sans-serif;
                    background-color: #F7F4EA;
                    margin: 0;
                    padding: 0;
                }

                .content {
                    padding: 15px 180px;
                    margin-top: -140px;
                }

                h1 {
                    text-align: center;
                    color: #2F3E2F;
                    margin-bottom: 30px;
                }

                table {
                    width: 85%;
                    margin: 0 auto 30px auto;
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
            </style>
</head>
<body>
<jsp:include page="home.jsp"/>

    <div class="content">
<h1 style="text-align:center;">Products List</h1>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Stock Quantity</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="prod" items="${products}">
            <tr>
                <td>${prod.productId}</td>
                <td>${prod.name}</td>
                <td>${prod.description}</td>
                <td>${prod.price}</td>
                <td>${prod.stockQuantity}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<div style="text-align:center;">
            <a href="/product" class="back-link">Back to Products Page</a>
        </div>
</div>
</body>
</html>
