<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - HealthHub</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
<div class="bg-white shadow-lg rounded-2xl p-8 w-96">
    <h2 class="text-2xl font-semibold text-center text-blue-600 mb-6">Create Account</h2>
    <form action="register" method="post" class="flex flex-col gap-4">
        <input type="text" name="name" placeholder="Name" class="border border-gray-300 rounded-lg p-2 focus:outline-blue-500" required>
        <input type="email" name="email" placeholder="Email" class="border border-gray-300 rounded-lg p-2 focus:outline-blue-500" required>

        <select name="role" class="border border-gray-300 rounded-lg p-2 focus:outline-blue-500" required>
            <option value="">Select Role</option>
            <option value="PATIENT">Patient</option>
            <option value="DOCTOR">Doctor</option>
            <option value="ADMIN">Admin</option>
            <option value="STAFF">Staff</option>
        </select>

        <input type="password" name="password" placeholder="Password" class="border border-gray-300 rounded-lg p-2 focus:outline-blue-500" required>

        <button type="submit" class="bg-green-500 hover:bg-green-600 text-white py-2 rounded-lg shadow-md">Register</button>
    </form>

    <p class="text-center text-sm text-gray-600 mt-4">
        Already have an account?
        <a href="login.jsp" class="text-blue-500 hover:underline">Login</a>
    </p>
</div>
</body>
</html>
