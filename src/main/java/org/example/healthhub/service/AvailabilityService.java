package org.example.healthhub.service;

import org.example.healthhub.entity.Availability;
import org.example.healthhub.entity.Appointment;
import org.example.healthhub.entity.Doctor;
import org.example.healthhub.repository.implement.AppointmentDAO;
import org.example.healthhub.repository.implement.AvailabilityDAO;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.DayOfWeek;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

public class AvailabilityService {

    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final AvailabilityDAO availabilityDAO = new AvailabilityDAO();

    // ✅ Temporary: In-memory storage
    private Map<Integer, List<Availability>> doctorAvailabilities = new HashMap<>();
    private List<Appointment> appointments = new ArrayList<>();

    public AvailabilityService() {
        // Initialize default schedules (temporary)
        initializeDefaultSchedules();
    }

    /**
     * جيب available time slots ل doctor f date معين
     */
    public List<String> getAvailableSlots(Integer doctorId, LocalDate date) {
        System.out.println("🔍 Getting slots for doctor " + doctorId + " on " + date);

        // 1. Get day name
        String dayName = getDayNameInFrench(date.getDayOfWeek());
        System.out.println("   Day: " + dayName);

        // 2. Get availabilities from DB
        List<Availability> availabilities = availabilityDAO.findByDoctorAndJour(doctorId, dayName);

        if (availabilities.isEmpty()) {
            System.out.println("⚠️ No availabilities for " + dayName);
            return new ArrayList<>();
        }

        // 3. Generate all possible slots
        List<String> allSlots = new ArrayList<>();
        for (Availability avail : availabilities) {
            if ("DISPONIBLE".equals(avail.getStatut())) {
                List<String> slots = generateTimeSlots(avail.getHeureDebut(), avail.getHeureFin(), 30);
                allSlots.addAll(slots);
            }
        }

        System.out.println("📊 Total possible slots: " + allSlots.size());

        // 4. Get booked appointments (FRESH DATA)
        String dateStr = date.toString();
        List<Appointment> booked = appointmentDAO.findByDoctorAndDate(doctorId, dateStr);

        List<String> bookedTimes = new ArrayList<>();
        for (Appointment appt : booked) {
            bookedTimes.add(appt.getHeure());
        }

        System.out.println("🚫 Booked slots: " + bookedTimes.size());
        if (!bookedTimes.isEmpty()) {
            System.out.println("   Times: " + bookedTimes);
        }

        // 5. Filter available (exclude booked)
        List<String> availableSlots = new ArrayList<>();
        for (String slot : allSlots) {
            if (!bookedTimes.contains(slot)) {
                availableSlots.add(slot);
            }
        }

        System.out.println("✅ Available slots: " + availableSlots.size());

        return availableSlots;
    }

    /**
     * Generate time slots من start → end
     */
    private List<String> generateTimeSlots(String startStr, String endStr, int durationMinutes) {
        List<String> slots = new ArrayList<>();

        try {
            LocalTime start = LocalTime.parse(startStr, TIME_FORMATTER);
            LocalTime end = LocalTime.parse(endStr, TIME_FORMATTER);

            LocalTime current = start;
            while (current.isBefore(end)) {
                slots.add(current.format(TIME_FORMATTER)); // "09:00"
                current = current.plusMinutes(durationMinutes);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return slots;
    }

    /**
     * جيب availabilities ديال doctor f يوم معين
     */
    private List<Availability> getAvailabilitiesForDay(Integer doctorId, String dayName) {
        List<Availability> allAvails = doctorAvailabilities.getOrDefault(doctorId, new ArrayList<>());

        return allAvails.stream()
                .filter(a -> dayName.equalsIgnoreCase(a.getJour()))
                .collect(Collectors.toList());
    }

    /**
     * جيب booked slots ل doctor f date معين
     */
    private List<String> getBookedSlotsForDate(Integer doctorId, LocalDate date) {
        String dateStr = date.toString(); // "2025-10-21"

        return appointments.stream()
                .filter(a -> a.getDocteur() != null && a.getDocteur().getId().equals(doctorId))
                .filter(a -> dateStr.equals(a.getDate()))
                .filter(a -> !"ANNULE".equals(a.getStatut()))
                .map(Appointment::getHeure)
                .collect(Collectors.toList());
    }

    /**
     * Book appointment
     */
    public boolean bookAppointment(Integer doctorId, Integer patientId, String date, String time) {
        // Check ايلا slot available
        try {
            LocalDate localDate = LocalDate.parse(date);
            List<String> available = getAvailableSlots(doctorId, localDate);

            if (!available.contains(time)) {
                System.out.println("❌ Slot not available: " + time);
                return false;
            }

            // Create appointment (in-memory for now)
            Appointment appointment = new Appointment();
            appointment.setDate(date);
            appointment.setHeure(time);
            appointment.setStatut("CONFIRME");
            // appointment.setDocteur(...) // need to fetch doctor
            // appointment.setPatient(...) // need to fetch patient

            appointments.add(appointment);
            System.out.println("✅ Appointment booked: " + date + " " + time);

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Initialize default schedules (temporary hardcoded data)
     */
    private void initializeDefaultSchedules() {
        // Doctor 36: Lundi-Vendredi 9h-12h, 14h-17h
        List<Availability> doctor36Schedule = new ArrayList<>();

        String[] workDays = {"Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"};
        for (String day : workDays) {
            // Morning
            doctor36Schedule.add(new Availability(day, "09:00", "12:00", "DISPONIBLE", "2025-12-31"));
            // Afternoon
            doctor36Schedule.add(new Availability(day, "14:00", "17:00", "DISPONIBLE", "2025-12-31"));
        }

        doctorAvailabilities.put(36, doctor36Schedule);

        // Test: Book some slots
        Appointment booked1 = new Appointment();
        booked1.setDate("2025-10-21"); // Monday
        booked1.setHeure("09:00");
        booked1.setStatut("CONFIRME");
        // booked1.setDocteur(doctor36); // would need doctor object

        Appointment booked2 = new Appointment();
        booked2.setDate("2025-10-21");
        booked2.setHeure("10:00");
        booked2.setStatut("CONFIRME");

        appointments.add(booked1);
        appointments.add(booked2);
    }

    /**
     * Helper: Convert DayOfWeek → French day name
     */
    private String getDayNameInFrench(DayOfWeek day) {
        switch (day) {
            case MONDAY: return "Lundi";
            case TUESDAY: return "Mardi";
            case WEDNESDAY: return "Mercredi";
            case THURSDAY: return "Jeudi";
            case FRIDAY: return "Vendredi";
            case SATURDAY: return "Samedi";
            case SUNDAY: return "Dimanche";
            default: return "";
        }
    }

    /**
     * Add availability ل doctor
     */
    public void addAvailability(Integer doctorId, Availability availability) {
        doctorAvailabilities.computeIfAbsent(doctorId, k -> new ArrayList<>()).add(availability);
    }

    /**
     * جيب كل availabilities ديال doctor
     */
    public List<Availability> getDoctorAvailabilities(Integer doctorId) {
        return doctorAvailabilities.getOrDefault(doctorId, new ArrayList<>());
    }
}