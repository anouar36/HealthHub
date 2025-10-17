    <%@ page import="org.example.healthhub.dto.DoctorDTO" %>
    <%@ page import="java.util.Collection" %>
    <%@ page import="java.util.Map" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Digital Clinic Admin Dashboard</title>
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
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
                <a href="doctors.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-blue-700 mb-2">
                    <i class="fas fa-user-md"></i>
                    <span>Doctors</span>
                </a>
                <a href="patients.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
                    <i class="fas fa-users"></i>
                    <span>Patients</span>
                </a>
                <a href="appointments.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
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
            <%
                Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
                if (errors != null && !errors.isEmpty()) {
            %>
            <div class="mb-6 bg-red-50 border border-red-300 text-red-700 px-4 py-3 rounded">
                <ul class="list-disc ml-5">
                    <% for (Map.Entry<String, String> e : errors.entrySet()) { %>
                    <li><%= e.getValue() %></li>
                    <% } %>
                </ul>
            </div>
            <% } %>
            <header class="bg-white border-b border-gray-200 px-8 py-4">
                <div class="flex items-center justify-between">
                    <div class="relative flex-1 max-w-md">
                        <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                        <input type="text" placeholder="Search..."
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
                        <div class="text-sm text-gray-600 mb-2">Total Doctors</div>
                        <div class="text-3xl font-semibold text-gray-900">${totalDoctors}</div>
                        <div class="text-sm text-gray-500 mt-2">Active staff</div>
                    </div>
                    <div class="bg-white border border-gray-200 rounded-lg p-6">
                        <div class="text-sm text-gray-600 mb-2">On Duty Today</div>
                        <div class="text-3xl font-semibold text-gray-900">32</div>
                        <div class="text-sm text-gray-500 mt-2">Currently available</div>
                    </div>
                    <div class="bg-white border border-gray-200 rounded-lg p-6">
                        <div class="text-sm text-gray-600 mb-2">Appointments</div>
                        <div class="text-3xl font-semibold text-gray-900">156</div>
                        <div class="text-sm text-gray-500 mt-2">Scheduled today</div>
                    </div>
                    <div class="bg-white border border-gray-200 rounded-lg p-6">
                        <div class="text-sm text-gray-600 mb-2">Departments</div>
                        <div class="text-3xl font-semibold text-gray-900">8</div>
                        <div class="text-sm text-gray-500 mt-2">Medical specialties</div>
                    </div>
                </div>
                <!-- Doctors Table -->
                <div class="bg-white border border-gray-200 rounded-lg">
                    <div class="flex justify-between items-center px-6 py-4 border-b border-gray-200">
                        <h2 class="text-lg font-semibold text-gray-900">Doctors List</h2>
                        <a href="${pageContext.request.contextPath}/user/addDoctor"
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
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                        <%
                            Collection<DoctorDTO> doctors = (Collection<DoctorDTO>) request.getAttribute("doctors");
                            if (doctors != null && !doctors.isEmpty()) {
                                for (DoctorDTO doc : doctors) {
                        %>
                        <tr class="hover:bg-gray-50" data-id="<%= doc.getId()%>">
                            <td class="px-6 py-4 text-sm text-gray-600"><%= doc.getNom() %></td>
                            <td class="px-6 py-4 text-sm text-gray-900 font-medium"><%= doc.getMatricule() %></td>
                            <td class="px-6 py-4 text-sm text-gray-600"><%= doc.getEmail() %></td>
                            <td class="px-6 py-4 text-sm text-gray-600"><%= doc.getSpecialite() %></td>
                            <td class="px-6 py-4 text-sm text-gray-600"><%= doc.getTitre() %></td>
                            <td class="px-6 py-4">
                                <span class="px-3 py-1 text-xs font-medium text-green-700 bg-green-50 rounded-full"><%= doc.getActif() %></span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex gap-2">
                                    <button class="btn-view px-3 py-1 text-xs font-medium text-blue-600 border border-blue-600 rounded hover:bg-blue-50">View</button>
                                    <button class="px-3 py-1 text-xs font-medium text-gray-600 border border-gray-300 rounded hover:bg-gray-50">Edit</button>
                                    <button class="px-3 py-1 text-xs font-medium text-red-600 border border-red-600 rounded hover:bg-red-50">Delete</button>
                                </div>
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

                    <!-- Pagination -->
                    <div class="px-6 py-4 border-t border-gray-200 flex justify-between items-center">
                        <div class="text-sm text-gray-600">
                            Showing 1 to 6 of 48 doctors
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

    <!-- ======= MODALS & TOAST ======= -->
    <div id="doctorModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center">
        <div class="bg-white rounded-lg shadow-lg w-1/3 p-6 relative transition-transform transform scale-95">
            <h2 id="modalTitle" class="text-xl font-semibold mb-4">Doctor Details</h2>

            <div id="viewMode">
                <p><strong>Name:</strong> <span id="viewName"></span></p>
                <p><strong>Email:</strong> <span id="viewEmail"></span></p>
                <p><strong>Speciality:</strong> <span id="viewSpeciality"></span></p>
                <p><strong>Title:</strong> <span id="viewTitle"></span></p>
                <p><strong>matricule:</strong> <span id="viewMatricule"></span></p>


            </div>

            <div id="editMode" class="hidden">
                <form action="updateDoctor" method="post">
                    <input type="hidden" name="action" value="updateDoctor">
                    <input type="hidden" id="editDoctorId" name="doctorId">
                    <input id="editName" name="nom" type="text" class="w-full border p-2 rounded mb-2" placeholder="Name">
                    <input id="editEmail" name="email" type="email" class="w-full border p-2 rounded mb-2" placeholder="Email">
                    <input id="editSpeciality" name="specialite" type="text" class="w-full border p-2 rounded mb-2" placeholder="Speciality">
                    <input id="editTitle" name="titre" type="text" class="w-full border p-2 rounded mb-2" placeholder="Title">
                    <input id="editMatricule" name="matricule" type="text" class="w-full border p-2 rounded mb-2" placeholder="matricule">
                    <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">Submit</button>
                </form>
            </div>

            <div class="flex justify-between mt-4">
                <button id="cancelBtn" class="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300">Annuler</button>
                <div>
                    <button id="editBtn" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Edit</button>
                    <button id="deleteBtn" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">Delete</button>
                    <button id="saveBtn" class="hidden px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">Submit</button>
                </div>
            </div>
        </div>
    </div>

    <div id="confirmDeleteModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center">
        <div class="bg-white rounded-lg shadow-lg w-1/4 p-6 text-center">
            <p class="mb-4 text-gray-700 font-medium">Are you sure you want to delete this doctor?</p>
            <div class="flex justify-center gap-4">
                <button id="confirmYes" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">Yes</button>
                <button id="confirmNo" class="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300">Cancel</button>
            </div>
        </div>
    </div>

    <div id="toast" class="hidden fixed bottom-6 right-6 bg-green-600 text-white px-4 py-2 rounded shadow-lg transition-all duration-500">
        Action completed successfully!
    </div>

    <!-- ======= JAVASCRIPT ======= -->
    <script>
        const modal = document.getElementById('doctorModal');
        const viewMode = document.getElementById('viewMode');
        const editMode = document.getElementById('editMode');
        const editBtn = document.getElementById('editBtn');
        const deleteBtn = document.getElementById('deleteBtn');
        const saveBtn = document.getElementById('saveBtn');
        const cancelBtn = document.getElementById('cancelBtn');
        const confirmModal = document.getElementById('confirmDeleteModal');
        const toast = document.getElementById('toast');

        let currentRow = null;

        // Show Doctor Details
        document.querySelectorAll('.btn-view').forEach(btn => {
            btn.addEventListener('click', e => {
                const row = e.target.closest('tr');
                currentRow = row;
                document.getElementById('viewName').innerText = row.cells[0].innerText;
                document.getElementById('viewMatricule').innerText = row.cells[1].innerText;
                document.getElementById('viewEmail').innerText = row.cells[2].innerText;
                document.getElementById('viewSpeciality').innerText = row.cells[3].innerText;
                document.getElementById('viewTitle').innerText = row.cells[4].innerText;

                console.log("Name:", row.cells[0].innerText);
                console.log("Matricule:", row.cells[1].innerText);
                console.log("Email:", row.cells[2].innerText);
                console.log("Speciality:", row.cells[3].innerText);
                console.log("Title:", row.cells[4].innerText);

                modal.classList.remove('hidden');
            });
        });




        // Edit Mode
        editBtn.addEventListener('click', () => {
            viewMode.classList.add('hidden');
            editMode.classList.remove('hidden');
            editBtn.classList.add('hidden');
            saveBtn.classList.remove('hidden');

            document.getElementById('editName').value = document.getElementById('viewName').innerText;
            document.getElementById('editMatricule').value = document.getElementById('viewMatricule').innerText;
            document.getElementById('editEmail').value = document.getElementById('viewEmail').innerText;
            document.getElementById('editSpeciality').value = document.getElementById('viewSpeciality').innerText;
            document.getElementById('editTitle').value = document.getElementById('viewTitle').innerText;

            document.getElementById('editDoctorId').value = currentRow.dataset.id;
        });

        // Submit Update
        saveBtn.addEventListener('click', () => {
            // تحديث الجدول مباشرة (اختياري)
            currentRow.cells[0].innerText = document.getElementById('editName').value;
            currentRow.cells[1].innerText = document.getElementById('editMatricule').value;
            currentRow.cells[2].innerText = document.getElementById('editEmail').value;
            currentRow.cells[3].innerText = document.getElementById('editSpeciality').value;
            currentRow.cells[4].innerText = document.getElementById('editTitle').value;

            // إرسال الفورم للسيرفر
            document.querySelector('#editMode form').submit();

            showToast("Doctor updated successfully!");
            closeModal();
        });

        // Delete Confirmation
        deleteBtn.addEventListener('click', () => {
            modal.classList.add('hidden');
            confirmModal.classList.remove('hidden');
        });

        document.getElementById('confirmYes').addEventListener('click', () => {
            currentRow.remove();
            confirmModal.classList.add('hidden');
            showToast("Doctor deleted successfully!");
        });

        document.getElementById('confirmNo').addEventListener('click', () => {
            confirmModal.classList.add('hidden');
            modal.classList.remove('hidden');
        });

        // Cancel or Click Outside
        cancelBtn.addEventListener('click', closeModal);
        modal.addEventListener('click', e => {
            if (e.target === modal) closeModal();
        });

        function closeModal() {
            modal.classList.add('hidden');
            viewMode.classList.remove('hidden');
            editMode.classList.add('hidden');
            editBtn.classList.remove('hidden');
            saveBtn.classList.add('hidden');
        }

        function showToast(message) {
            toast.innerText = message;
            toast.classList.remove('hidden', 'opacity-0');
            setTimeout(() => {
                toast.classList.add('opacity-0');
                setTimeout(() => toast.classList.add('hidden'), 500);
            }, 1500);
        }
    </script>

    </body>
    </html>
