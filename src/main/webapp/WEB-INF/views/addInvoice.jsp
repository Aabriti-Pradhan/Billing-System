<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Add Invoice</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background-color: #F7F4EA; margin:0; padding:0; }
        .content { padding: 20px 180px; }
        h1 { text-align:center; color:#2F3E2F; margin-bottom:30px; }
        form { display: flex; flex-direction: column; gap: 15px; max-width: 500px; }

        select, input[type="number"], input[type="text"] {
            width: 100%; padding:10px; border-radius:6px; border:1px solid #ccc;
        }

        label { font-weight:bold; margin-top: 10px; }

        .add-row-btn {
            background-color: #A8BBA3;
            color: #2F3E2F;
            border:none;
            padding: 8px 16px;
            border-radius:6px;
            cursor:pointer;
            width: fit-content;
            margin-bottom: 10px;
        }
        .add-row-btn:hover { background-color: #FFF0CE; }

        button[type="submit"] {
            background-color:#A8BBA3; color:#2F3E2F; border:none; padding:12px 20px; border-radius:8px; cursor:pointer;
        }
        button[type="submit"]:hover { background-color:#FFF0CE; }

        .row { display:flex; gap:10px; margin-bottom: 5px; }
        .row select, .row input { flex: 1; }
    </style>
</head>
<body>

<div class="content">
    <h1>Add New Invoice</h1>

    <form action="/api/createIForm" method="post">
        <label>Customer:</label>
        <select name="customerId" required>
            <c:forEach var="cust" items="${customers}">
                <option value="${cust.customerId}">${cust.name}</option>
            </c:forEach>
        </select>

        <label>Products and Quantities:</label>
        <div id="products-container">
            <div class="row">
                <select name="productId">
                    <option value="">--Select Product--</option>
                    <c:forEach var="prod" items="${products}">
                        <option value="${prod.productId}">${prod.name}</option>
                    </c:forEach>
                </select>
                <input type="number" name="quantity" placeholder="Quantity" min="1">
            </div>
        </div>
        <button type="button" class="add-row-btn" onclick="addRow()">+ Add Product</button>

        <label>Discount:</label>
        <input type="number" name="discount" required step="0.01">

        <label>Is Percentage:</label>
        <input type="checkbox" name="isPercentage">

        <button type="submit">Create Invoice</button>
    </form>
</div>

<script>
    let rowCount = 1;
    function addRow() {
        if (rowCount >= 10) return;
        rowCount++;

        const container = document.getElementById('products-container');
        const row = document.createElement('div');
        row.className = 'row';

        row.innerHTML = `
            <select name="productId">
                <option value="">--Select Product--</option>
                <c:forEach var="prod" items="${products}">
                    <option value="${prod.productId}">${prod.name}</option>
                </c:forEach>
            </select>
            <input type="number" name="quantity" placeholder="Quantity" min="1">
        `;

        container.appendChild(row);
    }
</script>

</body>
</html>
