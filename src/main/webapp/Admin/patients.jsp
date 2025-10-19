<%@ page import="org.example.healthhub.dto.Patient.PatientDTO" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Patients Management - Digital Clinic</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
      <a href="patients" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-blue-700 mb-2">
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
      <a href="settings.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-cog"></i>
        <span>Settings</span>
      </a>
    </nav>
  </aside>


  <!-- Main Content -->
  <main class="flex-1 overflow-auto">
    <header class="bg-white border-b border-gray-200 px-8 py-4">
      <div class="flex items-center justify-between">
        <div class="relative flex-1 max-w-md">
          <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
          <input type="text" id="searchInput" placeholder="Search patients..."
                 class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div class="flex items-center gap-4">
          <button class="relative p-2 text-gray-600 hover:text-gray-900">
            <i class="fas fa-bell text-xl"></i>
            <span class="absolute top-0 right-0 w-2 h-2 bg-red-500 rounded-full"></span>
          </button>
          <div class="flex items-center gap-3">
            <img src="/assets/img/admin-avatar.png" alt="Admin" class="w-10 h-10 rounded-full">
            <div>
              <p class="text-sm font-medium text-gray-900">Admin</p>
              <p class="text-xs text-gray-500">Administrator</p>
            </div>
          </div>
        </div>
      </div>
    </header>

    <div class="p-8">
      <!-- Stats -->
      <div class="grid grid-cols-4 gap-6 mb-8">
        <div class="bg-white border border-gray-200 rounded-lg p-6">
          <div class="text-sm text-gray-600 mb-2">Total Patients</div>
          <div class="text-3xl font-semibold text-gray-900" id="totalPatients">${totalPatients}</div>
          <div class="text-sm text-gray-500 mt-2">Registered</div>
        </div>
        <div class="bg-white border border-gray-200 rounded-lg p-6">
          <div class="text-sm text-gray-600 mb-2">New This Month</div>
          <div class="text-3xl font-semibold text-gray-900">24</div>
          <div class="text-sm text-gray-500 mt-2">New registrations</div>
        </div>
        <div class="bg-white border border-gray-200 rounded-lg p-6">
          <div class="text-sm text-gray-600 mb-2">Appointments Today</div>
          <div class="text-3xl font-semibold text-gray-900">45</div>
          <div class="text-sm text-gray-500 mt-2">Scheduled visits</div>
        </div>
        <div class="bg-white border border-gray-200 rounded-lg p-6">
          <div class="text-sm text-gray-600 mb-2">Critical Cases</div>
          <div class="text-3xl font-semibold text-gray-900">3</div>
          <div class="text-sm text-gray-500 mt-2">Require attention</div>
        </div>
      </div>

      <!-- Patients Table -->
      <div class="bg-white border border-gray-200 rounded-lg">
        <div class="flex justify-between items-center px-6 py-4 border-b border-gray-200">
          <h2 class="text-lg font-semibold text-gray-900">Patients List</h2>
          <button id="addPatientBtn"
                  class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium px-4 py-2 rounded-lg transition">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
            </svg>
            Add Patient
          </button>
        </div>
        <table class="w-full">
          <thead class="bg-gray-50 border-b border-gray-200">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Name</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">ID Number</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Email</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Phone</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Date of Birth</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Gender</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Actions</th>
          </tr>
          </thead>
          <tbody id="patientsTableBody" class="divide-y divide-gray-200">
          <%
            Collection<PatientDTO> patients = (Collection<PatientDTO>) request.getAttribute("patients");
            if (patients != null && !patients.isEmpty()) {
              for (PatientDTO patient : patients) {
          %>
          <tr class="hover:bg-gray-50" data-id="<%= patient.getId() %>">
            <td class="px-6 py-4 text-sm text-gray-600"><%= patient.getNom() %></td>
            <td class="px-6 py-4 text-sm text-gray-900 font-medium"><%= patient.getId() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= patient.getEmail() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= patient.getTelephone() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= patient.getNaissance() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= patient.getSexe() %></td>
            <td class="px-6 py-4">
              <div class="flex gap-2">
                <button class="btn-view px-3 py-1 text-xs font-medium text-blue-600 border border-blue-600 rounded hover:bg-blue-50">View</button>
                <button class="btn-edit px-3 py-1 text-xs font-medium text-gray-600 border border-gray-300 rounded hover:bg-gray-50">Edit</button>
                <button class="btn-delete px-3 py-1 text-xs font-medium text-red-600 border border-red-600 rounded hover:bg-red-50">Delete</button>
              </div>
            </td>
          </tr>
          <%
            }
          } else {
          %>
          <tr>
            <td colspan="7" class="text-center text-gray-500 py-4">No patients found</td>
          </tr>
          <%
            }
          %>
          </tbody>
        </table>

        <!-- Pagination -->
        <div class="px-6 py-4 border-t border-gray-200 flex justify-between items-center">
          <div class="text-sm text-gray-600">
            Showing <span id="showingCount">1</span> to <span id="showingTo">10</span> of <span id="totalCount">${totalPatients}</span> patients
          </div>
          <div class="flex gap-2">
            <button class="px-3 py-1 text-sm border border-gray-300 rounded hover:bg-gray-50">Previous</button>
            <button class="px-3 py-1 text-sm bg-blue-600 text-white rounded">1</button>
            <button class="px-3 py-1 text-sm border border-gray-300 rounded hover:bg-gray-50">2</button>
            <button class="px-3 py-1 text-sm border border-gray-300 rounded hover:bg-gray-50">3</button>
            <button class="px-3 py-1 text-sm border border-gray-300 rounded hover:bg-gray-50">Next</button>
          </div>
        </div>
      </div>
    </div>
  </main>
</div>

<!-- ======= VIEW PATIENT MODAL ======= -->
<div id="viewPatientModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg shadow-lg w-2/5 p-6 relative">
    <h2 class="text-xl font-semibold mb-4">Patient Details</h2>

    <div class="grid grid-cols-2 gap-4">
      <div>
        <p class="text-sm text-gray-500">Full Name</p>
        <p class="font-medium" id="viewName"></p>
      </div>
      <div>
        <p class="text-sm text-gray-500">ID Number</p>
        <p class="font-medium" id="viewIdNumber"></p>
      </div>
      <div>
        <p class="text-sm text-gray-500">Email</p>
        <p class="font-medium" id="viewEmail"></p>
      </div>
      <div>
        <p class="text-sm text-gray-500">Phone</p>
        <p class="font-medium" id="viewPhone"></p>
      </div>
      <div>
        <p class="text-sm text-gray-500">Date of Birth</p>
        <p class="font-medium" id="viewDOB"></p>
      </div>
      <div>
        <p class="text-sm text-gray-500">Gender</p>
        <p class="font-medium" id="viewGender"></p>
      </div>
      <div class="col-span-2">
        <p class="text-sm text-gray-500">Address</p>
        <p class="font-medium" id="viewAddress"></p>
      </div>
    </div>

    <div class="flex justify-end gap-3 mt-6">
      <button id="closeViewModal" class="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300">Close</button>
    </div>
  </div>
</div>

<!-- ======= CREATE PATIENT MODAL ======= -->
<div id="createPatientModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg shadow-lg w-2/5 p-6 relative max-h-[90vh] overflow-y-auto">
    <h2 class="text-xl font-semibold mb-4">Add New Patient</h2>

    <form id="createPatientForm">
      <div class="grid grid-cols-2 gap-4">
        <!-- Full Name -->
        <div class="col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
          <input type="text" name="nom" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- CIN -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">CIN *</label>
          <input type="text" name="CIN" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- Date of Birth -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Date of Birth *</label>
          <input type="date" name="naissance" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- Email -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Email *</label>
          <input type="email" name="email" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- Phone -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Phone *</label>
          <input type="tel" name="telephone" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- Gender -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Gender *</label>
          <select name="sexe" required
                  class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
            <option value="">Select Gender</option>
            <option value="Homme">Homme</option>
            <option value="Femme">Femme</option>
          </select>
        </div>

        <!-- Blood Type -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Blood Type</label>
          <select name="sang"
                  class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
            <option value="">Select Blood Type</option>
            <option value="A+">A+</option>
            <option value="A-">A-</option>
            <option value="B+">B+</option>
            <option value="B-">B-</option>
            <option value="AB+">AB+</option>
            <option value="AB-">AB-</option>
            <option value="O+">O+</option>
            <option value="O-">O-</option>
          </select>
        </div>

        <!-- Password -->
        <div class="col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-1">Password *</label>
          <input type="password" name="password" required minlength="6"
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- Address -->
        <div class="col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-1">Address</label>
          <textarea name="adresse" rows="2"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
        </div>
      </div>

      <div class="flex justify-end gap-3 mt-6">
        <button type="button" id="cancelCreateBtn" class="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300">Cancel</button>
        <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
          <i class="fas fa-spinner fa-spin hidden" id="createSpinner"></i>
          <span id="createBtnText">Create Patient</span>
        </button>
      </div>
    </form>
  </div>
</div>

<!-- ======= EDIT PATIENT MODAL ======= -->
<div id="editPatientModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg shadow-lg w-2/5 p-6 relative max-h-[90vh] overflow-y-auto">
    <h2 class="text-xl font-semibold mb-4">Edit Patient</h2>

    <form id="editPatientForm">
      <input type="hidden" name="id" id="editPatientId">

      <div class="grid grid-cols-2 gap-4">
        <!-- Full Name -->
        <div class="col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
          <input type="text" name="nom" id="editNom" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- CIN -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">CIN *</label>
          <input type="text" name="CIN" id="editCIN" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- Date of Birth -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Date of Birth *</label>
          <input type="date" name="naissance" id="editNaissance" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- Email -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Email *</label>
          <input type="email" name="email" id="editEmail" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- Phone -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Phone *</label>
          <input type="tel" name="telephone" id="editTelephone" required
                 class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- Gender -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Gender *</label>
          <select name="sexe" id="editSexe" required
                  class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
            <option value="">Select Gender</option>
            <option value="Homme">Homme</option>
            <option value="Femme">Femme</option>
          </select>
        </div>

        <!-- Blood Type -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Blood Type</label>
          <select name="sang" id="editSang"
                  class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
            <option value="">Select Blood Type</option>
            <option value="A+">A+</option>
            <option value="A-">A-</option>
            <option value="B+">B+</option>
            <option value="B-">B-</option>
            <option value="AB+">AB+</option>
            <option value="AB-">AB-</option>
            <option value="O+">O+</option>
            <option value="O-">O-</option>
          </select>
        </div>

        <!-- Address -->
        <div class="col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-1">Address</label>
          <textarea name="adresse" id="editAdresse" rows="2"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
        </div>
      </div>

      <div class="flex justify-end gap-3 mt-6">
        <button type="button" id="cancelEditBtn" class="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300">Cancel</button>
        <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">
          <i class="fas fa-spinner fa-spin hidden" id="editSpinner"></i>
          <span id="editBtnText">Update Patient</span>
        </button>
      </div>
    </form>
  </div>
</div>

<!-- ======= DELETE CONFIRMATION MODAL ======= -->
<div id="confirmDeleteModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg shadow-lg w-1/4 p-6 text-center">
    <i class="fas fa-exclamation-triangle text-red-500 text-4xl mb-4"></i>
    <p class="mb-4 text-gray-700 font-medium">Are you sure you want to delete this patient?</p>
    <p class="mb-6 text-sm text-gray-500">This action cannot be undone.</p>
    <div class="flex justify-center gap-4">
      <button id="confirmDeleteBtn" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">
        <i class="fas fa-spinner fa-spin hidden" id="deleteSpinner"></i>
        <span id="deleteBtnText">Yes, Delete</span>
      </button>
      <button id="cancelDeleteBtn" class="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300">Cancel</button>
    </div>
  </div>
</div>

<!-- ======= TOAST NOTIFICATION ======= -->
<div id="toast" class="hidden fixed bottom-6 right-6 px-6 py-3 rounded-lg shadow-lg transition-all duration-500 transform translate-y-0">
  <div class="flex items-center gap-3">
    <i id="toastIcon" class="fas fa-check-circle text-xl"></i>
    <span id="toastMessage">Action completed successfully!</span>
  </div>
</div>

<!-- ======= JAVASCRIPT ======= -->
<script>
  // Global variables
  let currentPatientId = null;

  // Modal elements
  const viewModal = document.getElementById('viewPatientModal');
  const createModal = document.getElementById('createPatientModal');
  const editModal = document.getElementById('editPatientModal');
  const deleteModal = document.getElementById('confirmDeleteModal');
  const toast = document.getElementById('toast');

  // ======= UTILITY FUNCTIONS =======
  function showToast(message, type = 'success') {
    const toastIcon = document.getElementById('toastIcon');
    const toastMessage = document.getElementById('toastMessage');

    toast.className = 'fixed bottom-6 right-6 px-6 py-3 rounded-lg shadow-lg transition-all duration-500';

    if (type === 'success') {
      toast.classList.add('bg-green-600', 'text-white');
      toastIcon.className = 'fas fa-check-circle text-xl';
    } else if (type === 'error') {
      toast.classList.add('bg-red-600', 'text-white');
      toastIcon.className = 'fas fa-exclamation-circle text-xl';
    }

    toastMessage.textContent = message;
    toast.classList.remove('hidden');

    setTimeout(() => {
      toast.classList.add('opacity-0');
      setTimeout(() => {
        toast.classList.add('hidden');
        toast.classList.remove('opacity-0');
      }, 500);
    }, 3000);
  }

  function closeAllModals() {
    viewModal.classList.add('hidden');
    createModal.classList.add('hidden');
    editModal.classList.add('hidden');
    deleteModal.classList.add('hidden');
  }

  function updateTableRow(patientData) {
    const row = document.querySelector(`tr[data-id="${patientData.id}"]`);
    if (row) {
      row.cells[0].textContent = patientData.nom;
      row.cells[1].textContent = patientData.numeroIdentification;
      row.cells[2].textContent = patientData.email;
      row.cells[3].textContent = patientData.telephone;
      row.cells[4].textContent = patientData.dateNaissance;
      row.cells[5].textContent = patientData.genre;
    }
  }

  function addTableRow(patientData) {
    const tbody = document.getElementById('patientsTableBody');
    const row = tbody.insertRow(0);
    row.dataset.id = patientData.id;
    row.className = 'hover:bg-gray-50';

    row.innerHTML = `
            <td class="px-6 py-4 text-sm text-gray-600">${patientData.nom}</td>
            <td class="px-6 py-4 text-sm text-gray-900 font-medium">${patientData.numeroIdentification}</td>
            <td class="px-6 py-4 text-sm text-gray-600">${patientData.email}</td>
            <td class="px-6 py-4 text-sm text-gray-600">${patientData.telephone}</td>
            <td class="px-6 py-4 text-sm text-gray-600">${patientData.dateNaissance}</td>
            <td class="px-6 py-4 text-sm text-gray-600">${patientData.genre}</td>
            <td class="px-6 py-4">
                <div class="flex gap-2">
                    <button class="btn-view px-3 py-1 text-xs font-medium text-blue-600 border border-blue-600 rounded hover:bg-blue-50">View</button>
                    <button class="btn-edit px-3 py-1 text-xs font-medium text-gray-600 border border-gray-300 rounded hover:bg-gray-50">Edit</button>
                    <button class="btn-delete px-3 py-1 text-xs font-medium text-red-600 border border-red-600 rounded hover:bg-red-50">Delete</button>
                </div>
            </td>
        `;

    attachRowEventListeners(row);
  }

  function removeTableRow(patientId) {
    const row = document.querySelector(`tr[data-id="${patientId}"]`);
    if (row) {
      row.remove();
    }
  }

  // ======= VIEW PATIENT =======
  function viewPatient(row) {
    document.getElementById('viewName').textContent = row.cells[0].textContent;
    document.getElementById('viewIdNumber').textContent = row.cells[1].textContent;
    document.getElementById('viewEmail').textContent = row.cells[2].textContent;
    document.getElementById('viewPhone').textContent = row.cells[3].textContent;
    document.getElementById('viewDOB').textContent = row.cells[4].textContent;
    document.getElementById('viewGender').textContent = row.cells[5].textContent;
    document.getElementById('viewAddress').textContent = row.dataset.address || 'N/A';

    viewModal.classList.remove('hidden');
  }

  document.getElementById('closeViewModal').addEventListener('click', () => {
    viewModal.classList.add('hidden');
  });

  // ======= CREATE PATIENT =======
  document.getElementById('addPatientBtn').addEventListener('click', () => {
    document.getElementById('createPatientForm').reset();
    createModal.classList.remove('hidden');
  });

  document.getElementById('cancelCreateBtn').addEventListener('click', () => {
    createModal.classList.add('hidden');
  });

  document.getElementById('createPatientForm').addEventListener('submit', async (e) => {
    e.preventDefault();

    const submitBtn = e.target.querySelector('button[type="submit"]');
    const spinner = document.getElementById('createSpinner');
    const btnText = document.getElementById('createBtnText');

    spinner.classList.remove('hidden');
    btnText.textContent = 'Creating...';
    submitBtn.disabled = true;

    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());

    // ✅ Log data للتحقق
    console.log('📤 Data being sent:', data);
    console.log('📦 JSON:', JSON.stringify(data));

    try {
      const response = await fetch('${pageContext.request.contextPath}/user/createPatient', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
      });

      console.log('📡 Response status:', response.status);

      const result = await response.json();
      console.log('📥 Response data:', result);

      if (response.ok && result.success) {
        showToast('Patient created successfully!', 'success');
        createModal.classList.add('hidden');
        e.target.reset();

        // ✅ Reload page to show new patient
        setTimeout(() => {
          window.location.reload();
        }, 1000);

      } else {
        // ✅ Show detailed errors
        if (result.errors) {
          console.log('❌ Validation Errors:', result.errors);
          let errorMsg = 'Validation failed:\n';
          for (let key in result.errors) {
            errorMsg += `- ${key}: ${result.errors[key]}\n`;
          }
          showToast(errorMsg, 'error');
        } else {
          showToast(result.message || 'Failed to create patient', 'error');
        }
      }

    } catch (error) {
      console.error('❌ Error:', error);
      showToast('An error occurred. Please try again.', 'error');
    } finally {
      spinner.classList.add('hidden');
      btnText.textContent = 'Create Patient';
      submitBtn.disabled = false;
    }
  });

  // ======= EDIT PATIENT =======
  function editPatient(row) {
    currentPatientId = row.dataset.id;

    // ✅ Fetch patient data from server
    fetch(`${pageContext.request.contextPath}/user/getPatient?id=` + currentPatientId)
            .then(response => response.json())
            .then(result => {
              if (result.success && result.patient) {
                const patient = result.patient;

                document.getElementById('editPatientId').value = patient.id;
                document.getElementById('editNom').value = patient.nom;
                document.getElementById('editCIN').value = patient.CIN || patient.cin;
                document.getElementById('editEmail').value = patient.email;
                document.getElementById('editTelephone').value = patient.telephone;
                document.getElementById('editNaissance').value = patient.naissance;
                document.getElementById('editSexe').value = patient.sexe;
                document.getElementById('editSang').value = patient.sang || '';
                document.getElementById('editAdresse').value = patient.adresse || '';

                editModal.classList.remove('hidden');
              } else {
                showToast('Failed to load patient data', 'error');
              }
            })
            .catch(error => {
              console.error('Error loading patient:', error);
              showToast('Failed to load patient data', 'error');
            });
  }

  document.getElementById('cancelEditBtn').addEventListener('click', () => {
    editModal.classList.add('hidden');
  });

  document.getElementById('editPatientForm').addEventListener('submit', async (e) => {
    e.preventDefault();

    const submitBtn = e.target.querySelector('button[type="submit"]');
    const spinner = document.getElementById('editSpinner');
    const btnText = document.getElementById('editBtnText');

    spinner.classList.remove('hidden');
    btnText.textContent = 'Updating...';
    submitBtn.disabled = true;

    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());

    // ✅ Log data للتحقق
    console.log('📤 Update data being sent:', data);
    console.log('📦 JSON:', JSON.stringify(data));

    try {
      const response = await fetch('${pageContext.request.contextPath}/user/updatePatient', {
        method: 'POST',  // ← في doPost
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
      });

      console.log('📡 Response status:', response.status);

      const result = await response.json();
      console.log('📥 Response data:', result);

      if (response.ok && result.success) {
        showToast('Patient updated successfully!', 'success');
        editModal.classList.add('hidden');

        // ✅ Reload page to show updated data
        setTimeout(() => {
          window.location.reload();
        }, 1000);

      } else {
        // ✅ Show detailed errors
        if (result.errors) {
          console.log('❌ Validation Errors:', result.errors);
          let errorMsg = 'Validation failed:\n';
          for (let key in result.errors) {
            errorMsg += `- ${key}: ${result.errors[key]}\n`;
          }
          showToast(errorMsg, 'error');
        } else {
          showToast(result.message || 'Failed to update patient', 'error');
        }
      }

    } catch (error) {
      console.error('❌ Error:', error);
      showToast('An error occurred. Please try again.', 'error');
    } finally {
      spinner.classList.add('hidden');
      btnText.textContent = 'Update Patient';
      submitBtn.disabled = false;
    }
  });

  // ======= DELETE PATIENT =======
  function deletePatient(row) {
    currentPatientId = row.dataset.id;

    // ✅ Debug log
    console.log('====================================');
    console.log('🗑️ Delete button clicked');
    console.log('   Row:', row);
    console.log('   data-id:', row.dataset.id);
    console.log('   currentPatientId:', currentPatientId);
    console.log('====================================');

    if (!currentPatientId) {
      console.error('❌ No patient ID found!');
      showToast('Error: No patient ID found', 'error');
      return;
    }

    deleteModal.classList.remove('hidden');
  }

  document.getElementById('cancelDeleteBtn').addEventListener('click', () => {
    deleteModal.classList.add('hidden');
  });

  document.getElementById('confirmDeleteBtn').addEventListener('click', async () => {
    const spinner = document.getElementById('deleteSpinner');
    const btnText = document.getElementById('deleteBtnText');
    const confirmBtn = document.getElementById('confirmDeleteBtn');

    // ✅ تحقق من الـ ID قبل الإرسال
    if (!currentPatientId) {
      console.error('❌ No patient ID set!');
      showToast('Error: No patient ID', 'error');
      return;
    }

    spinner.classList.remove('hidden');
    btnText.textContent = 'Deleting...';
    confirmBtn.disabled = true;

    const deleteUrl = '${pageContext.request.contextPath}/user/deletePatient?id=' + currentPatientId;

    console.log('====================================');
    console.log('🗑️ Sending DELETE request');
    console.log('   Patient ID:', currentPatientId);
    console.log('   URL:', deleteUrl);
    console.log('====================================');

    try {
      const response = await fetch(deleteUrl, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json'
        }
      });

      console.log('📡 Response status:', response.status);
      console.log('📡 Response ok:', response.ok);

      const result = await response.json();
      console.log('📥 Response data:', result);

      if (response.ok && result.success) {
        console.log('✅ Patient deleted successfully');

        // Remove row from table
        removeTableRow(currentPatientId);

        showToast('Patient deleted successfully!', 'success');
        deleteModal.classList.add('hidden');

        // Optional: Reload page after 1 second
        setTimeout(() => {
          window.location.reload();
        }, 1000);

      } else {
        console.error('❌ Delete failed:', result);
        showToast(result.error || result.message || 'Failed to delete patient', 'error');
      }

    } catch (error) {
      console.error('❌ Fetch error:', error);
      showToast('An error occurred: ' + error.message, 'error');
    } finally {
      spinner.classList.add('hidden');
      btnText.textContent = 'Yes, Delete';
      confirmBtn.disabled = false;
    }
  });

  // ======= EVENT LISTENERS =======
  function attachRowEventListeners(row) {
    const viewBtn = row.querySelector('.btn-view');
    const editBtn = row.querySelector('.btn-edit');
    const deleteBtn = row.querySelector('.btn-delete');

    if (viewBtn) {
      viewBtn.addEventListener('click', () => {
        console.log('👁️ View clicked for row:', row.dataset.id);
        viewPatient(row);
      });
    }

    if (editBtn) {
      editBtn.addEventListener('click', () => {
        console.log('✏️ Edit clicked for row:', row.dataset.id);
        editPatient(row);
      });
    }

    if (deleteBtn) {
      deleteBtn.addEventListener('click', () => {
        console.log('🗑️ Delete clicked for row:', row.dataset.id);
        deletePatient(row);
      });
    }
  }

  // Attach event listeners to existing rows
  console.log('🔧 Attaching event listeners to rows...');
  document.querySelectorAll('#patientsTableBody tr').forEach(row => {
    if (row.dataset.id) {
      console.log('   - Attaching to row ID:', row.dataset.id);
      attachRowEventListeners(row);
    }
  });
  console.log('✅ Event listeners attached');

  // ======= EVENT LISTENERS =======
  function attachRowEventListeners(row) {
    row.querySelector('.btn-view').addEventListener('click', () => viewPatient(row));
    row.querySelector('.btn-edit').addEventListener('click', () => editPatient(row));
    row.querySelector('.btn-delete').addEventListener('click', () => deletePatient(row));
  }

  // Attach event listeners to existing rows
  document.querySelectorAll('#patientsTableBody tr').forEach(row => {
    if (row.dataset.id) {
      attachRowEventListeners(row);
    }
  });

  // Close modals on outside click
  [viewModal, createModal, editModal, deleteModal].forEach(modal => {
    modal.addEventListener('click', (e) => {
      if (e.target === modal) {
        modal.classList.add('hidden');
      }
    });
  });

  // Search functionality
  document.getElementById('searchInput').addEventListener('input', (e) => {
    const searchTerm = e.target.value.toLowerCase();
    const rows = document.querySelectorAll('#patientsTableBody tr');

    rows.forEach(row => {
      if (!row.dataset.id) return;

      const text = row.textContent.toLowerCase();
      row.style.display = text.includes(searchTerm) ? '' : 'none';
    });
  });
</script>
</body>
</html>