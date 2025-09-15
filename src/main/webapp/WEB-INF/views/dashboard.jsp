<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<!-- Navbar -->
<div class="bg-gray-800 text-white p-4 flex justify-between items-center">
    <h1 class="text-xl font-bold">Billing Application</h1>
    <button id="logoutBtn" class="bg-red-600 px-4 py-2 rounded-lg hover:bg-red-700">Logout</button>
</div>

<!-- Main layout -->
<div class="flex">
    <!-- Sidebar -->
    <div class="w-64 bg-gray-900 text-white h-screen p-4">
        <ul class="space-y-4">
            <li><a href="#" id="nav-dashboard" class="block px-4 py-2 rounded hover:bg-gray-700">Dashboard</a></li>
            <li><a href="#" id="nav-customers" class="block px-4 py-2 rounded hover:bg-gray-700">Customers</a></li>
            <li><a href="#" id="nav-products" class="block px-4 py-2 rounded hover:bg-gray-700">Products</a></li>
            <li><a href="#" id="nav-services" class="block px-4 py-2 rounded hover:bg-gray-700">Services</a></li>
            <li><a href="#" id="nav-invoices" class="block px-4 py-2 rounded hover:bg-gray-700">Invoices</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div id="main-content" class="flex-1 p-6 pt-60">
        <h2 class="text-2xl font-bold text-gray-700">Welcome to Dashboard</h2>
        <p class="mt-4 text-gray-600">Select a menu from the left.</p>
    </div>
</div>

<!-- Font Awesome for icons -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    $(document).ready(function () {
        // Helper to set active nav item
        function setActive(element) {
            $("ul li a").removeClass("bg-gray-700");
            element.addClass("bg-gray-700");
        }

        // Dashboard
        $("#nav-dashboard").click(function (e) {
            e.preventDefault();
            setActive($(this));
            $("#main-content").load("/dashboardContent", function () {
                history.pushState(null, "", "/dashboard");
            });
        });

        // Customers
        $("#nav-customers").click(function (e) {
            e.preventDefault();
            setActive($(this));
            window.location.href = "/api/read";
        });

        // Products
        $("#nav-products").click(function (e) {
            e.preventDefault();
            setActive($(this));
            window.location.href = "/api/readP";
        });

        // Services
        $("#nav-services").click(function (e) {
            e.preventDefault();
            setActive($(this));
            $("#main-content").load("/services", function () {
                history.pushState(null, "", "/#/services");
            });
        });

        // Invoices
        $("#nav-invoices").click(function (e) {
            e.preventDefault();
            setActive($(this));
            window.location.href = "/api/allInvoice";
        });

        // Logout
        $("#logoutBtn").click(function () {
            window.location.href = "/logout";
        });

        // Handle browser back/forward buttons
        window.onpopstate = function () {
            let path = window.location.pathname;
            if (path.includes("customers")) {
                $("#main-content").load("/api/customers");
            } else if (path.includes("products")) {
                $("#main-content").load("/api/products");
            } else if (path.includes("services")) {
                $("#main-content").load("/services");
            } else if (path.includes("invoices")) {
                $("#main-content").load("/invoices");
            } else {
                $("#main-content").load("/dashboardContent");
            }
        };
    });
</script>

</body>
</html>