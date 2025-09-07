<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Customer</title>
    <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #F7F4EA;
                margin: 0;
                padding: 0;
            }

            .content {
                padding: 15px 180px;
                margin-top: -250px;
            }

            h1 {
                text-align: center;
                color: #2F3E2F;
                margin-bottom: 30px;
            }

            .add-product-form {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .add-product-form input {
                width: 320px;
                padding: 14px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 16px;
                outline: none;
                transition: 0.3s ease;
            }

            .add-product-form input:focus {
                border-color: #A8BBA3;
                box-shadow: 0 0 5px rgba(168,187,163,0.6);
            }

            .add-product-form button {
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

            .add-product-form button:hover {
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
<h1>Add New Customer</h1>

<form class="add-product-form" action="/api/create" method="post">
    <input type="text" name="name" placeholder="Name" required /><br>
    <input type="email" name="email" placeholder="Email" required /><br>
    <input type="text" name="phone" placeholder="Phone" required /><br>
    <input type="text" name="address" placeholder="Address" required /><br>
    <button type="submit">Add Customer</button>
</form>

<div style="text-align:center;">
        <a href="/customer" class="back-link">Back to Customers List</a>
    </div>
</div>
</body>
</html>
