<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Page</title>
    <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #F7F4EA;
                margin: 0;
                padding: 0;
            }

            .content {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .card {
                background: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
                text-align: center;
                min-width: 400px;
                margin-top: -140px;
            }

            h1 {
                margin-bottom: 30px;
                color: #2F3E2F;
            }

            form {
                margin: 15px 0;
            }

            button {
                background: linear-gradient(135deg, #A8BBA3, #EFF5D2);
                border: none;
                padding: 12px 28px;
                font-size: 15px;
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

            a.back {
                display: inline-block;
                margin-top: 20px;
                color: #2F3E2F;
                font-weight: bold;
                text-decoration: none;
            }

            a.back:hover {
                text-decoration: underline;
            }
        </style>
</head>
<body>
<jsp:include page="home.jsp"/>

    <div class="content">
        <div class="card">
            <h1>Product Page</h1>
            <form action="/api/readP" method="get">
                <button type="submit">Show all Products</button>
            </form>
            <form action="/addProducts" method="get">
                <button type="submit">Add Products</button>
            </form>
            <form action="/updateProducts" method="get">
                <button type="submit">Update Products</button>
            </form>
            <form action="/deleteProducts" method="get">
                <button type="submit">Delete Products</button>
            </form>

            <a href="/" class="back">Back to Home</a>
        </div>
    </div>
</body>
</html>