<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Customer</title>
    <style>
        body { font-family: Arial; text-align: center; margin-top: 50px; }
        input { padding: 8px; margin: 5px; width: 250px; }
        button { padding: 10px 20px; margin-top: 10px; cursor: pointer; }
    </style>
</head>
<body>
<h1>Add Invoice</h1>
<form action="/api/invoice/create" method="post">
    <label>Customer:</label>
    <select name="customerId" required>
        <option value="1">Customer 1</option>
        <option value="2">Customer 2</option>
        <option value="3">Customer 3</option>
    </select><br><br>

    <label>Discount:</label>
    <input type="number" name="discount" step="0.01" required /><br><br>

    <label>Is Percentage:</label>
    <input type="checkbox" name="isPercentage" value="true" /><br><br>

    <c:forEach var="i" begin="1" end="10">
        <h3>Invoice Item ${i}</h3>
        <label>Product:</label>
        <select name="productId${i}">
            <c:forEach var="prod" items="${products}">
                <option value="${prod.productId}">${prod.name}</option>
            </c:forEach>
        </select>
        <label>Quantity:</label>
        <input type="number" name="quantity${i}" /><br><br>
    </c:forEach>


    <button type="submit">Create Invoice</button>
</form>

<br>
<a href="/customer">Back to Customer Page</a>
</body>
</html>
