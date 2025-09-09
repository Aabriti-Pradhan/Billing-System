<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>All Products</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
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

                .header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 20px;
                    gap: 25px;
                }

                .add-button {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #2F3E2F;
                    font-weight: bold;
                    border: none;
                    padding: 12px 24px;
                    border-radius: 8px;
                    cursor: pointer;
                    font-size: 36px;
                    transition: 0.3s;
                    text-decoration: none;
                }

                .add-button:hover {
                    background-color: #FFF0CE;
                }

                .icon-btn {
                    background: none;
                    border: none;
                    padding: 0;
                    cursor: pointer;
                }

            </style>
</head>
<body>
<jsp:include page="home.jsp"/>

    <div class="content">
        <div class="header">
            <h1>Products List</h1>
            <a href="/addProducts" class="add-button"><i class="bi bi-file-plus-fill fs-1"></i></a>
        </div>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Stock Quantity</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="prod" items="${products}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${prod.name}</td>
                <td>${prod.description}</td>
                <td>${prod.price}</td>
                <td>${prod.stockQuantity}</td>
                <td>
                    <!--update button-->
                    <form action="/updateProduct/${prod.productId}" method="get" style="display:inline;">
                        <button type="submit" class="icon-btn">
                            <i class="bi bi-pencil-square fs-3 text-dark"></i>
                        </button>
                    </form>
                    <!--delete button-->
                    <form action="/api/deleteP/${prod.productId}" method="post" style="display:inline;">
                        <button type="submit"
                            onclick="return confirm('Are you sure you want to delete this Product?');" class="icon-btn">
                           <i class="bi bi-trash3-fill fs-3 text-dark"></i>
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
