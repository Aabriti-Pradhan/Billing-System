<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">

<div class="flex w-full max-w-4xl shadow-2xl rounded-xl overflow-hidden">
    <!-- Left panel: Dashboard accent -->
    <div class="hidden md:flex md:w-1/2 bg-gradient-to-b from-gray-800 to-gray-900 items-center justify-center">
        <div class="text-center text-white px-6">
            <h1 class="text-4xl font-bold mb-4">Join Us!</h1>
            <p class="text-gray-300">Sign up to access your dashboard, manage products, customers, and transactions easily.</p>
<%--            <img src="/resources/images/dashboard-illustration.svg" alt="Dashboard Illustration" class="mt-6 w-3/4 mx-auto">--%>
        </div>
    </div>

    <!-- Right panel: Signup card -->
    <div class="w-full md:w-1/2 bg-gray-800 text-gray-100 p-8 flex flex-col justify-center">
        <h2 class="text-3xl font-bold text-center mb-6 text-white">Create Account</h2>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="bg-red-700 bg-opacity-20 text-red-400 px-4 py-2 rounded mb-4 text-center">
                    ${error}
            </div>
        </c:if>

        <!-- Success message -->
        <c:if test="${not empty success}">
            <div class="bg-green-700 bg-opacity-20 text-green-400 px-4 py-2 rounded mb-4 text-center">
                    ${success}
            </div>
        </c:if>

        <!-- Signup Form -->
        <form action="/signup" method="post" class="space-y-4">
            <input type="text" name="username" placeholder="Username"
                   class="w-full px-4 py-2 rounded-lg bg-gray-700 border border-gray-600 text-white focus:outline-none focus:ring-2 focus:ring-blue-400"/>

            <input type="email" name="email" placeholder="Email"
                   class="w-full px-4 py-2 rounded-lg bg-gray-700 border border-gray-600 text-white focus:outline-none focus:ring-2 focus:ring-blue-400"/>

            <input type="password" name="password" placeholder="Password"
                   class="w-full px-4 py-2 rounded-lg bg-gray-700 border border-gray-600 text-white focus:outline-none focus:ring-2 focus:ring-blue-400"/>

            <button type="submit"
                    class="w-full bg-blue-700 hover:bg-blue-800 py-2 rounded-lg font-semibold transition">
                Sign Up
            </button>
        </form>

        <p class="text-center text-gray-300 mt-4 text-sm">
            Already have an account? <a href="/login" class="text-blue-400 hover:underline">Login</a>
        </p>
    </div>
</div>

</body>
</html>