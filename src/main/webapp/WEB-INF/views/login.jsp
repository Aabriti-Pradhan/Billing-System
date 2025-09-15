<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">

<!-- ✅ Toast Notification -->
<c:if test="${not empty success}">
    <div id="toast-simple"
         class="fixed top-5 right-5 flex items-center w-full max-w-xs p-4 space-x-4 rtl:space-x-reverse text-gray-500 bg-white divide-x rtl:divide-x-reverse divide-gray-200 rounded-lg shadow-sm dark:text-gray-400 dark:divide-gray-700 dark:bg-gray-800 opacity-0 transition-opacity duration-500"
         role="alert">
        <svg class="w-5 h-5 text-blue-600 dark:text-blue-500 rotate-45" aria-hidden="true"
             xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="m9 17 8 2L9 1 1 19l8-2Zm0 0V9"/>
        </svg>
        <div class="ps-4 text-sm font-normal">${success}</div>
    </div>

    <script>
        const toast = document.getElementById("toast-simple");
        setTimeout(() => toast.classList.add("opacity-100"), 100);   // Show
        setTimeout(() => toast.classList.remove("opacity-100"), 3000); // Hide after 3s
    </script>
</c:if>

<div class="flex w-full max-w-4xl shadow-2xl rounded-xl overflow-hidden">
    <!-- Left panel -->
    <div class="hidden md:flex md:w-1/2 bg-gradient-to-b from-gray-800 to-gray-900 items-center justify-center">
        <div class="text-center text-white px-6">
            <h1 class="text-4xl font-bold mb-4">Welcome Back!</h1>
            <p class="text-gray-300">Manage your dashboard, customers, products, and transactions efficiently.</p>
        </div>
    </div>

    <!-- Right panel: Login card -->
    <div class="w-full md:w-1/2 bg-gray-800 text-gray-100 p-8 flex flex-col justify-center">
        <h2 class="text-3xl font-bold text-center mb-6 text-white">Login</h2>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="bg-red-700 bg-opacity-20 text-red-400 px-4 py-2 rounded mb-4 text-center">
                    ${error}
            </div>
        </c:if>

        <!-- Logout message -->
        <c:if test="${param.logout eq 'true'}">
            <div class="bg-green-700 bg-opacity-20 text-green-400 px-4 py-2 rounded mb-4 text-center">
                You have been logged out successfully.
            </div>
        </c:if>

        <form action="/login" method="post" class="space-y-4">
            <input type="text" name="username" placeholder="Username"
                   class="w-full px-4 py-2 rounded-lg bg-gray-700 border border-gray-600 text-white focus:outline-none focus:ring-2 focus:ring-blue-400"/>

            <input type="password" name="password" placeholder="Password"
                   class="w-full px-4 py-2 rounded-lg bg-gray-700 border border-gray-600 text-white focus:outline-none focus:ring-2 focus:ring-blue-400"/>

            <button type="submit"
                    class="w-full bg-blue-700 hover:bg-blue-800 py-2 rounded-lg font-semibold transition">
                Login
            </button>
        </form>

        <p class="text-center text-gray-300 mt-4 text-sm">
            Don't have an account?
            <a href="/signup" class="text-blue-400 hover:underline">Sign up here</a>
        </p>
    </div>
</div>

</body>
</html>