<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Product</title>
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
            color: #2F3E2F;
            margin-bottom: 30px;
            text-align: center;
        }

        .delete-form {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            text-align: center;
        }

        .delete-form input {
            width: 280px;
            padding: 14px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 16px;
            outline: none;
            transition: 0.3s ease;
        }

        .delete-form input:focus {
            border-color: #A8BBA3;
            box-shadow: 0 0 5px rgba(168,187,163,0.6);
        }

        .delete-form button {
            background-color: #D9534F;
            color: white;
            font-weight: bold;
            border: none;
            padding: 14px 28px;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .delete-form button:hover {
            background-color: #C9302C;
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
    <h1>Delete Product</h1>

    <form class="delete-form" action="/api/deleteP" method="post"
          onsubmit="this.action='/api/deleteP/' + document.getElementById('id').value; return true;">
        <input type="number" id="id" name="id" placeholder="Enter Product ID" required />
        <button type="submit">Delete Product</button>

    <a href="/product" class="back-link">Back to Product Page</a>
    </form>
</div>
</body>
</html>
