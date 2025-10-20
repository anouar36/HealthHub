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
            System.out.println("🔴 NEW AppointmentDAO.save() called");
            System.out.println("   doctorId=" + doctorId + ", patientId=" + patientId + ", date=" + date + ", heure=" + heure);

            em = emf.createEntityManager();

            // 1) check slot again in DB (avoid race)
            String checkJpql = "SELECT COUNT(a) FROM Appointment a WHERE a.docteur.id = :doctorId AND a.date = :date AND a.heure = :heure AND (a.statut IS NULL OR a.statut != 'ANNULE')";
            TypedQuery<Long> q = em.createQuery(checkJpql, Long.class);
            q.setParameter("doctorId", doctorId);
            q.setParameter("date", date);
            q.setParameter("heure", heure);
            Long count = q.getSingleResult();
            System.out.println("   existing bookings for this slot = " + count);
            if (count > 0) {
                System.err.println("❌ Slot already booked in DB");
                return false;
            }

            // 2) begin tx
            tx = em.getTransaction();
            tx.begin();
            System.out.println("   Transaction begun");

            // 3) load entities
            Doctor doctor = em.find(Doctor.class, doctorId);
            Patient patient = em.find(Patient.class, patientId);
            if (doctor == null || patient == null) {
                System.err.println("❌ Doctor or Patient not found (doctor=" + doctor + ", patient=" + patient + ")");
                if (tx.isActive()) tx.rollback();
                return false;
            }
            System.out.println("   Doctor and Patient loaded");

            // 4) create Appointment entity and persist
            Appointment appt = new Appointment();
            appt.setDocteur(doctor);
            appt.setPatient(patient);
            appt.setDate(date);
            appt.setHeure(heure);
            appt.setStatut("CONFIRME");
            appt.setType(type != null ? type : "CONSULTATION");

            em.persist(appt);
            System.out.println("   em.persist() called, appointment entity created (id may be null until flush)");

            em.flush();
            System.out.println("   em.flush() executed");

            tx.commit();
            System.out.println("   tx.commit() executed");

            System.out.println("✅ Appointment saved, id = " + appt.getId());
            return true;

        } catch (Exception e) {
            System.err.println("❌ AppointmentDAO.save error:");
            e.printStackTrace();
            if (tx != null && tx.isActive()) {
                try { tx.rollback(); System.err.println("   rollback done"); } catch (Exception ex) { ex.printStackTrace(); }
            }
            return false;
        } finally {
            if (em != null && em.isOpen()) em.close();
            System.out.println("   EntityManager closed");
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