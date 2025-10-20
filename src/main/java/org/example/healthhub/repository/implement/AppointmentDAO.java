package org.example.healthhub.repository.implement;

import org.example.healthhub.entity.Appointment;
import org.example.healthhub.entity.Doctor;
import org.example.healthhub.entity.Patient;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class AppointmentDAO {

    private EntityManagerFactory emf;

    /**
     * Constructor — Create EMF directly
     */
    public AppointmentDAO() {
        this.emf = Persistence.createEntityManagerFactory("HealthHubPU");
        System.out.println("✅ AppointmentDAO: EntityManagerFactory created");
    }

    /**
     * Constructor مع EMF injection (optional)
     */
    public AppointmentDAO(EntityManagerFactory emf) {
        this.emf = emf;
        System.out.println("✅ AppointmentDAO: Using injected EntityManagerFactory");
    }

    /**
     * ✅ FIXED: Create appointment جديد
     */
    public boolean save(Integer doctorId, Integer patientId, String date, String heure, String type) {
        EntityManager em = null;
        EntityTransaction tx = null;

        try {
            System.out.println("====================================");
            System.out.println("💾 AppointmentDAO: Creating appointment");
            System.out.println("====================================");
            System.out.println("   Doctor ID: " + doctorId);
            System.out.println("   Patient ID: " + patientId);
            System.out.println("   Date: " + date);
            System.out.println("   Time: " + heure);
            System.out.println("   Type: " + type);

            // ✅ 1. Create new EntityManager
            em = emf.createEntityManager();
            System.out.println("✅ Step 1: EntityManager created");

            // ✅ 2. Check slot availability FIRST
            System.out.println("\n--- Checking Slot Availability ---");
            if (isSlotBooked(doctorId, date, heure)) {
                System.err.println("❌ Slot already booked!");
                System.err.println("====================================");
                return false;
            }
            System.out.println("✅ Step 2: Slot is available");

            // ✅ 3. Start transaction
            System.out.println("\n--- Starting Transaction ---");
            tx = em.getTransaction();
            tx.begin();
            System.out.println("✅ Step 3: Transaction started");
            System.out.println("   Transaction active: " + tx.isActive());

            // ✅ 4. Load doctor entity
            System.out.println("\n--- Loading Doctor ---");
            Doctor doctor = em.find(Doctor.class, doctorId);

            if (doctor == null) {
                System.err.println("❌ Doctor not found: ID=" + doctorId);
                if (tx != null && tx.isActive()) {
                    tx.rollback();
                    System.err.println("⚠️ Transaction rolled back");
                }
                return false;
            }

            System.out.println("✅ Step 4: Doctor loaded");
            System.out.println("   Doctor ID: " + doctor.getId());
            System.out.println("   Doctor Name: " + (doctor.getUser() != null ? doctor.getUser().getNom() : "N/A"));

            // ✅ 5. Load patient entity
            System.out.println("\n--- Loading Patient ---");
            Patient patient = em.find(Patient.class, patientId);

            if (patient == null) {
                System.err.println("❌ Patient not found: ID=" + patientId);
                if (tx != null && tx.isActive()) {
                    tx.rollback();
                    System.err.println("⚠️ Transaction rolled back");
                }
                return false;
            }

            System.out.println("✅ Step 5: Patient loaded");
            System.out.println("   Patient ID: " + patient.getId());
            System.out.println("   Patient Name: " + patient.getNom());

            // ✅ 6. Create appointment object
            System.out.println("\n--- Creating Appointment Object ---");
            Appointment appointment = new Appointment();
            appointment.setDocteur(doctor);
            appointment.setPatient(patient);
            appointment.setDate(date);
            appointment.setHeure(heure);
            appointment.setStatut("CONFIRME");
            appointment.setType(type != null ? type : "CONSULTATION");

            System.out.println("✅ Step 6: Appointment object created");
            System.out.println("   Doctor set: " + (appointment.getDocteur() != null));
            System.out.println("   Patient set: " + (appointment.getPatient() != null));
            System.out.println("   Date: " + appointment.getDate());
            System.out.println("   Time: " + appointment.getHeure());
            System.out.println("   Status: " + appointment.getStatut());
            System.out.println("   Type: " + appointment.getType());

            // ✅ 7. Persist to database
            System.out.println("\n--- Persisting to Database ---");
            em.persist(appointment);
            System.out.println("✅ Step 7: em.persist() called");

            // ✅ 8. Flush to execute SQL
            em.flush();
            System.out.println("✅ Step 8: em.flush() executed (SQL sent to DB)");

            // ✅ 9. Commit transaction
            System.out.println("\n--- Committing Transaction ---");
            tx.commit();
            System.out.println("✅ Step 9: Transaction committed");

            // ✅ 10. Success!
            System.out.println("\n====================================");
            System.out.println("✅ ✅ ✅ SAVED TO DATABASE! ✅ ✅ ✅");
            System.out.println("====================================");
            System.out.println("   Appointment ID: " + appointment.getId());
            System.out.println("   Doctor: " + doctorId + " (" + (doctor.getUser() != null ? doctor.getUser().getNom() : "N/A") + ")");
            System.out.println("   Patient: " + patientId + " (" + patient.getNom() + ")");
            System.out.println("   Date: " + date);
            System.out.println("   Time: " + heure);
            System.out.println("   Status: CONFIRME");
            System.out.println("====================================\n");

            return true;

        } catch (Exception e) {
            System.err.println("\n====================================");
            System.err.println("❌ ❌ ❌ ERROR SAVING! ❌ ❌ ❌");
            System.err.println("====================================");
            System.err.println("Error Type: " + e.getClass().getName());
            System.err.println("Error Message: " + e.getMessage());
            System.err.println("\nFull Stack Trace:");
            e.printStackTrace();

            if (tx != null && tx.isActive()) {
                System.err.println("\n⚠️ Rolling back transaction...");
                try {
                    tx.rollback();
                    System.err.println("✅ Rollback successful");
                } catch (Exception rollbackEx) {
                    System.err.println("❌ Rollback failed!");
                    rollbackEx.printStackTrace();
                }
            }

            System.err.println("====================================\n");
            return false;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
                System.out.println("✅ EntityManager closed\n");
            }
        }
    }

    /**
     * تحقق واش slot محجوز
     */
    public boolean isSlotBooked(Integer doctorId, String date, String heure) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 Checking slot: Doctor=" + doctorId + ", Date=" + date + ", Time=" + heure);

            String jpql = "SELECT COUNT(a) FROM Appointment a " +
                    "WHERE a.docteur.id = :doctorId " +
                    "AND TRIM(a.date) = TRIM(:date) " +
                    "AND TRIM(a.heure) = TRIM(:heure) " +
                    "AND (a.statut IS NULL OR a.statut != 'ANNULE')";

            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);
            query.setParameter("heure", heure);

            Long count = query.getSingleResult();
            boolean isBooked = count > 0;

            System.out.println("   Result: " + (isBooked ? "🚫 BOOKED (" + count + " appointments)" : "✅ AVAILABLE"));

            return isBooked;

        } catch (Exception e) {
            System.err.println("❌ Error checking slot");
            e.printStackTrace();
            return false;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * جيب appointments ديال doctor f تاريخ معين
     */
    public List<Appointment> findByDoctorAndDate(Integer doctorId, String date) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 Finding appointments: Doctor=" + doctorId + ", Date=" + date);

            String jpql = "SELECT a FROM Appointment a " +
                    "WHERE a.docteur.id = :doctorId " +
                    "AND a.date = :date " +
                    "AND (a.statut IS NULL OR a.statut != 'ANNULE') " +
                    "ORDER BY a.heure";

            TypedQuery<Appointment> query = em.createQuery(jpql, Appointment.class);
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);

            List<Appointment> appointments = query.getResultList();

            System.out.println("✅ Found " + appointments.size() + " appointments");
            for (Appointment a : appointments) {
                System.out.println("   - " + a.getDate() + " " + a.getHeure() + " (" + a.getStatut() + ")");
            }

            return appointments;

        } catch (Exception e) {
            System.err.println("❌ Error finding appointments");
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * جيب appointments ديال patient
     */
    public List<Appointment> findByPatient(Integer patientId) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 Finding appointments for patient: " + patientId);

            String jpql = "SELECT a FROM Appointment a " +
                    "WHERE a.patient.id = :patientId " +
                    "ORDER BY a.date DESC, a.heure DESC";

            TypedQuery<Appointment> query = em.createQuery(jpql, Appointment.class);
            query.setParameter("patientId", patientId);

            List<Appointment> appointments = query.getResultList();

            System.out.println("✅ Found " + appointments.size() + " patient appointments");
            return appointments;

        } catch (Exception e) {
            System.err.println("❌ Error finding patient appointments");
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * جيب كل appointments ديال doctor (all dates)
     */
    public List<Appointment> findByDoctor(Integer doctorId) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 Finding all appointments for doctor: " + doctorId);

            String jpql = "SELECT a FROM Appointment a " +
                    "WHERE a.docteur.id = :doctorId " +
                    "ORDER BY a.date DESC, a.heure DESC";

            TypedQuery<Appointment> query = em.createQuery(jpql, Appointment.class);
            query.setParameter("doctorId", doctorId);

            List<Appointment> appointments = query.getResultList();

            System.out.println("✅ Found " + appointments.size() + " doctor appointments");
            return appointments;

        } catch (Exception e) {
            System.err.println("❌ Error finding doctor appointments");
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Cancel appointment
     */
    public void cancel(Integer doctorId, String date, String heure) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            System.out.println("❌ Cancelling appointment: Doctor=" + doctorId + ", Date=" + date + ", Time=" + heure);

            tx = em.getTransaction();
            tx.begin();

            String jpql = "UPDATE Appointment a SET a.statut = 'ANNULE' " +
                    "WHERE a.docteur.id = :doctorId " +
                    "AND a.date = :date " +
                    "AND a.heure = :heure";

            Query query = em.createQuery(jpql);
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);
            query.setParameter("heure", heure);

            int updated = query.executeUpdate();
            tx.commit();

            System.out.println("✅ Cancelled " + updated + " appointment(s)");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            System.err.println("❌ Error cancelling appointment");
            e.printStackTrace();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Close EntityManagerFactory
     */
    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println("✅ AppointmentDAO: EntityManagerFactory closed");
        }
    }
}