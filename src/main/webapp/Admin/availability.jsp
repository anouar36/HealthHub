<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        * { font-family: 'Inter', sans-serif; margin: 0; padding: 0; box-sizing: border-box; }

        .step-circle { width: 50px; height: 50px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 1.125rem; transition: all 0.3s ease; }
        .step-circle.active { background: #3b82f6; color: white; box-shadow: 0 4px 15px rgba(59, 130, 246, 0.4); }
        .step-circle.completed { background: #10b981; color: white; }
        .step-circle.inactive { background: #e5e7eb; color: #9ca3af; }
        .step-line { height: 3px; flex: 1; margin: 0 10px; transition: all 0.3s ease; }
        .step-line.completed { background: #10b981; }
        .step-line.inactive { background: #e5e7eb; }

        .date-card { cursor: pointer; transition: all 0.3s ease; min-width: 100px; height: 100px; display: flex; flex-direction: column; align-items: center; justify-content: center; border: 2px solid #e5e7eb; border-radius: 12px; background: white; text-decoration: none; }
        .date-card:hover:not(.disabled) { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); border-color: #3b82f6; }
        .date-card.selected { background: #3b82f6 !important; border-color: #3b82f6; box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4); }
        .date-card.selected .day-name, .date-card.selected .day-number { color: white !important; }
        .date-card.disabled { opacity: 0.4; cursor: not-allowed; background: #f9fafb; }
        .day-name { font-size: 0.75rem; font-weight: 600; color: #6b7280; text-transform: uppercase; margin-bottom: 4px; }
        .day-number { font-size: 1.875rem; font-weight: 700; color: #111827; line-height: 1; }
        .date-slider-wrapper { display: flex; justify-content: center; align-items: center; gap: 12px; max-width: 900px; margin: 0 auto 2rem auto; flex-wrap: wrap; }

        .time-slot { cursor: pointer; transition: all 0.2s ease; border: 2px solid #e5e7eb; background: white; padding: 12px 16px; border-radius: 8px; font-weight: 600; text-align: center; font-size: 0.875rem; }
        .time-slot:hover:not(:disabled) { border-color: #3b82f6; background: #eff6ff; transform: translateY(-2px); }
        .time-slot:disabled { background: #f3f4f6; color: #9ca3af; cursor: not-allowed; opacity: 0.5; }
        .time-slots-section { margin-bottom: 1.5rem; }
        .time-slots-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(90px, 1fr)); gap: 10px; max-width: 700px; margin: 0 auto; }

        .dept-card, .doctor-card { cursor: pointer; transition: all 0.3s ease; text-decoration: none; color: inherit; display: block; }
        .dept-card:hover, .doctor-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); }

        main { height: 100vh; overflow-y: auto; }
        .content-wrapper { max-width: 1200px; margin: 0 auto; }
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
        <header class="bg-white border-b border-gray-200 px-8 py-4 sticky top-0 z-10">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-2xl font-bold text-gray-900">Book Appointment</h2>
                    <p class="text-sm text-gray-600">Schedule your medical consultation</p>
                </div>
                <div class="flex items-center gap-3">
                    <div class="w-10 h-10 bg-gray-300 rounded-full flex items-center justify-center text-white font-bold">A</div>
                    <div><p class="text-sm font-medium text-gray-900">anouar36</p><p class="text-xs text-gray-500">Patient</p></div>
                </div>
            </div>
        </header>

        <div class="p-8 content-wrapper">
            <!-- ✅ Success Message -->
            <c:if test="${param.success == 'true'}">
                <div class="fixed top-4 right-4 bg-green-50 border-l-4 border-green-600 p-6 rounded-lg shadow-2xl max-w-md animate-slide-in z-50">
                    <div class="flex items-start gap-4">
                        <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-check text-green-600 text-2xl"></i>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-xl font-bold text-green-900 mb-2">
                                <i class="fas fa-calendar-check mr-2"></i>Appointment Confirmed!
                            </h3>
                            <p class="text-green-800 mb-3">Your appointment has been successfully booked.</p>
                            <div class="bg-white p-4 rounded-lg border border-green-200 mb-4">
                                <p class="text-sm text-gray-600 mb-1">
                                    <i class="fas fa-calendar text-green-600 mr-2"></i><strong>Date:</strong> ${param.date}
                                </p>
                                <p class="text-sm text-gray-600">
                                    <i class="fas fa-clock text-green-600 mr-2"></i><strong>Time:</strong> ${param.time}
                                </p>
                            </div>
                            <div class="flex gap-3">
                                <a href="${pageContext.request.contextPath}/user/dashboard"
                                   class="flex-1 bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition text-center text-sm font-semibold">
                                    <i class="fas fa-home mr-2"></i>Dashboard
                                </a>
                                <a href="${pageContext.request.contextPath}/user/availabilities"
                                   class="flex-1 bg-white text-green-600 border-2 border-green-600 px-4 py-2 rounded-lg hover:bg-green-50 transition text-center text-sm font-semibold">
                                    <i class="fas fa-plus mr-2"></i>Book Another
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <style>
                    @keyframes slide-in { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
                    .animate-slide-in { animation: slide-in 0.5s ease-out; }
                </style>
            </c:if>

            <!-- ✅ Error Messages -->
            <c:if test="${not empty param.error}">
                <div class="fixed top-4 right-4 bg-red-50 border-l-4 border-red-600 p-6 rounded-lg shadow-2xl max-w-md z-50">
                    <div class="flex items-start gap-4">
                        <div class="w-12 h-12 bg-red-100 rounded-full flex items-center justify-center">
                            <i class="fas fa-exclamation-triangle text-red-600 text-2xl"></i>
                        </div>
                        <div>
                            <h3 class="text-lg font-bold text-red-900 mb-2">Booking Failed</h3>
                            <p class="text-red-800 text-sm">
                                <c:choose>
                                    <c:when test="${param.error == 'booking-failed'}">This time slot is no longer available.</c:when>
                                    <c:when test="${param.error == 'missing-params'}">Please select a valid date and time.</c:when>
                                    <c:when test="${param.error == 'patient-not-found'}">Account not found. Contact support.</c:when>
                                    <c:otherwise>An unexpected error occurred.</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Steps Progress -->
            <c:set var="currentStep" value="${param.step != null ? param.step : '1'}" />
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex flex-col items-center flex-1">
                        <div class="flex items-center w-full justify-center">
                            <div class="step-circle ${currentStep >= 1 ? (currentStep > 1 ? 'completed' : 'active') : 'inactive'}">
                                <c:choose>
                                    <c:when test="${currentStep > 1}"><i class="fas fa-check"></i></c:when>
                                    <c:otherwise>1</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="step-line ${currentStep > 1 ? 'completed' : 'inactive'} flex-1"></div>
                        </div>
                    </div>
                    <div class="flex flex-col items-center flex-1">
                        <div class="flex items-center w-full justify-center">
                            <div class="step-circle ${currentStep >= 2 ? (currentStep > 2 ? 'completed' : 'active') : 'inactive'}">
                                <c:choose>
                                    <c:when test="${currentStep > 2}"><i class="fas fa-check"></i></c:when>
                                    <c:otherwise>2</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="step-line ${currentStep > 2 ? 'completed' : 'inactive'} flex-1"></div>
                        </div>
                    </div>
                    <div class="flex flex-col items-center flex-1">
                        <div class="flex items-center w-full justify-center">
                            <div class="step-circle ${currentStep >= 3 ? 'active' : 'inactive'}">3</div>
                        </div>
                    </div>
                </div>
                <div class="flex justify-between text-sm">
                    <p class="font-semibold ${currentStep == 1 ? 'text-blue-600' : (currentStep > 1 ? 'text-green-600' : 'text-gray-400')} flex-1 text-center">Specialty</p>
                    <p class="font-semibold ${currentStep == 2 ? 'text-blue-600' : (currentStep > 2 ? 'text-green-600' : 'text-gray-400')} flex-1 text-center">Doctor</p>
                    <p class="font-semibold ${currentStep == 3 ? 'text-blue-600' : 'text-gray-400'} flex-1 text-center">Date & Time</p>
                </div>
            </div>

            <!-- STEP 1: Departments -->
            <c:if test="${empty param.step || param.step == '1'}">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                    <h3 class="text-2xl font-bold text-gray-900 mb-2">Choose Specialty</h3>
                    <p class="text-gray-600 mb-6">Select the medical specialty you need</p>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <c:choose>
                            <c:when test="${empty departments}">
                                <p class="text-sm text-gray-500 col-span-3">No departments available.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="dept" items="${departments}">
                                    <a href="?step=2&deptCode=${dept.code}" class="dept-card p-6 border-2 border-gray-200 rounded-xl hover:shadow-lg transition">
                                        <div class="flex items-center gap-4 mb-3">
                                            <div class="w-14 h-14 bg-blue-100 rounded-lg flex items-center justify-center">
                                                <i class="fas fa-stethoscope text-blue-600 text-2xl"></i>
                                            </div>
                                            <div>
                                                <h4 class="font-bold text-gray-900">${dept.nom}</h4>
                                                <p class="text-sm text-gray-600">${dept.code}</p>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>

            <!-- STEP 2: Doctors -->
            <c:if test="${param.step == '2' && not empty param.deptCode}">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                    <a href="?step=1" class="mb-4 inline-flex items-center gap-2 text-gray-600 hover:text-gray-900">
                        <i class="fas fa-arrow-left"></i><span class="font-semibold">Back</span>
                    </a>
                    <h3 class="text-2xl font-bold text-gray-900 mb-2">Choose Your Doctor</h3>
                    <p class="text-gray-600 mb-6">Select a doctor</p>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        <c:set var="doctors" value="${doctorsByDept[param.deptCode]}" />
                        <c:choose>
                            <c:when test="${empty doctors}">
                                <p class="text-sm text-gray-500 col-span-3">No doctors available.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="doc" items="${doctors}">
                                    <a href="?step=3&deptCode=${param.deptCode}&doctorId=${doc.id}" class="doctor-card p-6 border-2 border-gray-200 rounded-xl hover:shadow-lg transition">
                                        <div class="flex items-center gap-4 mb-3">
                                            <div class="w-14 h-14 bg-blue-100 rounded-full flex items-center justify-center">
                                                <i class="fas fa-user-md text-blue-600 text-2xl"></i>
                                            </div>
                                            <div class="flex-1">
                                                <h4 class="font-bold text-gray-900">${doc.nom}</h4>
                                                <p class="text-sm text-gray-600">${doc.titre}</p>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>

            <!-- STEP 3: Date & Time -->
            <c:if test="${param.step == '3' && not empty param.doctorId}">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                    <a href="?step=2&deptCode=${param.deptCode}" class="mb-4 inline-flex items-center gap-2 text-gray-600 hover:text-gray-900">
                        <i class="fas fa-arrow-left"></i><span class="font-semibold">Back</span>
                    </a>
                    <h3 class="text-2xl font-bold text-gray-900 mb-2">Choose Appointment Time</h3>
                    <p class="text-gray-600 mb-6">Select a date and available time</p>

                    <!-- Week Navigation -->
                    <div class="flex items-center justify-center gap-6 mb-6">
                        <a href="?step=3&deptCode=${param.deptCode}&doctorId=${param.doctorId}&weekOffset=${weekOffset - 1}"
                           class="w-10 h-10 rounded-lg bg-gray-100 hover:bg-gray-200 flex items-center justify-center">
                            <i class="fas fa-chevron-left text-gray-600"></i>
                        </a>
                        <h4 class="text-xl font-bold text-gray-900 min-w-[250px] text-center">
                            <c:if test="${not empty weekDates}">
                                <c:set var="firstDate" value="${weekDates[0]}" />
                                <c:set var="lastDate" value="${weekDates[6]}" />
                                ${firstDate.dayOfMonth} ${fn:substring(firstDate.monthName, 0, 3)} -
                                ${lastDate.dayOfMonth} ${fn:substring(lastDate.monthName, 0, 3)} ${firstDate.year}
                            </c:if>
                        </h4>
                        <a href="?step=3&deptCode=${param.deptCode}&doctorId=${param.doctorId}&weekOffset=${weekOffset + 1}"
                           class="w-10 h-10 rounded-lg bg-gray-100 hover:bg-gray-200 flex items-center justify-center">
                            <i class="fas fa-chevron-right text-gray-600"></i>
                        </a>
                    </div>

                    <!-- ✅ Date Slider (FROM BACKEND) -->
                    <div class="date-slider-wrapper mb-8">
                        <c:choose>
                            <c:when test="${empty weekDates}">
                                <p class="text-gray-500">No dates available</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="dateInfo" items="${weekDates}">
                                    <c:set var="isDisabled" value="${dateInfo.isPast || dateInfo.isWeekend}" />
                                    <c:set var="isSelected" value="${param.date == dateInfo.date}" />

                                    <a href="?step=3&deptCode=${param.deptCode}&doctorId=${param.doctorId}&date=${dateInfo.date}&weekOffset=${weekOffset}"
                                       class="date-card ${isDisabled ? 'disabled' : ''} ${isSelected ? 'selected' : ''}"
                                        ${isDisabled ? 'onclick="return false;" style="pointer-events:none;"' : ''}>
                                        <p class="day-name">${fn:substring(dateInfo.dayOfWeek, 0, 3)}</p>
                                        <p class="day-number">${dateInfo.dayOfMonth}</p>
                                    </a>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- ✅ Time Slots (FROM BACKEND) -->
                    <c:if test="${not empty param.date}">
                        <div class="mt-8">
                            <h4 class="text-lg font-bold text-gray-900 mb-6 text-center">Available Time Slots</h4>

                            <c:choose>
                                <c:when test="${empty availableSlots}">
                                    <div class="text-center py-8">
                                        <i class="fas fa-calendar-times text-gray-300 text-5xl mb-4"></i>
                                        <p class="text-gray-500">No available slots for this date</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <form method="POST" action="${pageContext.request.contextPath}/user/book-appointment">
                                        <input type="hidden" name="deptCode" value="${param.deptCode}" />
                                        <input type="hidden" name="doctorId" value="${param.doctorId}" />
                                        <input type="hidden" name="date" value="${param.date}" />

                                        <!-- Morning Slots -->
                                        <div class="time-slots-section">
                                            <p class="text-sm font-semibold text-gray-600 mb-3 uppercase text-center">
                                                <i class="fas fa-sun text-yellow-500 mr-2"></i>Morning
                                            </p>
                                            <div class="time-slots-grid">
                                                <c:forEach var="slot" items="${availableSlots}">
                                                    <c:set var="hour" value="${fn:substringBefore(slot, ':')}" />
                                                    <c:if test="${hour < 12}">
                                                        <button type="submit" name="time" value="${slot}" class="time-slot">${slot}</button>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <!-- Afternoon Slots -->
                                        <div class="time-slots-section">
                                            <p class="text-sm font-semibold text-gray-600 mb-3 uppercase text-center">
                                                <i class="fas fa-cloud-sun text-orange-500 mr-2"></i>Afternoon
                                            </p>
                                            <div class="time-slots-grid">
                                                <c:forEach var="slot" items="${availableSlots}">
                                                    <c:set var="hour" value="${fn:substringBefore(slot, ':')}" />
                                                    <c:if test="${hour >= 14}">
                                                        <button type="submit" name="time" value="${slot}" class="time-slot">${slot}</button>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>

                    <c:if test="${empty param.date}">
                        <div class="text-center py-12">
                            <i class="fas fa-calendar-alt text-gray-300 text-6xl mb-4"></i>
                            <p class="text-gray-500 text-lg">Please select a date to view available times</p>
                        </div>
                    </c:if>
                </div>
            </c:if>
        </div>
    </main>
</div>
</body>
</html>