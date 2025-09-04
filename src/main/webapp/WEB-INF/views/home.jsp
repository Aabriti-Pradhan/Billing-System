<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F7F4EA;
            margin: 0;
            padding: 0;
            align-items: center;
        }

        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            text-align: center;
            color: #2F3E2F;
            font-size: 2.5rem;
            margin-bottom: 10px;
            background-color: #EFF5D2;
            padding: 15px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        form {
            margin: 15px;
        }

        button {
            background-color: #D6A99D;
            border: none;
            padding: 12px 28px;
            font-size: 16px;
            font-weight: bold;
            color: #2F3E2F;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }

        button:hover {
            background: linear-gradient(135deg, #FFF0CE, #A8BBA3);
            transform: translateY(-3px);
            box-shadow: 0 6px 14px rgba(0,0,0,0.15);
        }

        button:active {
            transform: translateY(0);
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<h1>Welcome to Billing System</h1>

<form action="/customer" method="get">
    <button type="submit">Customer</button>
</form>

<form action="/product" method="get">
    <button type="submit">Products</button>
</form>

<form action="/invoice" method="get">
    <button type="submit">Invoices</button>
</form>
<form action="/service" method="get">
    <button type="submit">Services</button>
</form>
</body>
</html>