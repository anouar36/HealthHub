<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - HealthHub</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
<div class="bg-white shadow-lg rounded-2xl p-8 w-96">
    <h2 class="text-2xl font-semibold text-center text-blue-600 mb-6">Login</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded mb-4">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="user" method="post" class="flex flex-col gap-4">
        <input type="hidden" name="action" value="login">
        <input type="email" name="email" placeholder="Email" class="border border-gray-300 rounded-lg p-2 focus:outline-blue-500" required>
        <input type="password" name="password" placeholder="Password" class="border border-gray-300 rounded-lg p-2 focus:outline-blue-500" required>

        <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 rounded-lg shadow-md">Login</button>
    </form>

    <p class="text-center text-sm text-gray-600 mt-4">
        Don’t have an account?
        <a href="register.jsp" class="text-green-500 hover:underline">Register</a>
    </p>
</div>
</body>
</html>
