    package org.example.healthhub.controller;

    import jakarta.servlet.RequestDispatcher;
    import jakarta.servlet.http.HttpSession;
    import org.example.healthhub.dto.AvailabilityDTO.AvailabilityDTO;
    import org.example.healthhub.dto.Department.DepartmentCreatDTO;
    import org.example.healthhub.dto.Department.DepartmentDTO;
    import org.example.healthhub.dto.Doctor.DoctorCreateDTO;
    import org.example.healthhub.dto.Doctor.DoctorDepartmentSpecialtyDTO;
    import org.example.healthhub.dto.Doctor.DoctorUpdateDTO;
    import org.example.healthhub.dto.DoctorDTO;
    import org.example.healthhub.dto.Patient.PatientCreateDTO;
    import org.example.healthhub.dto.Patient.PatientDTO;
    import org.example.healthhub.dto.Patient.PatientUpdateDTO;
    import org.example.healthhub.dto.Specialty.SpecialtyCreateDTO;
    import org.example.healthhub.dto.UserRegisterRequestDTO;
    import org.example.healthhub.dto.UserRequestDTO;
    import org.example.healthhub.dto.UserResponseDTO;
    import org.example.healthhub.entity.Availability;
    import org.example.healthhub.entity.Patient;
    import org.example.healthhub.entity.User;
    import org.example.healthhub.mapper.DoctorResponseDto;
    import org.example.healthhub.repository.Enums.Role;
    import org.example.healthhub.repository.implement.AvailabilityDAO;
    import org.example.healthhub.repository.implement.UserDAO;

    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import org.example.healthhub.service.*;


    import java.awt.print.PrinterException;
    import java.io.BufferedReader;
    import java.io.IOException;
    import com.fasterxml.jackson.databind.ObjectMapper;


    import java.time.DayOfWeek;
    import java.time.LocalDate;
    import java.time.LocalTime;
    import java.time.format.DateTimeFormatter;
    import java.util.*;

    @WebServlet("/user/*")
    public class UserController extends HttpServlet {

        private final UserService userService = new UserService();
        private final DoctorService doctorService = new DoctorService();
        private final DepartmentService departmentService = new DepartmentService();
        private final PatientService patientService = new PatientService();
        private final AvailabilityService availabilityService = new AvailabilityService();






        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            String pathInfo = req.getPathInfo();

            System.out.println("====================================");
            System.out.println("📍 pathInfo = " + pathInfo);
            System.out.println("====================================");

            if ("/getDepartments".equals(pathInfo)) {
                System.out.println("✅ GET All Departments");

                try {
                    List<DepartmentDTO> departments = departmentService.getAllDepartments();

                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");

                    // بناء JSON
                    StringBuilder json = new StringBuilder();
                    json.append("{\"success\":true,\"departments\":[");

                    for (int i = 0; i < departments.size(); i++) {
                        DepartmentDTO dept = departments.get(i);

                        if (i > 0) json.append(",");

                        json.append("{");
                        json.append("\"code\":\"").append(dept.getCode()).append("\",");
                        json.append("\"nom\":\"").append(dept.getNom()).append("\",");
                        json.append("\"description\":\"").append(dept.getDescription() != null ? dept.getDescription() : "").append("\"");
                        json.append("}");
                    }

                    json.append("]}");

                    resp.getWriter().write(json.toString());

                    System.out.println("✅ Returned " + departments.size() + " departments");

                } catch (Exception e) {
                    System.out.println("❌ Error: " + e.getMessage());
                    e.printStackTrace();

                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
                }

                System.out.println("====================================");
                return;
            }
            if ("/getPatient".equals(pathInfo)) {
                String id = req.getParameter("id");

                try {
                    PatientDTO patient = patientService.getPatientById(Integer.parseInt(id));

                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");

                    if (patient != null) {
                        StringBuilder json = new StringBuilder();
                        json.append("{\"success\":true,\"patient\":{");
                        json.append("\"id\":").append(patient.getId()).append(",");
                        json.append("\"nom\":\"").append(patient.getNom()).append("\",");
                        //json.append("\"numeroIdentification\":\"").append(patient.getNumeroIdentification()).append("\",");
                        json.append("\"email\":\"").append(patient.getEmail()).append("\",");
                        json.append("\"telephone\":\"").append(patient.getTelephone()).append("\",");
                        //json.append("\"dateNaissance\":\"").append(patient.getDateNaissance()).append("\",");
                        //json.append("\"genre\":\"").append(patient.getGenre()).append("\",");
                        json.append("\"adresse\":\"").append(patient.getAdresse() != null ? patient.getAdresse() : "").append("\"");
                        json.append("}}");

                        resp.getWriter().write(json.toString());
                    } else {
                        resp.getWriter().write("{\"success\":false,\"error\":\"Patient not found\"}");
                    }
                } catch (Exception e) {
                    resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
                }
                return;
            }
            if ("/getDepartment".equals(pathInfo)) {
                String code = req.getParameter("id");

                try {
                    DepartmentDTO dto = departmentService.getDepartmentByCode(code);

                    resp.setContentType("application/json");

                    if (dto != null) {
                        String json = "{\"success\":true,\"department\":{" +
                                "\"code\":\"" + dto.getCode() + "\"," +
                                "\"nom\":\"" + dto.getNom() + "\"," +
                                "\"description\":\"" + (dto.getDescription() != null ? dto.getDescription() : "") + "\"}}";
                        resp.getWriter().write(json);
                    } else {
                        resp.getWriter().write("{\"success\":false,\"error\":\"Not found\"}");
                    }

                } catch (Exception e) {
                    resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
                }
                return;
            }
            if ("/departments".equals(pathInfo)) {
                System.out.println("✅ Loading departments page");

                List<DepartmentDTO> departments = departmentService.getAllDepartments();
                req.setAttribute("departments", departments);
                req.setAttribute("TotalDepartments", departments.size());

                req.getRequestDispatcher("/Admin/Department.jsp").forward(req, resp);
                return;
            }
            if ("/admin".equals(pathInfo)){
                req.getRequestDispatcher("/Admin/admin.jsp").forward(req,resp);
            }
            if ("/doctors".equals(pathInfo)) {
                System.out.println("hellow in doctors page ");
                List<DoctorDTO> doctors = doctorService.getAllDoctor();
                req.setAttribute("doctors", doctors);
                req.setAttribute("totalDoctors", doctors.size());
                req.getRequestDispatcher("/Admin/doctors.jsp").forward(req, resp);
                return;
            }
            if ("/patients".equals(pathInfo)) {
                System.out.println("welcom to patients");
                List<PatientDTO> patients = patientService.getAllPatients();
                req.setAttribute("patients", patients);
                req.setAttribute("totalPatients", patients.size());
                //req.getRequestDispatcher("Admin/patients.jsp").forward(req,resp);
                req.getRequestDispatcher("/Admin/patients.jsp").forward(req, resp);  // ← زيد / فـ البداية


            }
            if ("/getPatient".equals(pathInfo)) {
                String id = req.getParameter("id");

                System.out.println("====================================");
                System.out.println("✅ GET Patient Request");
                System.out.println("📋 Patient ID: " + id);
                System.out.println("====================================");

                try {
                    PatientDTO patient = patientService.getPatientById(Integer.parseInt(id));

                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");

                    if (patient != null) {
                        StringBuilder json = new StringBuilder();
                        json.append("{\"success\":true,\"patient\":{");
                        json.append("\"id\":").append(patient.getId()).append(",");
                        json.append("\"nom\":\"").append(patient.getNom()).append("\",");
                        json.append("\"CIN\":\"").append(patient.getCIN() != null ? patient.getCIN() : "").append("\",");
                        json.append("\"email\":\"").append(patient.getEmail()).append("\",");
                        json.append("\"telephone\":\"").append(patient.getTelephone() != null ? patient.getTelephone() : "").append("\",");
                        json.append("\"naissance\":\"").append(patient.getNaissance() != null ? patient.getNaissance() : "").append("\",");
                        json.append("\"sexe\":\"").append(patient.getSexe() != null ? patient.getSexe() : "").append("\",");
                        json.append("\"sang\":\"").append(patient.getSang() != null ? patient.getSang() : "").append("\",");
                        json.append("\"adresse\":\"").append(patient.getAdresse() != null ? patient.getAdresse() : "").append("\"");
                        json.append("}}");

                        System.out.println("📤 Response: " + json.toString());
                        resp.getWriter().write(json.toString());
                    } else {
                        System.out.println("❌ Patient not found!");
                        resp.getWriter().write("{\"success\":false,\"error\":\"Patient not found\"}");
                    }

                } catch (Exception e) {
                    System.out.println("❌ Error: " + e.getMessage());
                    e.printStackTrace();
                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
                }

                System.out.println("====================================");
                return;
            }
            if ("/addDoctor".equals(pathInfo)) {
                System.out.println("welcom to add Doctore ");
                req.getRequestDispatcher("/Admin/addDoctor.jsp").forward(req, resp);
                return;

            }
            if ("/doctorAvailability".equals(pathInfo)) {
                System.out.println("welcom to doctorAvailability");
                req.getRequestDispatcher("/Admin/doctorAvailability.jsp").forward(req, resp);

            }
            if ("/availabilities".equals(pathInfo)) {
                System.out.println("====================================");
                System.out.println("📅 /availabilities endpoint called");
                System.out.println("====================================");

                try {
                    // ✅ 1. Get departments
                    List<DepartmentDTO> departments = departmentService.getAllDepartments();
                    req.setAttribute("departments", departments);
                    System.out.println("✅ Loaded " + departments.size() + " departments");

                    // ✅ 2. Get doctors grouped by department
                    Map<String, List<DoctorDepartmentSpecialtyDTO>> doctorsByDept = new HashMap<>();
                    for (DepartmentDTO dept : departments) {
                        List<DoctorDepartmentSpecialtyDTO> doctors = doctorService.getDoctorsByDepartmentId(dept.getCode());
                        doctorsByDept.put(dept.getCode(), doctors);
                    }
                    req.setAttribute("doctorsByDept", doctorsByDept);
                    System.out.println("✅ Loaded doctors for " + doctorsByDept.size() + " departments");

                    // ✅ 3. Calculate current week dates
                    int weekOffset = 0;
                    String offsetParam = req.getParameter("weekOffset");
                    if (offsetParam != null) {
                        try {
                            weekOffset = Integer.parseInt(offsetParam);
                        } catch (NumberFormatException e) {
                            weekOffset = 0;
                        }
                    }

                    LocalDate today = LocalDate.now();
                    LocalDate weekStart = today.plusWeeks(weekOffset).with(DayOfWeek.MONDAY);

                    List<Map<String, Object>> weekDates = new ArrayList<>();
                    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

                    for (int i = 0; i < 7; i++) {
                        LocalDate date = weekStart.plusDays(i);
                        Map<String, Object> dateInfo = new HashMap<>();

                        dateInfo.put("date", date.format(dateFormatter)); // "2025-10-21"
                        dateInfo.put("dayOfWeek", date.getDayOfWeek().toString()); // "MONDAY"
                        dateInfo.put("dayOfMonth", date.getDayOfMonth()); // 21
                        dateInfo.put("monthName", date.getMonth().toString()); // "OCTOBER"
                        dateInfo.put("year", date.getYear()); // 2025
                        dateInfo.put("isPast", date.isBefore(today));
                        dateInfo.put("isWeekend",
                                date.getDayOfWeek() == DayOfWeek.SATURDAY ||
                                        date.getDayOfWeek() == DayOfWeek.SUNDAY
                        );

                        weekDates.add(dateInfo);
                    }

                    req.setAttribute("weekDates", weekDates);
                    req.setAttribute("weekOffset", weekOffset);
                    req.setAttribute("today", today.format(dateFormatter));

                    System.out.println("✅ Generated week dates: " + weekStart.format(dateFormatter) +
                            " to " + weekStart.plusDays(6).format(dateFormatter));

                    // ✅ 4. If doctor + date selected, get available time slots
                    String doctorIdParam = req.getParameter("doctorId");
                    String dateParam = req.getParameter("date");

                    if (doctorIdParam != null && dateParam != null && !dateParam.trim().isEmpty()) {
                        try {
                            Integer doctorId = Integer.parseInt(doctorIdParam);
                            LocalDate selectedDate = null;

                            // Smart parsing: handle both "2025-10-21" and "21"
                            if (dateParam.length() > 2 && dateParam.contains("-")) {
                                // Full date format
                                selectedDate = LocalDate.parse(dateParam, dateFormatter);
                            } else {
                                // Day number only - build from week
                                int dayOfMonth = Integer.parseInt(dateParam);
                                for (Map<String, Object> d : weekDates) {
                                    if ((Integer) d.get("dayOfMonth") == dayOfMonth) {
                                        selectedDate = LocalDate.parse((String) d.get("date"), dateFormatter);
                                        break;
                                    }
                                }
                            }

                            if (selectedDate != null) {
                                System.out.println("🔍 Fetching slots for doctor " + doctorId + " on " + selectedDate);

                                List<String> availableSlots = availabilityService.getAvailableSlots(doctorId, selectedDate);

                                req.setAttribute("availableSlots", availableSlots);
                                req.setAttribute("selectedDate", selectedDate.format(dateFormatter));
                                req.setAttribute("selectedDoctorId", doctorId);

                                System.out.println("✅ Found " + availableSlots.size() + " slots");
                            }

                        } catch (Exception e) {
                            System.err.println("❌ Error:");
                            e.printStackTrace();
                        }
                    }

                    // ✅ 5. Get current patient info
                    String username = (String) req.getSession().getAttribute("username");
                    if (username != null) {
                        Optional<PatientDTO> patient = patientService.getPatientByUsername(username);
                        req.setAttribute("patient", patient.orElse(null));
                    }

                    // ✅ Forward to JSP
                    req.getRequestDispatcher("/Admin/availability.jsp").forward(req, resp);

                } catch (Exception e) {
                    System.err.println("❌ Error in /availabilities:");
                    e.printStackTrace();

                    // Set fallback empty data
                    req.setAttribute("departments", new ArrayList<>());
                    req.setAttribute("doctorsByDept", new HashMap<>());
                    req.setAttribute("weekDates", new ArrayList<>());
                    req.setAttribute("availableSlots", new ArrayList<>());
                    req.setAttribute("error", "Failed to load booking page: " + e.getMessage());

                    req.getRequestDispatcher("/Admin/availability.jsp").forward(req, resp);
                }
            }
            if ("/book-appointment".equals(pathInfo)){
                System.out.println("====================================");
                System.out.println("📝 POST /book-appointment");
                System.out.println("====================================");

                try {
                    // ✅ Get form parameters
                    String deptCode = req.getParameter("deptCode");
                    String doctorIdStr = req.getParameter("doctorId");
                    String date = req.getParameter("date");
                    String time = req.getParameter("time");

                    System.out.println("📋 Booking Details:");
                    System.out.println("   Department: " + deptCode);
                    System.out.println("   Doctor ID: " + doctorIdStr);
                    System.out.println("   Date: " + date);
                    System.out.println("   Time: " + time);

                    // ✅ Validate required parameters
                    if (doctorIdStr == null || date == null || time == null) {
                        System.err.println("❌ Missing required parameters");
                        resp.sendRedirect(req.getContextPath() +
                                "/user/availabilities?error=missing-params");
                        return;
                    }

                    Integer doctorId = Integer.parseInt(doctorIdStr);

                    // ✅ Get current logged-in patient (NO OPTIONAL)
                    String currentUsername = (String) req.getSession().getAttribute("username");

                    if (currentUsername == null) {
                        System.err.println("❌ User not logged in");
                        resp.sendRedirect(req.getContextPath() + "/login.jsp");
                        return;
                    }

                    PatientDTO patient = patientService.getPatientByUsernameSimple(currentUsername);

                    if (patient == null) {
                        System.err.println("❌ Patient not found: " + currentUsername);
                        resp.sendRedirect(req.getContextPath() +
                                "/user/availabilities?error=patient-not-found");
                        return;
                    }

                    System.out.println("✅ Patient: " + patient.getNom() + " (ID: " + patient.getId() + ")");

                    // ✅ Book appointment
                    boolean success = availabilityService.bookAppointment(
                            doctorId,
                            patient.getId(),
                            date,
                            time
                    );

                    if (success) {
                        System.out.println("✅ ✅ ✅ APPOINTMENT BOOKED! ✅ ✅ ✅");
                        System.out.println("   Doctor: " + doctorId);
                        System.out.println("   Patient: " + patient.getNom() + " (ID: " + patient.getId() + ")");
                        System.out.println("   Date: " + date);
                        System.out.println("   Time: " + time);

                        resp.sendRedirect(req.getContextPath() +
                                "/user/availabilities?success=true&date=" + date + "&time=" + time);

                    } else {
                        System.err.println("❌ Booking failed (slot already taken)");
                        resp.sendRedirect(req.getContextPath() +
                                "/user/availabilities?error=booking-failed&step=3&doctorId=" + doctorId + "&date=" + date);
                    }

                } catch (NumberFormatException e) {
                    System.err.println("❌ Invalid doctorId format");
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() +
                            "/user/availabilities?error=invalid-doctor");

                } catch (Exception e) {
                    System.err.println("❌ Exception during booking:");
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() +
                            "/user/availabilities?error=system-error");
                }
            }
            if ("/settings".equals(pathInfo)){
                System.out.println("helow sitings  ");
                req.getRequestDispatcher("/Admin/settings.jsp").forward(req,resp);
            }
        }


        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String action = req.getParameter("action");
            String pathInfo = req.getPathInfo();
            System.out.println("path Info = " + pathInfo);
            System.out.println("Action parameter = " + req.getParameter("action"));
            System.out.println("Request URL = " + req.getRequestURL());

            if ("register".equals(action)) {

                String name = req.getParameter("name");
                String email = req.getParameter("email");
                String roleParam = req.getParameter("role");


                if (roleParam == null || roleParam.isEmpty()) {
                    resp.getWriter().println("Please specify a role!");
                    return;
                }

                Role role;
                try {
                    role = Role.valueOf(roleParam.toUpperCase());
                } catch (IllegalArgumentException e) {
                    e.printStackTrace();
                    return;
                }

                String password = req.getParameter("password");

                try {
                    UserRegisterRequestDTO userRegisterRequestDTO = new UserRegisterRequestDTO(name,email,role,password);
                    UserRegisterRequestDTO userRegisterRequestDTO1 = userService.register(userRegisterRequestDTO);

                    if (userRegisterRequestDTO1 != null) {

                        req.setAttribute("User",userRegisterRequestDTO1);
                        RequestDispatcher dispatcher = req.getRequestDispatcher("/login");
                        dispatcher.forward(req, resp);

                    } else {
                        req.setAttribute("error","Registration failed!");
                        req.getRequestDispatcher("/login").forward(req, resp);;

                    }

                } catch (IllegalArgumentException e) {
                    e.printStackTrace();
                    req.setAttribute("error", e.getMessage());
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                    return;
                }
            }
            if ("login".equals(action)) {
                System.out.println("====================================");
                System.out.println("🔐 LOGIN ACTION");
                System.out.println("====================================");

                String email = req.getParameter("email");
                String password = req.getParameter("password");

                // Validate email
                if (email == null || email.isEmpty() || !email.contains("@")) {
                    req.setAttribute("error", "Invalid email address!");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                    return;
                }

                // Validate password
                if (password == null || password.isEmpty() || password.length() < 6) {
                    req.setAttribute("error", "Password must be at least 6 characters!");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                    return;
                }

                try {
                    UserRequestDTO userRequestDTO = new UserRequestDTO(email, password);
                    UserResponseDTO userResponseDTO = userService.login(userRequestDTO);

                    if (userResponseDTO != null) {
                        // ✅ Create session
                        HttpSession session = req.getSession();
                        session.setAttribute("loggedUser", userResponseDTO);
                        session.setAttribute("username", userResponseDTO.getEmail());
                        session.setAttribute("role", userResponseDTO.getRole().toString());

                        System.out.println("✅ Login successful!");
                        System.out.println("   User: " + userResponseDTO.getEmail());
                        System.out.println("   Role: " + userResponseDTO.getRole());

                        // ✅ Redirect based on role (NOT forward)
                        if (Role.PATIENT.equals(userResponseDTO.getRole())) {
                            System.out.println("→ Redirecting to PATIENT dashboard");
                            resp.sendRedirect(req.getContextPath() + "/user/availabilities");

                        } else if (Role.ADMIN.equals(userResponseDTO.getRole())) {
                            System.out.println("→ Redirecting to ADMIN dashboard");
                            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");

                        } else {
                            System.out.println("→ Redirecting to default dashboard");
                            resp.sendRedirect(req.getContextPath() + "/user/dashboard");
                        }

                        return;

                    } else {
                        System.err.println("❌ Login failed: Invalid credentials");
                        req.setAttribute("error", "Invalid email or password!");
                        req.getRequestDispatcher("/login.jsp").forward(req, resp);
                        return;
                    }

                } catch (IllegalArgumentException e) {
                    System.err.println("❌ Login failed: " + e.getMessage());
                    e.printStackTrace();
                    req.setAttribute("error", e.getMessage());
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                    return;

                } catch (Exception e) {
                    System.err.println("❌ Login failed: Unexpected error");
                    e.printStackTrace();
                    req.setAttribute("error", "Unexpected error occurred. Please try again later.");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                    return;
                }
            }
            if ("addDoctor".equals(action)) {
                System.out.println("✅ Action detected: addDoctor");

                String nom = req.getParameter("nom") != null ? req.getParameter("nom").trim() : "";
                String email = req.getParameter("email") != null ? req.getParameter("email").trim() : "";
                String password = req.getParameter("password") != null ? req.getParameter("password").trim() : "";
                String matricule = req.getParameter("matricule") != null ? req.getParameter("matricule").trim() : "";
                String titre = req.getParameter("titre") != null ? req.getParameter("titre").trim() : "";
                String specialite = req.getParameter("specialite") != null ? req.getParameter("specialite").trim() : "";
                    String role = req.getParameter("role") != null ? req.getParameter("role").trim() : "";
                boolean actif = req.getParameter("actif") != null;

                Map<String, String> errors = new HashMap<>();

                    if (nom.isEmpty()) {
                    errors.put("nom", "Le nom complet est requis.");
                }

                if (email.isEmpty()) {
                    errors.put("email", "L'email est requis.");
                }

                if (password.isEmpty()) {
                    errors.put("password", "Le mot de passe est requis.");
                } else if (password.length() < 6) {
                    errors.put("password", "Le mot de passe doit contenir au moins 6 caractères.");
                }

                if (matricule.isEmpty()) {
                    errors.put("matricule", "Le matricule est requis.");
                }

                if (titre.isEmpty()) {
                    errors.put("titre", "Le titre est requis.");
                }

                if (specialite.isEmpty()) {
                    errors.put("specialite", "La spécialité est requise.");
                }

                if (role.isEmpty()) {
                    errors.put("role", "Le rôle est requis.");
                }

                if (!errors.isEmpty()) {
                    req.setAttribute("errors", errors);
                    req.setAttribute("nom", nom);
                    req.setAttribute("email", email);
                    req.setAttribute("matricule", matricule);
                    req.setAttribute("titre", titre);
                    req.setAttribute("specialite", specialite);
                    req.setAttribute("role", role);
                    req.setAttribute("actif", actif);

                    req.getRequestDispatcher("/Admin/addDoctor.jsp").forward(req, resp);
                    return;
                }

                // If no errors, create and save doctor
                DoctorCreateDTO dto = new DoctorCreateDTO(nom, email, password, matricule, titre, specialite, role, actif);
                DoctorDTO dtoRes = doctorService.addDoctor(dto);

                resp.sendRedirect(req.getContextPath() + "/user/doctors");
            }
            if ("updateDoctor".equals(action)) {
                System.out.println("====================================");
                System.out.println("✅ Welcome to updateDoctor");
                System.out.println("====================================");

                String nom = req.getParameter("nom") != null ? req.getParameter("nom").trim() : "";
                String email = req.getParameter("email") != null ? req.getParameter("email").trim() : "";
                String titre = req.getParameter("titre") != null ? req.getParameter("titre").trim() : "";
                String specialite = req.getParameter("specialite") != null ? req.getParameter("specialite").trim() : "";
                String matricule = req.getParameter("matricule") != null ? req.getParameter("matricule").trim() : "";
                String doctorIdStr = req.getParameter("doctorId");

                if (doctorIdStr == null || doctorIdStr.isEmpty()) {
                    System.out.println("❌ ERROR: Doctor ID is missing!");
                    resp.sendRedirect(req.getContextPath() + "/user/doctors");
                    return;
                }

                int doctorId = Integer.parseInt(doctorIdStr);

                System.out.println("📋 Update Request:");
                System.out.println("  Doctor ID: " + doctorId);
                System.out.println("  Name: " + nom);
                System.out.println("  Email: " + email);
                System.out.println("  Matricule: " + matricule);
                System.out.println("  Titre: " + titre);
                System.out.println("  Specialite: " + specialite);

                // ✅ VALIDATION
                Map<String, String> errors = new HashMap<>();

                if (nom.isEmpty()) {
                    errors.put("nom", "Le nom complet est requis.");
                }

                if (email.isEmpty()) {
                    errors.put("email", "L'email est requis.");
                } else if (!email.contains("@")) {
                    errors.put("email", "Email invalide.");
                }

                if (titre.isEmpty()) {
                    errors.put("titre", "Le titre est requis.");
                }

                if (matricule.isEmpty()) {
                    errors.put("matricule", "Le matricule est requis.");
                }

                if (specialite.isEmpty()) {
                    errors.put("specialite", "La spécialité est requise.");
                }

                // ✅ ILA KAYN ERRORS - RETURN M3A ERRORS
                if (!errors.isEmpty()) {
                    System.out.println("❌ Validation errors found:");
                    for (Map.Entry<String, String> e : errors.entrySet()) {
                        System.out.println("  - " + e.getKey() + ": " + e.getValue());
                    }

                    List<DoctorDTO> doctors = doctorService.getAllDoctor();
                    req.setAttribute("doctors", doctors);
                    req.setAttribute("TotalDoctors", doctors.size());
                    req.setAttribute("errors", errors);
                    req.setAttribute("nom", nom);
                    req.setAttribute("email", email);
                    req.setAttribute("titre", titre);
                    req.setAttribute("specialite", specialite);

                    req.getRequestDispatcher("/Admin/doctors.jsp").forward(req, resp);
                    return;  // ✅ IMPORTANT!
                }

                // ✅ ILA MAKAYNCH ERRORS - UPDATE
                try {
                    System.out.println("📤 Calling updateDoctor service...");

                    DoctorUpdateDTO dto = new DoctorUpdateDTO(doctorId, nom, email, titre, specialite, true, matricule);
                    DoctorDTO updatedDoctor = doctorService.updateDoctor(dto);

                    System.out.println("✅ Doctor updated successfully!");
                    System.out.println("====================================");

                    // ✅ REDIRECT L DOCTORS PAGE
                    resp.sendRedirect(req.getContextPath() + "/user/doctors");

                } catch (Exception e) {
                    System.out.println("❌ ERROR updating doctor:");
                    e.printStackTrace();

                    List<DoctorDTO> doctors = doctorService.getAllDoctor();
                    req.setAttribute("doctors", doctors);
                    req.setAttribute("TotalDoctors", doctors.size());
                    req.setAttribute("errors", Map.of("general", "Error: " + e.getMessage()));

                    req.getRequestDispatcher("/Admin/doctors.jsp").forward(req, resp);
                }
            }
            if ("/createDepartment".equals(pathInfo)) {
                try {
                    System.out.println("welcom to create Department");
                    BufferedReader reader = req.getReader();
                    String json = "";
                    String line;
                    while ((line = reader.readLine()) != null) json += line;

                    String code = getJsonValue(json, "code");
                    String nom = getJsonValue(json, "nom");
                    String desc = getJsonValue(json, "description");
                    System.out.println(code);
                    System.out.println(nom);
                    System.out.println(desc);

                    DepartmentCreatDTO dto = new DepartmentCreatDTO(code, nom, desc);
                    DepartmentDTO result = departmentService.createDepartment(dto);

                    // Nrj3 response
                    resp.setContentType("application/json");
                    if (result != null) {
                        resp.getWriter().write("{\"success\":true,\"departmentId\":\"" + result.getCode() + "\"}");
                    } else {
                       resp.getWriter().write("{\"success\":false,\"error\":\"Failed\"}");
                    }
                } catch (Exception e) {
                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
                }
            }
            if ("/addSpecialties".equals(pathInfo)) {
                try {
                    System.out.println("====================================");
                    System.out.println("✅ ENTERING addSpecialties");
                    System.out.println("====================================");

                    // Nقraw JSON
                    BufferedReader reader = req.getReader();
                    String json = "";
                    String line;
                    while ((line = reader.readLine()) != null) json += line;

                    System.out.println("📦 RAW JSON RECEIVED:");
                    System.out.println(json);
                    System.out.println("------------------------------------");

                    // Nجيبو departmentId
                    String deptId = getJsonValue(json, "departmentId");
                    System.out.println("🏥 Department ID: " + deptId);

                    if (deptId == null || deptId.isEmpty()) {
                        System.out.println("❌ ERROR: Department ID is NULL or EMPTY!");
                    }
                    System.out.println("------------------------------------");

                    // Nجيبو specialties array
                    List<SpecialtyCreateDTO> specs = new ArrayList<>();

                    // Parse array
                    int start = json.indexOf("[");
                    int end = json.indexOf("]");

                    System.out.println("📍 Array Start Index: " + start);
                    System.out.println("📍 Array End Index: " + end);

                    if (start == -1 || end == -1) {
                        System.out.println("❌ ERROR: Specialties array NOT FOUND in JSON!");
                        resp.setContentType("application/json");
                        resp.getWriter().write("{\"success\":false,\"error\":\"No specialties array found\"}");
                        return;
                    }

                    String arr = json.substring(start + 1, end);
                    System.out.println("📋 Array Content:");
                    System.out.println(arr);
                    System.out.println("------------------------------------");

                    String[] items = arr.split("\\},");
                    System.out.println("🔢 Number of Items Split: " + items.length);
                    System.out.println("------------------------------------");

                    int counter = 1;
                    for (String item : items) {
                        System.out.println("🔍 Processing Item #" + counter + ":");
                        System.out.println("   Raw: " + item);

                        String code = getJsonValue(item, "code");
                        String name = getJsonValue(item, "name");
                        String desc = getJsonValue(item, "description");

                        System.out.println("   ├─ Code: " + code);
                        System.out.println("   ├─ Name: " + name);
                        System.out.println("   └─ Description: " + desc);

                        if (name == null || name.isEmpty()) {
                            System.out.println("   ⚠️ WARNING: Name is NULL or EMPTY!");
                        }

                        SpecialtyCreateDTO dto = new SpecialtyCreateDTO(code, name, desc);
                        specs.add(dto);

                        System.out.println("   ✅ DTO Created Successfully");
                        counter++;
                    }

                    System.out.println("====================================");
                    System.out.println("📊 TOTAL SPECIALTIES PARSED: " + specs.size());
                    System.out.println("====================================");

                    if (specs.isEmpty()) {
                        System.out.println("❌ ERROR: No specialties parsed!");
                        resp.setContentType("application/json");
                        resp.getWriter().write("{\"success\":false,\"error\":\"No valid specialties\"}");
                        return;
                    }

                    // Nsyft l service
                    System.out.println("📤 CALLING departmentService.addSpecialties()...");
                    departmentService.addSpecialties(deptId, specs);
                    System.out.println("✅ Service call COMPLETED successfully!");

                    // Response
                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":true}");
                    System.out.println("✅ SUCCESS RESPONSE SENT");
                    System.out.println("====================================");

                } catch (Exception e) {
                    System.out.println("====================================");
                    System.out.println("❌❌❌ EXCEPTION OCCURRED ❌❌❌");
                    System.out.println("Exception Type: " + e.getClass().getName());
                    System.out.println("Exception Message: " + e.getMessage());
                    System.out.println("Stack Trace:");
                    e.printStackTrace();
                    System.out.println("====================================");

                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
                }
                return;
            }
            if ("/createPatient".equals(pathInfo)) {
                System.out.println("welcome to createPatient");
                try {
                    BufferedReader reader = req.getReader();
                    String json = "";
                    String line;
                    while ((line = reader.readLine()) != null) json += line;

                    String nom = getJsonValue(json, "nom");
                    String CIN = getJsonValue(json, "CIN");
                    String email = getJsonValue(json, "email");
                    String telephone = getJsonValue(json, "telephone");
                    String naissanceStr = getJsonValue(json, "naissance");
                    String sexe = getJsonValue(json, "sexe");
                    String adresse = getJsonValue(json, "adresse");
                    String sang = getJsonValue(json, "sang");
                    String password = getJsonValue(json, "password");

                    Map<String, String> errors = new HashMap<>();

                    if (nom == null || nom.isEmpty()) {
                        errors.put("nom", "Le nom est requis");
                    }
                    if (CIN == null || CIN.isEmpty()) {
                        errors.put("CIN", "Le CIN est requis");
                    }
                    if (email == null || email.isEmpty()) {
                        errors.put("email", "L'email est requis");
                    }
                    if (telephone == null || telephone.isEmpty()) {
                        errors.put("telephone", "Le téléphone est requis");
                    }
                    if (naissanceStr == null || naissanceStr.isEmpty()) {
                        errors.put("naissance", "La date de naissance est requise");
                    }
                    if (sexe == null || sexe.isEmpty()) {
                        errors.put("sexe", "Le sexe est requis");
                    }
                    if (password == null || password.isEmpty()) {
                        errors.put("password", "Le mot de passe est requis");
                    }

                    if (!errors.isEmpty()) {
                        resp.setContentType("application/json");
                        resp.setCharacterEncoding("UTF-8");
                        resp.setStatus(400);
                        resp.getWriter().write("{\"success\":false,\"message\":\"Validation failed\"}");
                        return;
                    }

                    LocalDate naissance = LocalDate.parse(naissanceStr);

                    PatientCreateDTO dto = new PatientCreateDTO(nom, email, password, CIN, naissance, sexe, adresse, telephone, sang);
                    PatientDTO result = patientService.createPatient(dto);

                    if (result != null) {
                        resp.setContentType("application/json");
                        resp.setCharacterEncoding("UTF-8");
                        resp.getWriter().write("{\"success\":true,\"message\":\"Patient created successfully\"}");
                    } else {
                        resp.setContentType("application/json");
                        resp.setStatus(500);
                        resp.getWriter().write("{\"success\":false,\"message\":\"Failed to create patient\"}");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    resp.setContentType("application/json");
                    resp.setStatus(500);
                    resp.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
                }
                return;
            }
            if ("/updatePatient".equals(pathInfo)) {
                try {
                    BufferedReader reader = req.getReader();
                    String json = "";
                    String line;
                    while ((line = reader.readLine()) != null) json += line;

                    String idStr = getJsonValue(json, "id");
                    String nom = getJsonValue(json, "nom");
                    String CIN = getJsonValue(json, "CIN");
                    String email = getJsonValue(json, "email");
                    String telephone = getJsonValue(json, "telephone");
                    String naissanceStr = getJsonValue(json, "naissance");
                    String sexe = getJsonValue(json, "sexe");
                    String adresse = getJsonValue(json, "adresse");
                    String sang = getJsonValue(json, "sang");

                    if (idStr == null || idStr.isEmpty()) {
                        resp.setContentType("application/json");
                        resp.setStatus(400);
                        resp.getWriter().write("{\"success\":false,\"message\":\"Patient ID is required\"}");
                        return;
                    }

                    Integer id = Integer.parseInt(idStr);
                    LocalDate naissance = LocalDate.parse(naissanceStr);

                    PatientUpdateDTO dto = new PatientUpdateDTO(id, nom, email, CIN, naissance, sexe, adresse, telephone, sang, true);
                    PatientDTO result = patientService.updatePatient(dto);

                    if (result != null) {
                        resp.setContentType("application/json");
                        resp.setCharacterEncoding("UTF-8");
                        resp.getWriter().write("{\"success\":true,\"message\":\"Patient updated successfully\"}");
                    } else {
                        resp.setContentType("application/json");
                        resp.setStatus(404);
                        resp.getWriter().write("{\"success\":false,\"message\":\"Patient not found\"}");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    resp.setContentType("application/json");
                    resp.setStatus(500);
                    resp.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
                }
                return;
            }
            if ("/book-appointment".equals(pathInfo)) {
                System.out.println("====================================");
                System.out.println("📝 POST /book-appointment");
                System.out.println("User: anouar36");
                System.out.println("====================================");

                try {
                    String deptCode = req.getParameter("deptCode");
                    String doctorIdStr = req.getParameter("doctorId");
                    String date = req.getParameter("date");
                    String time = req.getParameter("time");

                    System.out.println("📋 Booking Details:");
                    System.out.println("   Department: " + deptCode);
                    System.out.println("   Doctor ID: " + doctorIdStr);
                    System.out.println("   Date: " + date);
                    System.out.println("   Time: " + time);

                    if (doctorIdStr == null || date == null || time == null) {
                        System.err.println("❌ Missing required parameters");
                        resp.sendRedirect(req.getContextPath() + "/user/availabilities?error=missing-params");
                        return;
                    }

                    Integer doctorId = Integer.parseInt(doctorIdStr);

                    // Get patient
                    String username = (String) req.getSession().getAttribute("username");
                    if (username == null) {
                        username = "anouar36"; // fallback
                    }

                    Optional<PatientDTO> patientOpt = patientService.getPatientByUsername(username);

                    if (!patientOpt.isPresent()) {
                        System.err.println("❌ Patient not found: " + username);
                        resp.sendRedirect(req.getContextPath() + "/user/availabilities?error=patient-not-found");
                        return;
                    }

                    PatientDTO patient = patientOpt.get();
                    System.out.println("✅ Patient found: " + patient.getNom() + " (ID: " + patient.getId() + ")");

                    // Book appointment
                    boolean success = availabilityService.bookAppointment(doctorId, patient.getId(), date, time);

                    if (success) {
                        System.out.println("✅ ✅ ✅ APPOINTMENT BOOKED! ✅ ✅ ✅");
                        System.out.println("   Doctor: " + doctorId);
                        System.out.println("   Patient: " + patient.getNom());
                        System.out.println("   Date: " + date);
                        System.out.println("   Time: " + time);

                        resp.sendRedirect(req.getContextPath() + "/user/availabilities?success=true&date=" + date + "&time=" + time);
                    } else {
                        System.err.println("❌ Booking failed");
                        resp.sendRedirect(req.getContextPath() + "/user/availabilities?error=booking-failed");
                    }

                } catch (Exception e) {
                    System.err.println("❌ Exception:");
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() + "/user/availabilities?error=system-error");
                }
            }
        }

        @Override
        protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            String pathInfo = req.getPathInfo();

            System.out.println("====================================");
            System.out.println("📍 pathInfo = " + pathInfo);
            System.out.println("📍 Full URL = " + req.getRequestURL());
            System.out.println("====================================");

            if("/deleteDepartment".equals(pathInfo)){
                System.out.println("✅ DELETE Department Request");

                String code = req.getParameter("id");
                System.out.println("📋 Department Code: " + code);

                // التحقق من المدخلات
                if (code == null || code.trim().isEmpty()) {
                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":false,\"error\":\"Department code is required\"}");
                    return;
                }

                try {
                    // استدعاء Service
                    boolean result = departmentService.deleteDepartment(code);

                    // ✅ إرجاع JSON Response
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");

                    if (result) {
                        System.out.println("✅ Delete successful");
                        resp.getWriter().write("{\"success\":true,\"message\":\"Department deleted successfully\"}");
                    } else {
                        System.out.println("❌ Delete failed - Department not found");
                        resp.getWriter().write("{\"success\":false,\"error\":\"Department not found\"}");
                    }

                } catch (Exception e) {
                    System.out.println("❌ Delete error: " + e.getMessage());
                    e.printStackTrace();

                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
                }

                System.out.println("====================================");
                return;
            }
            if ("/deletePatient".equals(pathInfo)) {
                System.out.println("✅ DELETE Department Request");



                String id = req.getParameter("id");
                System.out.println("📋 Department Code: " + id);

                if (id == null || id.trim().isEmpty()) {
                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":false,\"error\":\"Patient ID is required\"}");
                    return;
                }

                try {
                    boolean result = patientService.deletePatient(Integer.parseInt(id));

                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");

                    if (result) {
                        resp.getWriter().write("{\"success\":true,\"message\":\"Patient deleted successfully\"}");
                    } else {
                        resp.setStatus(404);
                        resp.getWriter().write("{\"success\":false,\"error\":\"Patient not found\"}");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    resp.setContentType("application/json");
                    resp.setStatus(500);
                    resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
                }
                return;
            }
        }


        private String getJsonValue(String json, String key) {
            try {
                // Kanql3bo 3la "key" f JSON string
                String search = "\"" + key + "\"";
                int keyIndex = json.indexOf(search);
                if (keyIndex == -1) return null;

                // Kanwslo l ":" mn b3d key
                int colonIndex = json.indexOf(":", keyIndex);
                // Kanwslo l awl " (guillemet)
                int startQuote = json.indexOf("\"", colonIndex);
                // Kanwslo l tani " (end dyal value)
                int endQuote = json.indexOf("\"", startQuote + 1);

                // Kanجيبو value li bin 2 guillemets
                if (startQuote != -1 && endQuote != -1) {
                    return json.substring(startQuote + 1, endQuote);
                }
                return null;
            } catch (Exception e) {
                return null;
            }
        }





    }