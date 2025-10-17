<%@ page import="org.example.healthhub.dto.DoctorDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Digital Clinic Admin Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen">

  <!-- Sidebar -->
  <aside class="w-64 bg-white border-r border-gray-200">
    <div class="p-6 border-b border-gray-200">
      <div class="flex items-center gap-3">
        <div class="w-8 h-8 bg-blue-600 rounded"></div>
        <span class="font-semibold text-gray-900">Digital Clinic</span>
      </div>
    </div>
    <nav class="p-4">
      <a href="#" class="block px-4 py-3 text-sm font-medium text-blue-600 bg-blue-50 rounded mb-1">
        Dashboard
      </a>
      <a href="Admin/doctors.jsp" class="block px-4 py-3 text-sm text-gray-700 hover:bg-gray-50 rounded mb-1">
        Doctors
      </a>
      <a href="Admin/patients.jsp" class="block px-4 py-3 text-sm text-gray-700 hover:bg-gray-50 rounded mb-1">
        Patients
      </a>
      <a href="#" class="block px-4 py-3 text-sm text-gray-700 hover:bg-gray-50 rounded mb-1">
        Appointments
      </a>
      <a href="#" class="block px-4 py-3 text-sm text-gray-700 hover:bg-gray-50 rounded mb-1">
        Reports
      </a>
      <a href="Admin/settings.jsp" class="block px-4 py-3 text-sm text-gray-700 hover:bg-gray-50 rounded mb-1">
        Settings
      </a>
    </nav>
  </aside>

  <!-- Main Content -->
  <main class="flex-1 overflow-auto">
    <!-- Header -->
    <header class="bg-white border-b border-gray-200 px-8 py-4">
      <div class="flex justify-between items-center">
        <h1 class="text-2xl font-semibold text-gray-900">Dashboard</h1>
        <div class="flex items-center gap-4">
          <input type="text" placeholder="Search" class="px-4 py-2 border border-gray-300 rounded text-sm w-64">
          <div class="w-9 h-9 bg-gray-200 rounded-full"></div>
        </div>
      </div>
    </header>

    <div class="p-8">
      <!-- Stats -->
      <div class="grid grid-cols-4 gap-6 mb-8">
        <div class="bg-white border border-gray-200 rounded-lg p-6">
          <div class="text-sm text-gray-600 mb-2">Total Patients</div>
          <div class="text-3xl font-semibold text-gray-900">1,240</div>
          <div class="text-sm text-gray-500 mt-2">+12% from last month</div>
        </div>
        <div class="bg-white border border-gray-200 rounded-lg p-6">
          <div class="text-sm text-gray-600 mb-2">Active Doctors</div>
          <div class="text-3xl font-semibold text-gray-900">${countDoctors}</div>
          <div class="text-sm text-gray-500 mt-2">3 new this week</div>
        </div>
        <div class="bg-white border border-gray-200 rounded-lg p-6">
          <div class="text-sm text-gray-600 mb-2">Appointments</div>
          <div class="text-3xl font-semibold text-gray-900">312</div>
          <div class="text-sm text-gray-500 mt-2">24 today</div>
        </div>
        <div class="bg-white border border-gray-200 rounded-lg p-6">
          <div class="text-sm text-gray-600 mb-2">Revenue</div>
          <div class="text-3xl font-semibold text-gray-900">$45,200</div>
          <div class="text-sm text-gray-500 mt-2">+8% from last month</div>
        </div>
      </div>

      <!-- Doctors Table -->
      <div class="bg-white border border-gray-200 rounded-lg">
        <div class="bg-white border border-gray-200 rounded-lg">
          <div class="flex justify-between items-center px-6 py-4 border-b border-gray-200">
            <h2 class="text-lg font-semibold text-gray-900">Doctors List</h2>
            <a href="Admin/addDoctor.jsp"
               class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium px-4 py-2 rounded-lg transition">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
              </svg>
              Add Doctor
            </a>
          </div>

          <table class="w-full">
          <thead class="bg-gray-50 border-b border-gray-200">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Name</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Matricule</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Email</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Speciality</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Title</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Status</th>
          </tr>
          </thead>
          <tbody class="divide-y divide-gray-200">
          <%
            Collection<DoctorDTO> doctors = (Collection<DoctorDTO>) request.getAttribute("doctors");
            if (doctors != null && !doctors.isEmpty()) {
              for (DoctorDTO doc : doctors) {
          %>
          <tr class="hover:bg-gray-50">
            <td class="px-6 py-4 text-sm text-gray-900"><%= doc.getNom() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= doc.getMatricule() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= doc.getEmail() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= doc.getSpecialite() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= doc.getTitre() %></td>
            <td class="px-6 py-4">
              <span class="px-3 py-1 text-xs font-medium text-green-700 bg-green-50 rounded-full"><%= doc.getActif() %></span>
            </td>
          </tr>
          <%
            }
          } else {
          %>
          <tr>
            <td colspan="6" class="text-center text-gray-500 py-4">No doctors found</td>
          </tr>
          <%
            }
          %>
          </tbody>
        </table>
      </div>
    </div>

  </main>
</div>
</body>
</html>
