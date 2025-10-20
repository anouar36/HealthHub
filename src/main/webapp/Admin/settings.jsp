<%@ page import="org.example.healthhub.entity.User" %>
<%@ page import="org.example.healthhub.dto.UserResponseDTO" %><%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/10/2025
  Time: 12:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  UserResponseDTO user = (UserResponseDTO) session.getAttribute("loggedUser");
  if (user != null) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Digital Clinic - Settings</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen">

  <!-- Sidebar -->
  <aside class="w-64 bg-blue-600 text-white flex flex-col">
    <div class="p-6">
      <h1 class="text-2xl font-bold">Digital Clinic</h1>
    </div>
    <nav class="flex-1 px-4">
      <a href="departments" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-home"></i>
        <span>Dashboard</span>
      </a>
      <a href="doctors" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-user-md"></i>
        <span>Doctors</span>
      </a>
      <a href="patients" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-users"></i>
        <span>Patients</span>
      </a>
      <a href="availabilities" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-calendar-check"></i>
        <span>Appointments</span>
      </a>
      <a href="reports.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-chart-bar"></i>
        <span>Reports</span>
      </a>
      <a href="settings.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-blue-700 mb-2">
        <i class="fas fa-cog"></i>
        <span>Settings</span>
      </a>
    </nav>
  </aside>


  <!-- Main Content -->
  <main class="flex-1 overflow-auto">
    <!-- Header -->
    <header class="bg-white border-b border-gray-200 px-8 py-4">
      <div class="flex justify-between items-center">
        <h1 class="text-2xl font-semibold text-gray-900">Profile Settings</h1>
        <div class="flex items-center gap-4">
          <div class="w-9 h-9 bg-gray-200 rounded-full flex items-center justify-center">
            <img src="https://i.pravatar.cc/150?u=a042581f4e29026704d" alt="User avatar" class="rounded-full">
          </div>
        </div>
      </div>
    </header>

    <div class="p-8">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">

        <!-- Left Column: Profile Picture and Role -->
        <div class="md:col-span-1">
          <div class="bg-white border border-gray-200 rounded-lg p-6 text-center">
            <img class="w-24 h-24 rounded-full mx-auto mb-4" src="https://i.pravatar.cc/150?u=a042581f4e29026704d" alt="Profile picture">
            <h2 class="text-xl font-semibold text-gray-800"> <%= user.getNom() %></h2>
            <p class="text-sm text-gray-500 mb-4"> <%= user.getRole() %></p>
            <button class="w-full px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded hover:bg-blue-700">
              Upload New Picture
            </button>
          </div>
        </div>

        <!-- Right Column: Forms for CRUD -->
        <div class="md:col-span-2">

          <!-- Personal Information -->
          <div class="bg-white border border-gray-200 rounded-lg mb-8">
            <div class="px-6 py-4 border-b border-gray-200">
              <h2 class="text-lg font-semibold text-gray-900">Personal Information</h2>
            </div>
            <div class="p-6">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label for="first_name" class="block text-sm font-medium text-gray-700">First Name</label>
                  <input type="text" id="first_name" value=" <%= user.getNom() %>" class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                </div>
                <div class="md:col-span-2">
                  <label for="email" class="block text-sm font-medium text-gray-700">Email Address</label>
                  <input type="email" id="email" value=" <%= user.getEmail() %>" class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                </div>
                <div class="md:col-span-2">
                  <label for="phone" class="block text-sm font-medium text-gray-700">Account Activation</label>
                  <input type="tel" id="phone" value=" <%= user.isActif() %>" class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                </div>
              </div>
              <div class="mt-6 text-right">
                <button class="px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded hover:bg-blue-700">
                  Save Changes
                </button>
              </div>
            </div>
          </div>

          <!-- Login & Security -->
          <div class="bg-white border border-gray-200 rounded-lg mb-8">
            <div class="px-6 py-4 border-b border-gray-200">
              <h2 class="text-lg font-semibold text-gray-900">Login & Security</h2>
            </div>
            <div class="p-6">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                  <input type="text" id="username" value=" <%= user.getNom() %>" class="mt-1 block w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md shadow-sm sm:text-sm" readonly>
                </div>
                <div>
                  <label for="current_password" class="block text-sm font-medium text-gray-700">Current Password</label>
                  <input type="password" id="current_password" class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                </div>
                <div>
                  <label for="new_password" class="block text-sm font-medium text-gray-700">New Password</label>
                  <input type="password" id="new_password" class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                </div>
                <div>
                  <label for="confirm_password" class="block text-sm font-medium text-gray-700">Confirm New Password</label>
                  <input type="password" id="confirm_password" class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                </div>
              </div>
              <div class="mt-6 text-right">
                <button class="px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded hover:bg-blue-700">
                  Update Password
                </button>
              </div>
            </div>
          </div>

          <!-- Delete Account -->
          <div class="bg-white border border-red-200 rounded-lg">
            <div class="px-6 py-4 border-b border-red-200">
              <h2 class="text-lg font-semibold text-red-800">Delete Account</h2>
            </div>
            <div class="p-6">
              <p class="text-sm text-gray-600 mb-4">Once you delete your account, there is no going back. Please be certain.</p>
              <button class="px-4 py-2 bg-red-600 text-white text-sm font-medium rounded hover:bg-red-700">
                Delete My Account
              </button>
            </div>
          </div>

        </div>
      </div>
    </div>

  </main>
</div>
</body>
</html>
<% } else { %>
<p class="text-red-600 p-4">You must be logged in to view this page.</p>
<% } %>

