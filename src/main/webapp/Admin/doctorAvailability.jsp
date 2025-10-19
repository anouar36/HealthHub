<%@ page import="org.example.healthhub.dto.DoctorDTO" %>
<%@ page import="java.util.Collection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Doctor Availability - Digital Clinic</title>
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
            <a href="patients" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
                <i class="fas fa-users"></i>
                <span>Patients</span>
            </a>
            <a href="availabilities" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-blue-700 mb-2">
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
                <h2 class="text-2xl font-semibold text-gray-900">Doctor Availability Management</h2>
                <div class="flex items-center gap-3">
                    <img src="/assets/img/admin-avatar.png" alt="Admin" class="w-10 h-10 rounded-full">
                    <div>
                        <p class="text-sm font-medium text-gray-900">Admin</p>
                        <p class="text-xs text-gray-500">Administrator</p>
                    </div>
                </div>
            </div>
        </header>

        <div class="p-8">
            <!-- Doctor Selection -->
            <div class="bg-white border border-gray-200 rounded-lg p-6 mb-6">
                <label class="block text-sm font-medium text-gray-700 mb-2">Select Doctor</label>
                <select id="doctorSelect" class="w-full md:w-1/3 border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="">Choose a doctor...</option>
                </select>
            </div>

            <!-- Calendar Container -->
            <div class="bg-white border border-gray-200 rounded-lg p-6">
                <!-- Calendar Header -->
                <div class="flex justify-between items-center mb-6">
                    <div class="flex items-center gap-4">
                        <button id="prevWeek" class="p-2 hover:bg-gray-100 rounded-lg transition">
                            <i class="fas fa-chevron-left text-gray-600"></i>
                        </button>
                        <h3 id="weekRange" class="text-lg font-semibold text-gray-900">Week of Jan 15 - Jan 21, 2025</h3>
                        <button id="nextWeek" class="p-2 hover:bg-gray-100 rounded-lg transition">
                            <i class="fas fa-chevron-right text-gray-600"></i>
                        </button>
                    </div>
                    <button id="todayBtn" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
                        Today
                    </button>
                </div>

                <!-- Legend -->
                <div class="flex gap-6 mb-4 text-sm">
                    <div class="flex items-center gap-2">
                        <div class="w-4 h-4 bg-green-500 rounded"></div>
                        <span>Available</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <div class="w-4 h-4 bg-blue-500 rounded"></div>
                        <span>Booked</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <div class="w-4 h-4 bg-yellow-500 rounded"></div>
                        <span>Break (5min)</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <div class="w-4 h-4 bg-gray-300 rounded"></div>
                        <span>Unavailable</span>
                    </div>
                </div>

                <!-- Calendar Grid -->
                <div id="calendar" class="overflow-x-auto">
                    <div class="min-w-max">
                        <!-- Days Header -->
                        <div id="daysHeader" class="grid grid-cols-8 gap-2 mb-2">
                            <div class="text-xs font-medium text-gray-500 p-2">Time</div>
                        </div>
                        <!-- Time Slots -->
                        <div id="timeSlots"></div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Slot Details Modal -->
<div id="slotModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-md p-6">
        <h3 class="text-xl font-semibold mb-4">Appointment Slot Details</h3>
        <div id="slotDetails" class="space-y-3 mb-6">
            <p><strong>Doctor:</strong> <span id="slotDoctor"></span></p>
            <p><strong>Date:</strong> <span id="slotDate"></span></p>
            <p><strong>Time:</strong> <span id="slotTime"></span></p>
            <p><strong>Status:</strong> <span id="slotStatus"></span></p>
            <p id="patientInfo" class="hidden"><strong>Patient:</strong> <span id="slotPatient"></span></p>
        </div>
        <div class="flex justify-end gap-3">
            <button id="closeModal" class="px-4 py-2 bg-gray-200 rounded-lg hover:bg-gray-300">Close</button>
            <button id="toggleAvailability" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
                Toggle Availability
            </button>
        </div>
    </div>
</div>

<script>
    // API Configuration
    const API_BASE_URL = '/api'; // Adjust to your API endpoint

    // State Management
    let currentWeekStart = new Date();
    let selectedDoctor = null;
    let availabilityData = [];

    // Set to start of week (Monday)
    currentWeekStart.setDate(currentWeekStart.getDate() - currentWeekStart.getDay() + 1);

    // Initialize
    document.addEventListener('DOMContentLoaded', () => {
        loadDoctors();
        renderCalendar();
        setupEventListeners();
    });

    // Load doctors from API
    async function loadDoctors() {
        try {
            const response = await fetch(`${API_BASE_URL}/doctors`);
            const doctors = await response.json();

            const select = document.getElementById('doctorSelect');
            doctors.forEach(doctor => {
                const option = document.createElement('option');
                option.value = doctor.id;
                option.textContent = `Dr. ${doctor.nom} - ${doctor.specialite}`;
                select.appendChild(option);
            });
        } catch (error) {
            console.error('Error loading doctors:', error);
            showToast('Error loading doctors', 'error');
        }
    }

    // Load availability for selected doctor
    async function loadAvailability(doctorId, weekStart) {
        try {
            const weekEnd = new Date(weekStart);
            weekEnd.setDate(weekEnd.getDate() + 6);

            const response = await fetch(
                `${API_BASE_URL}/availability?doctorId=${doctorId}&start=${weekStart.toISOString()}&end=${weekEnd.toISOString()}`
            );
            availabilityData = await response.json();
            renderTimeSlots();
        } catch (error) {
            console.error('Error loading availability:', error);
            showToast('Error loading availability', 'error');
        }
    }

    // Render calendar
    function renderCalendar() {
        const daysHeader = document.getElementById('daysHeader');
        daysHeader.innerHTML = '<div class="text-xs font-medium text-gray-500 p-2">Time</div>';

        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        for (let i = 0; i < 7; i++) {
            const date = new Date(currentWeekStart);
            date.setDate(date.getDate() + i);

            const dayDiv = document.createElement('div');
            dayDiv.className = 'text-center p-2';
            dayDiv.innerHTML = `
                <div class="text-xs font-medium text-gray-500">${days[i]}</div>
                <div class="text-lg font-semibold text-gray-900">${date.getDate()}</div>
            `;
            daysHeader.appendChild(dayDiv);
        }

        updateWeekRange();
    }

    // Render time slots (8 hours, 30min slots + 5min breaks)
    function renderTimeSlots() {
        const timeSlotsContainer = document.getElementById('timeSlots');
        timeSlotsContainer.innerHTML = '';

        const startHour = 9; // 9 AM
        const endHour = 17; // 5 PM (8 hours)

        for (let hour = startHour; hour < endHour; hour++) {
            // 30-minute appointment slot
            const slot30 = createTimeSlotRow(hour, 0, 30, 'appointment');
            timeSlotsContainer.appendChild(slot30);

            // 5-minute break
            const break5 = createTimeSlotRow(hour, 30, 5, 'break');
            timeSlotsContainer.appendChild(break5);

            // Next 30-minute appointment slot
            const slot30_2 = createTimeSlotRow(hour, 35, 30, 'appointment');
            timeSlotsContainer.appendChild(slot30_2);

            // 5-minute break (if not last hour)
            if (hour < endHour - 1) {
                const break5_2 = createTimeSlotRow(hour, 65, 5, 'break');
                timeSlotsContainer.appendChild(break5_2);
            }
        }
    }

    // Create time slot row
    function createTimeSlotRow(hour, minute, duration, type) {
        const row = document.createElement('div');
        row.className = 'grid grid-cols-8 gap-2 mb-1';

        const timeLabel = document.createElement('div');
        const displayHour = hour % 12 || 12;
        const ampm = hour < 12 ? 'AM' : 'PM';
        timeLabel.className = 'text-xs text-gray-600 p-2 flex items-center';
        timeLabel.textContent = `${displayHour}:${minute.toString().padStart(2, '0')} ${ampm}`;
        row.appendChild(timeLabel);

        for (let day = 0; day < 7; day++) {
            const date = new Date(currentWeekStart);
            date.setDate(date.getDate() + day);
            date.setHours(hour, minute, 0, 0);

            const slot = createSlot(date, duration, type);
            row.appendChild(slot);
        }

        return row;
    }

    // Create individual slot
    function createSlot(date, duration, type) {
        const slot = document.createElement('div');
        slot.className = 'p-2 rounded cursor-pointer transition-all hover:opacity-80';

        // Determine slot status
        const status = getSlotStatus(date, type);

        if (type === 'break') {
            slot.className += ' bg-yellow-100 border border-yellow-300';
            slot.innerHTML = '<span class="text-xs text-yellow-700">Break</span>';
        } else {
            switch (status) {
                case 'available':
                    slot.className += ' bg-green-100 border border-green-300';
                    slot.innerHTML = '<span class="text-xs text-green-700">Available</span>';
                    break;
                case 'booked':
                    slot.className += ' bg-blue-100 border border-blue-300';
                    slot.innerHTML = '<span class="text-xs text-blue-700">Booked</span>';
                    break;
                default:
                    slot.className += ' bg-gray-100 border border-gray-300';
                    slot.innerHTML = '<span class="text-xs text-gray-500">-</span>';
            }
        }

        slot.addEventListener('click', () => openSlotModal(date, type, status));

        return slot;
    }

    // Get slot status from availability data
    function getSlotStatus(date, type) {
        if (type === 'break') return 'break';
        if (!selectedDoctor) return 'unavailable';

        const appointment = availabilityData.find(a =>
            new Date(a.dateTime).getTime() === date.getTime()
        );

        return appointment ? appointment.status : 'available';
    }

    // Open slot modal
    function openSlotModal(date, type, status) {
        if (!selectedDoctor) {
            showToast('Please select a doctor first', 'warning');
            return;
        }

        document.getElementById('slotDoctor').textContent = selectedDoctor.name;
        document.getElementById('slotDate').textContent = date.toLocaleDateString();
        document.getElementById('slotTime').textContent = date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        document.getElementById('slotStatus').textContent = status.toUpperCase();

        if (status === 'booked') {
            document.getElementById('patientInfo').classList.remove('hidden');
            document.getElementById('slotPatient').textContent = 'John Doe'; // From API
        } else {
            document.getElementById('patientInfo').classList.add('hidden');
        }

        document.getElementById('slotModal').classList.remove('hidden');
    }

    // Update week range display
    function updateWeekRange() {
        const weekEnd = new Date(currentWeekStart);
        weekEnd.setDate(weekEnd.getDate() + 6);

        const options = { month: 'short', day: 'numeric', year: 'numeric' };
        const startStr = currentWeekStart.toLocaleDateString('en-US', options);
        const endStr = weekEnd.toLocaleDateString('en-US', options);

        document.getElementById('weekRange').textContent = `Week of ${startStr} - ${endStr}`;
    }

    // Event listeners
    function setupEventListeners() {
        document.getElementById('doctorSelect').addEventListener('change', (e) => {
            selectedDoctor = { id: e.target.value, name: e.target.options[e.target.selectedIndex].text };
            if (selectedDoctor.id) {
                loadAvailability(selectedDoctor.id, currentWeekStart);
            }
        });

        document.getElementById('prevWeek').addEventListener('click', () => {
            currentWeekStart.setDate(currentWeekStart.getDate() - 7);
            renderCalendar();
            if (selectedDoctor) loadAvailability(selectedDoctor.id, currentWeekStart);
        });

        document.getElementById('nextWeek').addEventListener('click', () => {
            currentWeekStart.setDate(currentWeekStart.getDate() + 7);
            renderCalendar();
            if (selectedDoctor) loadAvailability(selectedDoctor.id, currentWeekStart);
        });

        document.getElementById('todayBtn').addEventListener('click', () => {
            currentWeekStart = new Date();
            currentWeekStart.setDate(currentWeekStart.getDate() - currentWeekStart.getDay() + 1);
            renderCalendar();
            if (selectedDoctor) loadAvailability(selectedDoctor.id, currentWeekStart);
        });

        document.getElementById('closeModal').addEventListener('click', () => {
            document.getElementById('slotModal').classList.add('hidden');
        });

        document.getElementById('toggleAvailability').addEventListener('click', async () => {
            // Toggle availability via API
            showToast('Availability updated', 'success');
            document.getElementById('slotModal').classList.add('hidden');
        });
    }

    // Toast notification
    function showToast(message, type = 'success') {
        const toast = document.createElement('div');
        toast.className = `fixed bottom-6 right-6 px-6 py-3 rounded-lg shadow-lg text-white ${
            type == 'success' ? 'bg-green-600' : type == 'error' ? 'bg-red-600' : 'bg-yellow-600'
        }`;
        toast.textContent = message;
        document.body.appendChild(toast);

        setTimeout(() => {
            toast.remove();
        }, 3000);
    }
</script>
</body>
</html>