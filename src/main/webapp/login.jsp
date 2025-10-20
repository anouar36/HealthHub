<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - HealthHub</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        * {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
        }

        body {
            background: linear-gradient(135deg, #0ea5e9 0%, #06b6d4 100%);
            height: 100vh;
            overflow: hidden;
        }

        .login-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            max-width: 400px;
            width: 100%;
        }

        .input-field {
            transition: all 0.2s ease;
        }

        .input-field:focus {
            border-color: #0ea5e9;
            box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.1);
        }

        .btn-login {
            background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
            transition: all 0.2s ease;
        }

        .btn-login:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(14, 165, 233, 0.4);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        /* Remove all scrollbars */
        html, body {
            overflow: hidden;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-card rounded-2xl shadow-2xl p-6">

        <!-- Logo -->
        <div class="text-center mb-4">
            <div class="inline-flex items-center justify-center w-12 h-12 bg-sky-500 rounded-xl mb-2">
                <i class="fas fa-hospital text-white text-xl"></i>
            </div>
            <h1 class="text-2xl font-bold text-gray-900">HealthHub</h1>
            <p class="text-sm text-gray-600">Sign in to your account</p>
        </div>

        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="mb-4 bg-red-50 border-l-4 border-red-500 p-3 rounded">
            <p class="text-red-700 text-sm"><i class="fas fa-exclamation-circle mr-2"></i><%= request.getAttribute("error") %></p>
        </div>
        <% } %>

        <!-- Form -->
        <form action="user/login" method="post" class="space-y-4">
            <input type="hidden" name="action" value="login">

            <!-- Email -->
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">Email</label>
                <div class="relative">
                    <i class="fas fa-envelope absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-sm"></i>
                    <input
                            type="email"
                            name="email"
                            value="anouar36"
                            placeholder="your.email@example.com"
                            class="input-field w-full pl-9 pr-3 py-2.5 text-sm border-2 border-gray-300 rounded-lg focus:outline-none"
                            required>
                </div>
            </div>

            <!-- Password -->
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">Password</label>
                <div class="relative">
                    <i class="fas fa-lock absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-sm"></i>
                    <input
                            type="password"
                            name="password"
                            id="password"
                            placeholder="••••••••"
                            class="input-field w-full pl-9 pr-10 py-2.5 text-sm border-2 border-gray-300 rounded-lg focus:outline-none"
                            required>
                    <button
                            type="button"
                            onclick="togglePassword()"
                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600">
                        <i class="fas fa-eye text-sm" id="toggleIcon"></i>
                    </button>
                </div>
            </div>

            <!-- Remember & Forgot -->
            <div class="flex items-center justify-between text-xs">
                <label class="flex items-center gap-1.5 cursor-pointer">
                    <input type="checkbox" class="w-3.5 h-3.5 text-sky-500 rounded border-gray-300">
                    <span class="text-gray-700">Remember me</span>
                </label>
                <a href="#" class="text-sky-600 hover:text-sky-700 font-semibold">Forgot?</a>
            </div>

            <!-- Submit -->
            <button
                    type="submit"
                    class="btn-login w-full text-white font-semibold py-2.5 rounded-lg text-sm">
                Sign In
            </button>
        </form>

        <!-- Register -->
        <p class="text-center text-xs text-gray-600 mt-4">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register.jsp" class="text-sky-600 hover:text-sky-700 font-semibold">
                Sign up
            </a>
        </p>

        <!-- Footer -->
        <p class="text-center text-xs text-gray-500 mt-3">
            <i class="fas fa-shield-alt text-sky-500 mr-1"></i>Secured & Encrypted
        </p>
    </div>
</div>

<script>
    function togglePassword() {
        const input = document.getElementById('password');
        const icon = document.getElementById('toggleIcon');

        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.replace('fa-eye-slash', 'fa-eye');
        }
    }

    // Loading state
    document.querySelector('form').addEventListener('submit', function(e) {
        const btn = this.querySelector('button[type="submit"]');
        btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Signing in...';
        btn.disabled = true;
    });
</script>
</body>
</html>