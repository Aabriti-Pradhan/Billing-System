<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Product</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #F7F4EA;
            margin: 0;
            padding: 0;
        }

        .content {
            padding: 15px 180px;
            margin-top: -180px;
        }

        h1 {
            color: #2F3E2F;
            margin-bottom: 30px;
            text-align: center;
        }

        .update-form {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            text-align: center;
        }

        .update-form input {
            width: 320px;
            padding: 14px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 16px;
            outline: none;
            transition: 0.3s ease;
        }

        .update-form input:focus {
            border-color: #A8BBA3;
            box-shadow: 0 0 5px rgba(168,187,163,0.6);
        }

        .update-form button {
            background-color: #A8BBA3;
            color: #2F3E2F;
            font-weight: bold;
            border: none;
            padding: 14px 28px;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .update-form button:hover {
            background-color: #FFF0CE;
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
    <h1>Update Product</h1>

    <form class="update-form" action="/api/updateP" method="post">
        <input type="hidden" name="id" value="${product.productId}" />

        <input type="text" name="name" placeholder="Name" value="${product.name}" required />
        <input type="text" name="description" placeholder="Description" value="${product.description}" required />
        <input type="number" name="price" placeholder="Price" value="${product.price}" required />
        <input type="number" name="stockQuantity" placeholder="Stock Quantity" value="${product.stockQuantity}" required step="0.01" />

        <button type="submit">Update Product</button>
    </form>
</div>
</body>
</html>
