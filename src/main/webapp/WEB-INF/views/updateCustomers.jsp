<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Customer</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #F7F4EA;
            margin: 0;
            padding: 0;
        }

        .content {
            padding: 15px 180px;
            margin-top: 250px;
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
            margin-top: 250px;
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

<div class="content">

    <form class="update-form" action="/api/update" method="post" onsubmit="localStorage.setItem('StatusUpdate', 'updated');">
        <input type="hidden" name="id" value="${customer.customerId}" />

        <input type="text" name="name" placeholder="Name" value="${customer.name}" required />
        <input type="email" name="email" placeholder="Email" value="${customer.email}" required />
        <input type="text" name="phone" placeholder="Phone" value="${customer.phone}" required />
        <input type="text" name="address" placeholder="Address" value="${customer.address}" required />

        <button type="submit">Update Customer</button>
    </form>

</div>
</body>
</html>
