<%@ page import="org.example.healthhub.dto.Department.DepartmentDTO" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Digital Clinic - Departments</title>
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
      <a href="dashboard.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-home"></i><span>Dashboard</span>
      </a>
      <a href="doctors.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-user-md"></i><span>Doctors</span>
      </a>
      <a href="patients.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-users"></i><span>Patients</span>
      </a>
      <a href="appointments.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-calendar-check"></i><span>Appointments</span>
      </a>
      <a href="departments.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-blue-700 mb-2">
        <i class="fas fa-building"></i><span>Departments</span>
      </a>
      <a href="reports.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-chart-bar"></i><span>Reports</span>
      </a>
      <a href="settings.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
        <i class="fas fa-cog"></i><span>Settings</span>
      </a>
    </nav>
  </aside>

  <!-- Main Content -->
  <main class="flex-1 overflow-auto">
    <!-- Alert Container -->
    <div id="alertContainer" class="px-8 pt-4"></div>

    <header class="bg-white border-b border-gray-200 px-8 py-4">
      <div class="flex items-center justify-between">
        <div class="relative flex-1 max-w-md">
          <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
          <input type="text" id="searchInput" placeholder="Search departments..."
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
      <!-- Departments Table -->
      <div class="bg-white border border-gray-200 rounded-lg">
        <div class="flex justify-between items-center px-6 py-4 border-b border-gray-200">
          <h2 class="text-lg font-semibold text-gray-900">Departments List</h2>
          <button id="addDepartmentBtn"
                  class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium px-4 py-2 rounded-lg transition">
            <i class="fas fa-plus"></i> Add Department
          </button>
        </div>
        <table class="w-full">
          <thead class="bg-gray-50 border-b border-gray-200">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Code</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Name</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Description</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Actions</th>
          </tr>
          </thead>
          <tbody id="departmentsTableBody" class="divide-y divide-gray-200">
          <%
            Collection<DepartmentDTO> departments = (Collection<DepartmentDTO>) request.getAttribute("departments");
            if (departments != null && !departments.isEmpty()) {
              for (DepartmentDTO dept : departments) {
          %>
          <tr class="hover:bg-gray-50" data-id="<%= dept.getCode() %>">
            <td class="px-6 py-4 text-sm text-gray-900 font-medium"><%= dept.getCode() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= dept.getNom() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= dept.getDescription() %></td>
            <td class="px-6 py-4">
              <div class="flex gap-2">
                <button class="btn-view px-3 py-1 text-xs font-medium text-blue-600 border border-blue-600 rounded hover:bg-blue-50">
                  <i class="fas fa-eye mr-1"></i>View
                </button>
                <button class="btn-edit px-3 py-1 text-xs font-medium text-gray-600 border border-gray-300 rounded hover:bg-gray-50">
                  <i class="fas fa-edit mr-1"></i>Edit
                </button>
                <button class="btn-delete px-3 py-1 text-xs font-medium text-red-600 border border-red-600 rounded hover:bg-red-50">
                  <i class="fas fa-trash mr-1"></i>Delete
                </button>
              </div>
            </td>
          </tr>
          <%
            }
          } else {
          %>
          <tr id="noDataRow">
            <td colspan="4" class="text-center text-gray-500 py-8">
              <i class="fas fa-inbox text-4xl mb-2 text-gray-300"></i>
              <p>No departments found</p>
            </td>
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

<!-- ======= MODALS ======= -->
<!-- Department Modal -->
<div id="departmentModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-40">
  <div class="bg-white rounded-lg shadow-lg w-1/3 p-6 relative transition-transform transform scale-95">
    <div class="flex justify-between items-center mb-4">
      <h2 id="modalTitle" class="text-xl font-semibold">Department Details</h2>
      <button id="closeModalBtn" class="text-gray-500 hover:text-gray-700">
        <i class="fas fa-times text-xl"></i>
      </button>
    </div>

    <!-- View Mode -->
    <div id="viewMode" class="hidden">
      <div class="space-y-3">
        <div class="bg-gray-50 p-3 rounded">
          <p class="text-xs text-gray-500 mb-1">Code</p>
          <p class="font-semibold text-gray-900" id="viewCode"></p>
        </div>
        <div class="bg-gray-50 p-3 rounded">
          <p class="text-xs text-gray-500 mb-1">Name</p>
          <p class="font-semibold text-gray-900" id="viewName"></p>
        </div>
        <div class="bg-gray-50 p-3 rounded">
          <p class="text-xs text-gray-500 mb-1">Description</p>
          <p class="text-gray-900" id="viewDescription"></p>
        </div>
      </div>
      <div class="flex gap-3 mt-6">
        <button id="editBtnFromView" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
          <i class="fas fa-edit mr-2"></i>Edit
        </button>
        <button id="deleteBtnFromView" class="flex-1 px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">
          <i class="fas fa-trash mr-2"></i>Delete
        </button>
      </div>
    </div>

    <!-- Edit/Create Mode -->
    <div id="editMode" class="hidden">
      <form id="departmentForm">
        <input type="hidden" id="editDepartmentId" name="departmentId">
        <div class="mb-4">
          <label class="block text-sm font-medium text-gray-700 mb-2">Code *</label>
          <input id="editCode" name="code" type="text" required
                 class="w-full border border-gray-300 p-2 rounded focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
        </div>
        <div class="mb-4">
          <label class="block text-sm font-medium text-gray-700 mb-2">Name *</label>
          <input id="editName" name="nom" type="text" required
                 class="w-full border border-gray-300 p-2 rounded focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
        </div>
        <div class="mb-4">
          <label class="block text-sm font-medium text-gray-700 mb-2">Description</label>
          <textarea id="editDescription" name="description" rows="3"
                    class="w-full border border-gray-300 p-2 rounded focus:ring-2 focus:ring-blue-500 focus:border-blue-500"></textarea>
        </div>
        <div class="flex gap-3">
          <button type="button" id="cancelBtn" class="flex-1 px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">
            Cancel
          </button>
          <button type="submit" id="submitBtn" class="flex-1 px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">
            <i class="fas fa-check mr-2"></i><span id="submitBtnText">Submit</span>
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Specialties Modal -->
<div id="specialtiesModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg shadow-lg w-2/3 max-w-3xl p-6 relative max-h-[90vh] overflow-y-auto">
    <div class="flex justify-between items-center mb-4">
      <h2 class="text-xl font-semibold">
        <i class="fas fa-stethoscope text-blue-600 mr-2"></i>
        Add Specialties to Department
      </h2>
      <button id="closeSpecialtiesModal" class="text-gray-500 hover:text-gray-700">
        <i class="fas fa-times text-xl"></i>
      </button>
    </div>

    <div class="bg-blue-50 border-l-4 border-blue-600 p-4 mb-4">
      <p class="text-sm text-blue-800">
        <i class="fas fa-info-circle mr-2"></i>
        You can add multiple specialties to this department. Each specialty should have a unique code and name.
      </p>
    </div>

    <form id="specialtiesForm">
      <input type="hidden" id="newDepartmentId" name="departmentId">

      <div id="specialtiesContainer" class="space-y-4"></div>

      <button type="button" id="addSpecialtyBtn"
              class="mb-4 w-full flex items-center justify-center gap-2 border-2 border-dashed border-blue-400 text-blue-600 font-medium px-4 py-3 rounded-lg hover:bg-blue-50 transition">
        <i class="fas fa-plus-circle"></i> Add Another Specialty
      </button>

      <div class="flex gap-3 mt-6">
        <button type="button" id="skipSpecialties"
                class="flex-1 px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition">
          <i class="fas fa-forward mr-2"></i>Skip for Now
        </button>
        <button type="submit"
                class="flex-1 px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 transition">
          <i class="fas fa-save mr-2"></i>Save Specialties
        </button>
      </div>
    </form>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg shadow-lg w-96 p-6">
    <div class="text-center">
      <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-red-100 mb-4">
        <i class="fas fa-exclamation-triangle text-red-600 text-xl"></i>
      </div>
      <h3 class="text-lg font-semibold text-gray-900 mb-2">Delete Department</h3>
      <p class="text-sm text-gray-500 mb-6">
        Are you sure you want to delete this department? This action cannot be undone.
      </p>
      <div class="flex gap-3">
        <button id="cancelDeleteBtn" class="flex-1 px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">
          Cancel
        </button>
        <button id="confirmDeleteBtn" class="flex-1 px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">
          <i class="fas fa-trash mr-2"></i>Delete
        </button>
      </div>
    </div>
  </div>
</div>

<!-- Loading Overlay -->
<div id="loadingOverlay" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-[60]">
  <div class="bg-white rounded-lg p-6 flex flex-col items-center">
    <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mb-3"></div>
    <p class="text-gray-700">Processing...</p>
  </div>
</div>

<script>
  // ===== Global Variables =====
  const modal = document.getElementById('departmentModal');
  const viewMode = document.getElementById('viewMode');
  const editMode = document.getElementById('editMode');
  const addDepartmentBtn = document.getElementById('addDepartmentBtn');
  const specialtiesModal = document.getElementById('specialtiesModal');
  const specialtiesForm = document.getElementById('specialtiesForm');
  const specialtiesContainer = document.getElementById('specialtiesContainer');
  const addSpecialtyBtn = document.getElementById('addSpecialtyBtn');
  const skipSpecialties = document.getElementById('skipSpecialties');
  const deleteModal = document.getElementById('deleteModal');
  const loadingOverlay = document.getElementById('loadingOverlay');
  const departmentsTableBody = document.getElementById('departmentsTableBody');
  const alertContainer = document.getElementById('alertContainer');
  const searchInput = document.getElementById('searchInput');

  let isAddMode = false;
  let specialtyCount = 0;
  let newDepartmentData = null;
  let currentDepartmentId = null;
  let departmentsData = [];

  // ===== Utility Functions =====
  function showLoading() {
    loadingOverlay.classList.remove('hidden');
  }

  function hideLoading() {
    loadingOverlay.classList.add('hidden');
  }

  function showAlert(message, type) {
    type = type || 'success';
    const alertDiv = document.createElement('div');
    const bgColor = type === 'success' ? 'bg-green-50 border-green-300 text-green-700' : 'bg-red-50 border-red-300 text-red-700';
    const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle';

    alertDiv.className = 'mb-4 ' + bgColor + ' border px-4 py-3 rounded flex items-center justify-between animate-fade-in';
    alertDiv.innerHTML = '<div class="flex items-center"><i class="fas ' + icon + ' mr-3"></i><span>' + message + '</span></div><button class="text-current hover:opacity-75" onclick="this.parentElement.remove()"><i class="fas fa-times"></i></button>';

    alertContainer.innerHTML = '';
    alertContainer.appendChild(alertDiv);

    setTimeout(function() {
      alertDiv.remove();
    }, 5000);
  }

  function closeModal() {
    modal.classList.add('hidden');
    viewMode.classList.add('hidden');
    editMode.classList.add('hidden');
    document.getElementById('departmentForm').reset();
    isAddMode = false;
    currentDepartmentId = null;
  }

  function closeSpecialtiesModal() {
    specialtiesModal.classList.add('hidden');
    specialtiesContainer.innerHTML = '';
    specialtyCount = 0;
    newDepartmentData = null;
  }

  function closeDeleteModal() {
    deleteModal.classList.add('hidden');
    currentDepartmentId = null;
  }

  // ===== Load Departments via AJAX =====
  function loadDepartments() {
    showLoading();

    // ✅ استدعاء getDepartments (بدون id)
    fetch('getDepartments', {  // ← تصحيح هنا!
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
            .then(function(res) {
              return res.json();
            })
            .then(function(data) {
              hideLoading();

              if (data.success) {
                departmentsData = data.departments || [];
                renderDepartmentsTable(departmentsData);
              } else {
                showAlert('Failed to load departments', 'error');
              }
            })
            .catch(function(err) {
              hideLoading();
              console.error(err);
              showAlert('Error loading departments', 'error');
            });
  }

  function renderDepartmentsTable(departments) {
    if (!departments || departments.length === 0) {
      departmentsTableBody.innerHTML = '<tr id="noDataRow"><td colspan="4" class="text-center text-gray-500 py-8"><i class="fas fa-inbox text-4xl mb-2 text-gray-300 block"></i><p>No departments found</p></td></tr>';
      return;
    }

    var html = '';
    for (var i = 0; i < departments.length; i++) {
      var dept = departments[i];
      html += '<tr class="hover:bg-gray-50" data-id="' + dept.code + '">';
      html += '<td class="px-6 py-4 text-sm text-gray-900 font-medium">' + dept.code + '</td>';
      html += '<td class="px-6 py-4 text-sm text-gray-600">' + dept.nom + '</td>';
      html += '<td class="px-6 py-4 text-sm text-gray-600">' + (dept.description || '-') + '</td>';
      html += '<td class="px-6 py-4"><div class="flex gap-2">';
      html += '<button class="btn-view px-3 py-1 text-xs font-medium text-blue-600 border border-blue-600 rounded hover:bg-blue-50"><i class="fas fa-eye mr-1"></i>View</button>';
      html += '<button class="btn-edit px-3 py-1 text-xs font-medium text-gray-600 border border-gray-300 rounded hover:bg-gray-50"><i class="fas fa-edit mr-1"></i>Edit</button>';
      html += '<button class="btn-delete px-3 py-1 text-xs font-medium text-red-600 border border-red-600 rounded hover:bg-red-50"><i class="fas fa-trash mr-1"></i>Delete</button>';
      html += '</div></td></tr>';
    }

    departmentsTableBody.innerHTML = html;
    attachTableEventListeners();
  }

  // ===== Search Functionality =====
  searchInput.addEventListener('input', function(e) {
    var searchTerm = e.target.value.toLowerCase().trim();
    if (!searchTerm) {
      renderDepartmentsTable(departmentsData);
      return;
    }

    var filtered = departmentsData.filter(function(dept) {
      return dept.code.toLowerCase().indexOf(searchTerm) !== -1 ||
              dept.nom.toLowerCase().indexOf(searchTerm) !== -1 ||
              (dept.description && dept.description.toLowerCase().indexOf(searchTerm) !== -1);
    });

    renderDepartmentsTable(filtered);
  });

  // ===== Table Event Listeners =====
  function attachTableEventListeners() {
    var viewBtns = document.querySelectorAll('.btn-view');
    for (var i = 0; i < viewBtns.length; i++) {
      viewBtns[i].addEventListener('click', function(e) {
        var row = e.target.closest('tr');
        var id = row.dataset.id;
        viewDepartment(id);
      });
    }

    var editBtns = document.querySelectorAll('.btn-edit');
    for (var i = 0; i < editBtns.length; i++) {
      editBtns[i].addEventListener('click', function(e) {
        var row = e.target.closest('tr');
        var id = row.dataset.id;
        editDepartment(id);
      });
    }

    var deleteBtns = document.querySelectorAll('.btn-delete');
    for (var i = 0; i < deleteBtns.length; i++) {
      deleteBtns[i].addEventListener('click', function(e) {
        var row = e.target.closest('tr');
        var id = row.dataset.id;
        confirmDelete(id);
      });
    }
  }

  // ===== View Department =====
  function viewDepartment(id) {
    showLoading();
    fetch('getDepartment?id=' + id, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
            .then(function(res) { return res.json(); })
            .then(function(data) {
              hideLoading();
              if (data.success) {
                currentDepartmentId = id;
                document.getElementById('viewCode').textContent = data.department.code;
                document.getElementById('viewName').textContent = data.department.nom;
                document.getElementById('viewDescription').textContent = data.department.description || '-';

                modal.classList.remove('hidden');
                viewMode.classList.remove('hidden');
                editMode.classList.add('hidden');
              } else {
                showAlert('Failed to load department details', 'error');
              }
            })
            .catch(function(err) {
              hideLoading();
              console.error(err);
              showAlert('Error loading department', 'error');
            });
  }

  // ===== Edit Department =====
  function editDepartment(id) {
    showLoading();
    fetch('getDepartment?id=' + id, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
            .then(function(res) { return res.json(); })
            .then(function(data) {
              hideLoading();
              if (data.success) {
                isAddMode = false;
                currentDepartmentId = id;
                document.getElementById('editDepartmentId').value = data.department.code;
                document.getElementById('editCode').value = data.department.code;
                document.getElementById('editName').value = data.department.nom;
                document.getElementById('editDescription').value = data.department.description || '';
                document.getElementById('submitBtnText').textContent = 'Update';

                modal.classList.remove('hidden');
                editMode.classList.remove('hidden');
                viewMode.classList.add('hidden');
              } else {
                showAlert('Failed to load department for editing', 'error');
              }
            })
            .catch(function(err) {
              hideLoading();
              console.error(err);
              showAlert('Error loading department', 'error');
            });
  }

  // ===== Add Department Button =====
  addDepartmentBtn.addEventListener('click', function() {
    isAddMode = true;
    currentDepartmentId = null;
    document.getElementById('departmentForm').reset();
    document.getElementById('editDepartmentId').value = '';
    document.getElementById('submitBtnText').textContent = 'Create';

    modal.classList.remove('hidden');
    editMode.classList.remove('hidden');
    viewMode.classList.add('hidden');
  });

  // ===== Edit from View Mode =====
  document.getElementById('editBtnFromView').addEventListener('click', function() {
    if (currentDepartmentId) {
      editDepartment(currentDepartmentId);
    }
  });

  // ===== Delete from View Mode =====
  document.getElementById('deleteBtnFromView').addEventListener('click', function() {
    if (currentDepartmentId) {
      closeModal();
      confirmDelete(currentDepartmentId);
    }
  });

  // ===== Create/Update Department Form Submit =====
  document.getElementById('departmentForm').addEventListener('submit', function(e) {
    e.preventDefault();

    var departmentData = {
      code: document.getElementById('editCode').value.trim(),
      nom: document.getElementById('editName').value.trim(),
      description: document.getElementById('editDescription').value.trim()
    };

    if (isAddMode) {
      showLoading();
      fetch('createDepartment?action=createDepartment', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(departmentData)
      })
              .then(function(res) { return res.json(); })
              .then(function(data) {
                hideLoading();
                if (data.success) {
                  newDepartmentData = { code: departmentData.code, nom: departmentData.nom, description: departmentData.description, id: data.departmentId };
                  closeModal();
                  openSpecialtiesModal();
                } else {
                  showAlert(data.error || 'Failed to create department', 'error');
                }
              })
              .catch(function(err) {
                hideLoading();
                console.error(err);
                showAlert('Error creating department', 'error');
              });
    } else {
      showLoading();
      fetch('updateDepartment', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ code: departmentData.code, nom: departmentData.nom, description: departmentData.description, id: currentDepartmentId })
      })
              .then(function(res) { return res.json(); })
              .then(function(data) {
                hideLoading();
                if (data.success) {
                  showAlert('Department updated successfully!', 'success');
                  closeModal();
                  loadDepartments();
                } else {
                  showAlert(data.error || 'Failed to update department', 'error');
                }
              })
              .catch(function(err) {
                hideLoading();
                console.error(err);
                showAlert('Error updating department', 'error');
              });
    }
  });

  // ===== Specialties Modal =====
  function openSpecialtiesModal() {
    document.getElementById('newDepartmentId').value = newDepartmentData.id;
    specialtyCount = 0;
    specialtiesContainer.innerHTML = '';
    addSpecialtyField();
    specialtiesModal.classList.remove('hidden');
  }

  function addSpecialtyField() {
    specialtyCount++;
    var div = document.createElement('div');
    div.className = 'specialty-item border border-gray-300 rounded-lg p-4 bg-gray-50';

    var removeButton = '';
    if (specialtyCount > 1) {
      removeButton = '<button type="button" class="remove-specialty text-red-500 hover:text-red-700 transition"><i class="fas fa-trash"></i></button>';
    }

    div.innerHTML = '<div class="flex justify-between items-center mb-3">' +
            '<h3 class="text-md font-semibold text-gray-700">' +
            '<i class="fas fa-stethoscope text-blue-500 mr-2"></i>' +
            'Specialty #' + specialtyCount +
            '</h3>' + removeButton + '</div>' +
            '<div class="grid grid-cols-2 gap-4">' +
            '<div><label class="block mb-2 text-sm font-medium text-gray-700">Specialty Code *</label>' +
            '<input name="specialtyCode[]" type="text" required class="w-full border border-gray-300 p-2 rounded focus:ring-2 focus:ring-blue-500 focus:border-blue-500" placeholder="e.g., CARD-01"></div>' +
            '<div><label class="block mb-2 text-sm font-medium text-gray-700">Specialty Name *</label>' +
            '<input name="specialtyName[]" type="text" required class="w-full border border-gray-300 p-2 rounded focus:ring-2 focus:ring-blue-500 focus:border-blue-500" placeholder="e.g., Cardiology"></div>' +
            '</div>' +
            '<div class="mt-3"><label class="block mb-2 text-sm font-medium text-gray-700">Description</label>' +
            '<textarea name="specialtyDescription[]" rows="2" class="w-full border border-gray-300 p-2 rounded focus:ring-2 focus:ring-blue-500 focus:border-blue-500" placeholder="Brief description of the specialty..."></textarea></div>';

    specialtiesContainer.appendChild(div);

    var removeBtn = div.querySelector('.remove-specialty');
    if (removeBtn) {
      removeBtn.addEventListener('click', function() {
        div.remove();
        updateSpecialtyNumbers();
      });
    }
  }

  function updateSpecialtyNumbers() {
    var items = specialtiesContainer.querySelectorAll('.specialty-item');
    for (var i = 0; i < items.length; i++) {
      items[i].querySelector('h3').innerHTML = '<i class="fas fa-stethoscope text-blue-500 mr-2"></i>Specialty #' + (i + 1);
    }
    specialtyCount = items.length;
  }

  addSpecialtyBtn.addEventListener('click', function() {
    addSpecialtyField();
  });

  // ===== Submit Specialties =====
  specialtiesForm.addEventListener('submit', function(e) {
    e.preventDefault();

    var specialties = [];
    var items = document.querySelectorAll('.specialty-item');

    for (var i = 0; i < items.length; i++) {
      var item = items[i];
      var code = item.querySelector('input[name="specialtyCode[]"]').value.trim();
      var name = item.querySelector('input[name="specialtyName[]"]').value.trim();
      var description = item.querySelector('textarea[name="specialtyDescription[]"]').value.trim();

      if (code && name) {
        specialties.push({code: code, name: name, description: description});
      }
    }

    if (specialties.length === 0) {
      showAlert('Please add at least one specialty', 'error');
      return;
    }

    var payload = {
      departmentId: newDepartmentData.id,
      specialties: specialties
    };

    showLoading();
    fetch('addSpecialties', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(payload)
    })
            .then(function (res) {
              return res.json();
            })
            .then(function (data) {
              hideLoading();

              if (data.success) {
                closeSpecialtiesModal();
                showAlert('Department created with ' + specialties.length + ' specialt' + (specialties.length > 1 ? 'ies' : 'y') + '!', 'success');

                // ✅ RELOAD PAGE mn b3d 1.5 seconds
                setTimeout(function () {
                  location.reload();
                }, 1500);

              } else {
                showAlert(data.error || 'Failed to save specialties', 'error');
              }
            })
            .catch(function (err) {
              hideLoading();
              console.error(err);
              showAlert('Error saving specialties', 'error');
            });
  });

    // ===== Skip Specialties =====
    skipSpecialties.addEventListener('click', function () {
      closeSpecialtiesModal();
      showAlert('Department created successfully without specialties!', 'success');
      loadDepartments();
    });

    // ===== Delete Confirmation =====
    function confirmDelete(id) {
      currentDepartmentId = id;
      deleteModal.classList.remove('hidden');
    }

  // ✅ Delete Confirmation
  document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
    if (!currentDepartmentId) return;

    showLoading();

    fetch('deleteDepartment?id=' + currentDepartmentId, {
      method: 'DELETE',
      headers: { 'Content-Type': 'application/json' }
    })
            .then(function(res) {
              return res.json();
            })
            .then(function(data) {
              hideLoading();
              closeDeleteModal();

              if (data.success) {
                showAlert('Department deleted successfully!', 'success');

                // ✅ إعادة تحميل القائمة
                setTimeout(function() {
                  location.reload();  // أو استخدم loadDepartments()
                }, 1000);

              } else {
                showAlert(data.error || 'Failed to delete department', 'error');
              }
            })
            .catch(function(err) {
              hideLoading();
              closeDeleteModal();
              console.error(err);
              showAlert('Error deleting department', 'error');
            });
  });

    document.getElementById('cancelDeleteBtn').addEventListener('click', closeDeleteModal);

    // ===== Close Modal Buttons =====
    document.getElementById('closeModalBtn').addEventListener('click', closeModal);
    document.getElementById('cancelBtn').addEventListener('click', closeModal);
    document.getElementById('closeSpecialtiesModal').addEventListener('click', closeSpecialtiesModal);

    // ===== Initialize =====
    document.addEventListener('DOMContentLoaded', function () {
      attachTableEventListeners();
    });

    // Add CSS animation
    var style = document.createElement('style');
    style.textContent = '@keyframes fade-in { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } } .animate-fade-in { animation: fade-in 0.3s ease-out; }';  // ← ✅ Zid ; hna
    document.head.appendChild(style);

</script>
</body>
</html>