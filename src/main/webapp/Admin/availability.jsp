<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Digital Clinic</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        /* Steps Progress */
        .step-circle {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.125rem;
            transition: all 0.3s ease;
        }

        .step-circle.active {
            background: #3b82f6;
            color: white;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.4);
        }

        .step-circle.completed {
            background: #10b981;
            color: white;
        }

        .step-circle.inactive {
            background: #e5e7eb;
            color: #9ca3af;
        }

        .step-line {
            height: 3px;
            flex: 1;
            margin: 0 10px;
            transition: all 0.3s ease;
        }

        .step-line.completed {
            background: #10b981;
        }

        .step-line.inactive {
            background: #e5e7eb;
        }

        /* Date Slider */
        .date-card {
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 90px;
        }

        .date-card:hover:not(.disabled) {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .date-card.selected {
            background: #3b82f6 !important;
            color: white !important;
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
        }

        .date-card.selected .day-name,
        .date-card.selected .day-number {
            color: white !important;
        }

        .date-card.disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }

        /* Time Slots */
        .time-slot {
            cursor: pointer;
            transition: all 0.2s ease;
            border: 2px solid #e5e7eb;
            background: white;
            padding: 10px 16px;
            border-radius: 8px;
            font-weight: 600;
            text-align: center;
        }

        .time-slot:hover:not(.disabled) {
            border-color: #3b82f6;
            background: #eff6ff;
        }

        .time-slot.selected {
            background: #3b82f6;
            color: white;
            border-color: #3b82f6;
        }

        .time-slot.disabled {
            background: #f3f4f6;
            color: #9ca3af;
            cursor: not-allowed;
            opacity: 0.5;
        }

        /* Slider */
        .slider-container {
            overflow-x: auto;
            overflow-y: hidden;
            scroll-behavior: smooth;
        }

        .slider-container::-webkit-scrollbar {
            height: 6px;
        }

        .slider-container::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 3px;
        }

        .slider-container::-webkit-scrollbar-thumb {
            background: #3b82f6;
            border-radius: 3px;
        }

        /* Department Cards */
        .dept-card {
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .dept-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .dept-card.selected {
            border-color: #3b82f6;
            background: #eff6ff;
        }

        /* Doctor Cards */
        .doctor-card {
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .doctor-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .doctor-card.selected {
            border-color: #3b82f6;
            background: #eff6ff;
        }
    </style>
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
            <a href="book-appointment.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-blue-700 mb-2">
                <i class="fas fa-calendar-plus"></i><span>Book Appointment</span>
            </a>
            <a href="appointments.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
                <i class="fas fa-calendar-check"></i><span>Appointments</span>
            </a>
            <a href="departments.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
                <i class="fas fa-building"></i><span>Departments</span>
            </a>
        </nav>

        <div class="p-4 border-t border-blue-500">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-blue-700 rounded-full flex items-center justify-center text-white font-bold">
                    A
                </div>
                <div>
                    <p class="text-sm font-semibold">anouar36</p>
                    <p class="text-xs text-blue-200">Patient</p>
                </div>
            </div>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 overflow-auto">
        <header class="bg-white border-b border-gray-200 px-8 py-4">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-2xl font-bold text-gray-900">Book Appointment</h2>
                    <p class="text-sm text-gray-600">Schedule your medical consultation</p>
                </div>
                <div class="flex items-center gap-4">
                    <button class="relative p-2 text-gray-600 hover:text-gray-900">
                        <i class="fas fa-bell text-xl"></i>
                        <span class="absolute top-0 right-0 w-2 h-2 bg-red-500 rounded-full"></span>
                    </button>
                    <div class="flex items-center gap-3">
                        <img src="/assets/img/admin-avatar.png" alt="Admin" class="w-10 h-10 rounded-full">
                        <div>
                            <p class="text-sm font-medium text-gray-900">anouar36</p>
                            <p class="text-xs text-gray-500">Patient</p>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div class="p-8">
            <!-- Steps Progress -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center">
                        <div id="step1Circle" class="step-circle active">1</div>
                        <div id="line1" class="step-line inactive"></div>
                    </div>
                    <div class="flex items-center">
                        <div id="step2Circle" class="step-circle inactive">2</div>
                        <div id="line2" class="step-line inactive"></div>
                    </div>
                    <div class="flex items-center">
                        <div id="step3Circle" class="step-circle inactive">3</div>
                        <div id="line3" class="step-line inactive"></div>
                    </div>
                    <div class="flex items-center">
                        <div id="step4Circle" class="step-circle inactive">4</div>
                    </div>
                </div>

                <div class="flex justify-between text-sm">
                    <p id="step1Label" class="font-semibold text-blue-600">Specialty</p>
                    <p id="step2Label" class="font-semibold text-gray-400">Doctor</p>
                    <p id="step3Label" class="font-semibold text-gray-400">Date & Time</p>
                    <p id="step4Label" class="font-semibold text-gray-400">Confirmation</p>
                </div>
            </div>

            <!-- Step 1: Specialty Selection -->
            <div id="step1Content" class="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                <h3 class="text-2xl font-bold text-gray-900 mb-2">Choose Specialty</h3>
                <p class="text-gray-600 mb-6">Select the medical specialty you need</p>

                <div id="departmentsList" class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <!-- Populated by JS -->
                </div>
            </div>

            <!-- Step 2: Doctor Selection -->
            <div id="step2Content" class="hidden bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                <button onclick="goToStep(1)" class="mb-4 flex items-center gap-2 text-gray-600 hover:text-gray-900">
                    <i class="fas fa-arrow-left"></i>
                    <span class="font-semibold">Back</span>
                </button>

                <h3 class="text-2xl font-bold text-gray-900 mb-2">Choose Your Doctor</h3>
                <p class="text-gray-600 mb-6">Select a doctor from <span id="selectedSpecialtyName" class="font-semibold text-blue-600"></span></p>

                <div id="doctorsList" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    <!-- Populated by JS -->
                </div>
            </div>

            <!-- Step 3: Date & Time Selection -->
            <div id="step3Content" class="hidden bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                <button onclick="goToStep(2)" class="mb-4 flex items-center gap-2 text-gray-600 hover:text-gray-900">
                    <i class="fas fa-arrow-left"></i>
                    <span class="font-semibold">Back</span>
                </button>

                <h3 class="text-2xl font-bold text-gray-900 mb-2">Choose Your Appointment Time</h3>
                <p class="text-gray-600 mb-6">Select a date and available time (minimum 2 hours in advance)</p>

                <!-- Selected Doctor Info -->
                <div class="bg-blue-50 border-l-4 border-blue-600 p-4 mb-6 rounded">
                    <div class="flex items-center gap-3">
                        <i class="fas fa-user-md text-blue-600 text-xl"></i>
                        <div>
                            <p class="text-sm text-gray-600">Selected Doctor</p>
                            <p class="font-bold text-gray-900" id="selectedDoctorInfo"></p>
                        </div>
                    </div>
                </div>

                <!-- Week Navigation -->
                <div class="flex items-center justify-between mb-6">
                    <button id="prevWeek" class="w-10 h-10 rounded-lg bg-gray-100 hover:bg-gray-200 flex items-center justify-center">
                        <i class="fas fa-chevron-left text-gray-600"></i>
                    </button>
                    <h4 id="weekRange" class="text-xl font-bold text-gray-900">20 Oct - 26 Oct 2025</h4>
                    <button id="nextWeek" class="w-10 h-10 rounded-lg bg-gray-100 hover:bg-gray-200 flex items-center justify-center">
                        <i class="fas fa-chevron-right text-gray-600"></i>
                    </button>
                </div>

                <!-- Date Slider -->
                <div class="slider-container mb-8 pb-4">
                    <div id="dateSlider" class="flex gap-4">
                        <!-- Populated by JS -->
                    </div>
                </div>

                <!-- Time Slots -->
                <div id="timeSlotsContainer" class="hidden">
                    <h4 class="text-lg font-bold text-gray-900 mb-4">Available Time Slots</h4>

                    <div class="mb-6">
                        <p class="text-sm font-semibold text-gray-600 mb-3 uppercase">
                            <i class="fas fa-sun text-yellow-500 mr-2"></i>Morning (9:00 AM - 12:00 PM)
                        </p>
                        <div id="morningSlots" class="grid grid-cols-6 gap-3"></div>
                    </div>

                    <div class="mb-8">
                        <p class="text-sm font-semibold text-gray-600 mb-3 uppercase">
                            <i class="fas fa-cloud-sun text-orange-500 mr-2"></i>Afternoon (2:00 PM - 5:00 PM)
                        </p>
                        <div id="afternoonSlots" class="grid grid-cols-6 gap-3"></div>
                    </div>

                    <div class="flex justify-end">
                        <button id="continueBtn" disabled class="px-8 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed">
                            Continue to Confirmation
                            <i class="fas fa-arrow-right ml-2"></i>
                        </button>
                    </div>
                </div>

                <div id="selectDateNotice" class="text-center py-12">
                    <i class="fas fa-calendar-alt text-gray-300 text-6xl mb-4"></i>
                    <p class="text-gray-500 text-lg">Please select a date to view available times</p>
                </div>
            </div>

            <!-- Step 4: Confirmation -->
            <div id="step4Content" class="hidden bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                <button onclick="goToStep(3)" class="mb-4 flex items-center gap-2 text-gray-600 hover:text-gray-900">
                    <i class="fas fa-arrow-left"></i>
                    <span class="font-semibold">Back</span>
                </button>

                <h3 class="text-2xl font-bold text-gray-900 mb-2">Confirm Your Appointment</h3>
                <p class="text-gray-600 mb-6">Please review your appointment details and confirm</p>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- Summary -->
                    <div>
                        <h4 class="text-lg font-semibold text-gray-900 mb-4">Appointment Details</h4>
                        <div class="bg-gray-50 border border-gray-200 rounded-lg p-6 space-y-4">
                            <div class="flex items-start gap-3">
                                <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-building text-white"></i>
                                </div>
                                <div>
                                    <p class="text-xs text-gray-600">Specialty</p>
                                    <p class="font-bold text-gray-900" id="confirmSpecialty"></p>
                                </div>
                            </div>
                            <div class="flex items-start gap-3">
                                <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-user-md text-white"></i>
                                </div>
                                <div>
                                    <p class="text-xs text-gray-600">Doctor</p>
                                    <p class="font-bold text-gray-900" id="confirmDoctor"></p>
                                </div>
                            </div>
                            <div class="flex items-start gap-3">
                                <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-calendar text-white"></i>
                                </div>
                                <div>
                                    <p class="text-xs text-gray-600">Date</p>
                                    <p class="font-bold text-gray-900" id="confirmDate"></p>
                                </div>
                            </div>
                            <div class="flex items-start gap-3">
                                <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-clock text-white"></i>
                                </div>
                                <div>
                                    <p class="text-xs text-gray-600">Time</p>
                                    <p class="font-bold text-gray-900" id="confirmTime"></p>
                                </div>
                            </div>
                            <div class="flex items-start gap-3">
                                <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-hourglass-half text-white"></i>
                                </div>
                                <div>
                                    <p class="text-xs text-gray-600">Duration</p>
                                    <p class="font-bold text-gray-900">30 minutes</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Patient Form -->
                    <div>
                        <h4 class="text-lg font-semibold text-gray-900 mb-4">Your Information</h4>
                        <form id="patientForm" class="space-y-4">
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1">
                                    Full Name <span class="text-red-600">*</span>
                                </label>
                                <input type="text" id="patientName" required
                                       class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1">
                                    Email <span class="text-red-600">*</span>
                                </label>
                                <input type="email" id="patientEmail" required
                                       class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1">
                                    Phone <span class="text-red-600">*</span>
                                </label>
                                <input type="tel" id="patientPhone" required
                                       class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-1">
                                    Reason for Visit
                                </label>
                                <textarea id="visitReason" rows="3"
                                          class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"></textarea>
                            </div>
                            <button type="submit" class="w-full px-6 py-3 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-700">
                                <i class="fas fa-check mr-2"></i>Confirm Appointment
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Success Modal -->
<div id="successModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
    <div class="bg-white rounded-xl shadow-lg max-w-md w-full p-8">
        <div class="text-center mb-6">
            <div class="w-20 h-20 bg-green-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-check text-white text-4xl"></i>
            </div>
            <h3 class="text-2xl font-bold text-gray-900 mb-2">Appointment Confirmed!</h3>
            <p class="text-gray-600">Your appointment has been successfully booked.</p>
        </div>

        <div class="bg-gray-50 border border-gray-200 rounded-lg p-4 mb-6 text-sm" id="successDetails"></div>

        <div class="flex gap-3">
            <button onclick="window.location.href='dashboard.jsp'" class="flex-1 px-4 py-2 border-2 border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50">
                Go to Dashboard
            </button>
            <button onclick="window.location.reload()" class="flex-1 px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700">
                Book Another
            </button>
        </div>
    </div>
</div>

<script>
    // FAKE DATA
    const DEPARTMENTS = [
        { id: 1, code: 'GEN', nom: 'General Medicine', icon: 'fa-stethoscope', color: 'emerald' },
        { id: 2, code: 'CARD', nom: 'Cardiology', icon: 'fa-heartbeat', color: 'red' },
        { id: 3, code: 'PED', nom: 'Pediatrics', icon: 'fa-baby', color: 'pink' },
        { id: 4, code: 'NEU', nom: 'Neurology', icon: 'fa-brain', color: 'purple' },
        { id: 5, code: 'ORT', nom: 'Orthopedics', icon: 'fa-bone', color: 'orange' },
        { id: 6, code: 'DER', nom: 'Dermatology', icon: 'fa-hand-sparkles', color: 'teal' }
    ];

    const DOCTORS = {
        1: [
            { id: 1, nom: 'Dr. Sarah Johnson', titre: 'General Practitioner', experience: '15 years' },
            { id: 2, nom: 'Dr. Michael Chen', titre: 'Family Medicine', experience: '12 years' }
        ],
        2: [
            { id: 3, nom: 'Dr. Emily Williams', titre: 'Cardiologist', experience: '18 years' },
            { id: 4, nom: 'Dr. David Martinez', titre: 'Cardiology Specialist', experience: '14 years' }
        ],
        3: [
            { id: 5, nom: 'Dr. Lisa Anderson', titre: 'Pediatrician', experience: '10 years' }
        ],
        4: [
            { id: 6, nom: 'Dr. James Wilson', titre: 'Neurologist', experience: '16 years' }
        ],
        5: [
            { id: 7, nom: 'Dr. Maria Garcia', titre: 'Orthopedic Surgeon', experience: '20 years' }
        ],
        6: [
            { id: 8, nom: 'Dr. Robert Taylor', titre: 'Dermatologist', experience: '13 years' }
        ]
    };

    // State
    let currentStep = 1;
    let selectedDepartment = null;
    let selectedDoctor = null;
    let selectedDate = null;
    let selectedTime = null;
    let currentWeekStart = new Date(2025, 9, 20); // October 20, 2025

    // Initialize
    document.addEventListener('DOMContentLoaded', () => {
        loadDepartments();
    });

    // Load Departments
    function loadDepartments() {
        const container = document.getElementById('departmentsList');
        container.innerHTML = DEPARTMENTS.map(dept => `
            <div onclick='selectDepartment(${JSON.stringify(dept)})' 
                 class="dept-card p-6 border-2 border-gray-200 rounded-xl hover:shadow-lg transition">
                <div class="flex items-center gap-4 mb-3">
                    <div class="w-14 h-14 bg-${dept.color}-100 rounded-lg flex items-center justify-center">
                        <i class="fas ${dept.icon} text-${dept.color}-600 text-2xl"></i>
                    </div>
                    <div>
                        <h4 class="font-bold text-gray-900">${dept.nom}</h4>
                        <p class="text-sm text-gray-600">${dept.code}</p>
                    </div>
                </div>
            </div>
        `).join('');
    }

    function selectDepartment(dept) {
        selectedDepartment = dept;
        document.getElementById('selectedSpecialtyName').textContent = dept.nom;
        loadDoctors(dept.id);
        goToStep(2);
    }

    function loadDoctors(deptId) {
        const doctors = DOCTORS[deptId] || [];
        const container = document.getElementById('doctorsList');

        container.innerHTML = doctors.map(doc => `
            <div onclick='selectDoctor(${JSON.stringify(doc)})' 
                 class="doctor-card p-6 border-2 border-gray-200 rounded-xl hover:shadow-lg transition">
                <div class="flex items-center gap-4 mb-3">
                    <div class="w-14 h-14 bg-blue-100 rounded-full flex items-center justify-center">
                        <i class="fas fa-user-md text-blue-600 text-2xl"></i>
                    </div>
                    <div class="flex-1">
                        <h4 class="font-bold text-gray-900">${doc.nom}</h4>
                        <p class="text-sm text-gray-600">${doc.titre}</p>
                        <p class="text-xs text-gray-500 mt-1">
                            <i class="fas fa-briefcase mr-1"></i>${doc.experience}
                        </p>
                    </div>
                </div>
            </div>
        `).join('');
    }

    function selectDoctor(doc) {
        selectedDoctor = doc;
        document.getElementById('selectedDoctorInfo').textContent = `${doc.nom} - ${doc.titre}`;
        renderWeekSlider();
        goToStep(3);
    }

    function renderWeekSlider() {
        const slider = document.getElementById('dateSlider');
        slider.innerHTML = '';

        const days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

        for (let i = 0; i < 7; i++) {
            const date = new Date(currentWeekStart);
            date.setDate(date.getDate() + i);

            const today = new Date(2025, 9, 16);
            const isPast = date < today;
            const isWeekend = date.getDay() === 0 || date.getDay() === 6;
            const isSelected = selectedDate && date.toDateString() === selectedDate.toDateString();

            const card = document.createElement('div');
            card.className = `date-card bg-white border-2 border-gray-200 rounded-xl p-4 text-center ${
                isPast || isWeekend ? 'disabled' : ''
            } ${isSelected ? 'selected' : ''}`;

            card.innerHTML = `
                <p class="day-name text-xs font-semibold text-gray-500 mb-2">${days[date.getDay()]}</p>
                <p class="day-number text-2xl font-bold text-gray-900">${date.getDate()}</p>
            `;

            if (!isPast && !isWeekend) {
                card.onclick = () => selectDate(date);
            }

            slider.appendChild(card);
        }

        updateWeekRange();
    }

    function selectDate(date) {
        selectedDate = date;
        selectedTime = null;
        renderWeekSlider();
        loadTimeSlots();
    }

    function loadTimeSlots() {
        document.getElementById('selectDateNotice').classList.add('hidden');
        document.getElementById('timeSlotsContainer').classList.remove('hidden');

        const morning = document.getElementById('morningSlots');
        const afternoon = document.getElementById('afternoonSlots');

        morning.innerHTML = '';
        afternoon.innerHTML = '';

        const morningTimes = ['09:00', '09:35', '10:10', '10:45', '11:20', '11:55'];

        morningTimes.forEach(time => {
            const available = Math.random() > 0.3;
            const slot = document.createElement('button');
            slot.className = `time-slot ${available ? '' : 'disabled'} ${selectedTime == time ? 'selected' : ''}`;
            slot.textContent = time;

            if (available) {
                slot.onclick = () => selectTime(time);
            } else {
                slot.disabled = true;
            }

            morning.appendChild(slot);
        });

        const afternoonTimes = ['14:00', '14:35', '15:10', '15:45', '16:20', '16:55'];

        afternoonTimes.forEach(time => {
            const available = Math.random() > 0.3;
            const slot = document.createElement('button');
            slot.className = `time-slot ${available ? '' : 'disabled'} ${selectedTime == time ? 'selected' : ''}`;
            slot.textContent = time;

            if (available) {
                slot.onclick = () => selectTime(time);
            } else {
                slot.disabled = true;
            }

            afternoon.appendChild(slot);
        });
    }

    function selectTime(time) {
        selectedTime = time;
        loadTimeSlots();
        document.getElementById('continueBtn').disabled = false;
    }

    function updateWeekRange() {
        const weekEnd = new Date(currentWeekStart);
        weekEnd.setDate(weekEnd.getDate() + 6);

        const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        const startStr = `${currentWeekStart.getDate()} ${monthNames[currentWeekStart.getMonth()]}`;
        const endStr = `${weekEnd.getDate()} ${monthNames[weekEnd.getMonth()]} ${weekEnd.getFullYear()}`;

        document.getElementById('weekRange').textContent = `${startStr} - ${endStr}`;
    }

    function goToStep(step) {
        currentStep = step;

        // Hide all steps
        for (let i = 1; i <= 4; i++) {
            document.getElementById(`step${i}Content`).classList.add('hidden');
        }

        // Show current step
        document.getElementById(`step${step}Content`).classList.remove('hidden');

        // Update progress
        for (let i = 1; i <= 4; i++) {
            const circle = document.getElementById(`step${i}Circle`);
            const label = document.getElementById(`step${i}Label`);
            const line = document.getElementById(`line${i}`);

            if (i < step) {
                circle.className = 'step-circle completed';
                circle.innerHTML = '<i class="fas fa-check"></i>';
                label.className = 'font-semibold text-green-600';
                if (line) line.className = 'step-line completed';
            } else if (i === step) {
                circle.className = 'step-circle active';
                circle.textContent = i;
                label.className = 'font-semibold text-blue-600';
            } else {
                circle.className = 'step-circle inactive';
                circle.textContent = i;
                label.className = 'font-semibold text-gray-400';
                if (line) line.className = 'step-line inactive';
            }
        }

        // Populate confirmation
        if (step === 4) {
            document.getElementById('confirmSpecialty').textContent = selectedDepartment.nom;
            document.getElementById('confirmDoctor').textContent = selectedDoctor.nom;
            document.getElementById('confirmDate').textContent = selectedDate.toLocaleDateString('en-US', {
                weekday: 'long',
                month: 'long',
                day: 'numeric',
                year: 'numeric'
            });
            document.getElementById('confirmTime').textContent = selectedTime;
        }
    }

    // Event Listeners
    document.getElementById('prevWeek').addEventListener('click', () => {
        currentWeekStart.setDate(currentWeekStart.getDate() - 7);
        renderWeekSlider();
    });

    document.getElementById('nextWeek').addEventListener('click', () => {
        currentWeekStart.setDate(currentWeekStart.getDate() + 7);
        renderWeekSlider();
    });

    document.getElementById('continueBtn').addEventListener('click', () => {
        goToStep(4);
    });

    document.getElementById('patientForm').addEventListener('submit', (e) => {
        e.preventDefault();

        const details = `
            <p class="font-semibold mb-2">${selectedDepartment.nom}</p>
            <p class="mb-2">${selectedDoctor.nom}</p>
            <p class="mb-2">${selectedDate.toLocaleDateString()} at ${selectedTime}</p>
            <hr class="my-2">
            <p><strong>Patient:</strong> ${document.getElementById('patientName').value}</p>
            <p><strong>Email:</strong> ${document.getElementById('patientEmail').value}</p>
        `;

        document.getElementById('successDetails').innerHTML = details;
        document.getElementById('successModal').classList.remove('hidden');
    });
</script>
</body>
</html>