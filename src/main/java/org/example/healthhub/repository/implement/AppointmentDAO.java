package org.example.healthhub.repository.implement;

import org.example.healthhub.entity.Appointment;



import jakarta.persistence.*;
import org.example.healthhub.entity.Doctor;
import org.example.healthhub.entity.Patient;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class AppointmentDAO {

    private EntityManagerFactory emf;

    /**
     * Constructor — Create EMF directly
     */
    public AppointmentDAO() {
        this.emf = Persistence.createEntityManagerFactory("HealthHubPU");  // ✅ Same name
    }

    /**
     * Constructor مع EMF injection (optional)
     */
    public AppointmentDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    /**
     * جيب appointments ديال doctor f تاريخ معين
     *
     * @param doctorId معرف الطبيب
     * @param date التاريخ (format: "2025-10-21")
     * @return List<Appointment> قائمة المواعيد
     */
    public List<Appointment> findByDoctorAndDate(Integer doctorId, String date) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 AppointmentDAO: Finding appointments for doctor " + doctorId + " on " + date);

            String sql = "SELECT a.date, a.heure, a.statut, a.type " +
                    "FROM appointments a " +
                    "WHERE a.doctor_id = :doctorId " +
                    "AND a.date = :date " +
                    "AND (a.statut IS NULL OR a.statut != 'ANNULE') " +
                    "ORDER BY a.heure";

            Query query = em.createNativeQuery(sql);
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            List<Appointment> appointments = new ArrayList<>();
            for (Object[] row : results) {
                Appointment appt = new Appointment();
                appt.setDate((String) row[0]);
                appt.setHeure((String) row[1]);
                appt.setStatut((String) row[2]);
                appt.setType((String) row[3]);
                appointments.add(appt);
            }

            System.out.println("✅ AppointmentDAO: Found " + appointments.size() + " appointments");
            return appointments;

        } catch (Exception e) {
            System.err.println("❌ AppointmentDAO: Error in findByDoctorAndDate");
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * تحقق واش slot محجوز
     *
     * @param doctorId معرف الطبيب
     * @param date التاريخ
     * @param heure الوقت ("09:00")
     * @return true ايلا محجوز
     */
    public boolean isSlotBooked(Integer doctorId, String date, String heure) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 AppointmentDAO: Checking slot " + heure + " on " + date);

            String sql = "SELECT COUNT(*) FROM appointments " +
                    "WHERE doctor_id = :doctorId " +
                    "AND date = :date " +
                    "AND heure = :heure " +
                    "AND (statut IS NULL OR statut != 'ANNULE')";

            Query query = em.createNativeQuery(sql);
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);
            query.setParameter("heure", heure);

            Number count = (Number) query.getSingleResult();
            boolean isBooked = count.longValue() > 0;

            System.out.println(isBooked ? "🚫 Slot BOOKED" : "✅ Slot AVAILABLE");
            return isBooked;

        } catch (Exception e) {
            System.err.println("❌ AppointmentDAO: Error checking slot");
            e.printStackTrace();
            return false;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Create appointment جديد
     *
     * @param doctorId معرف الطبيب
     * @param patientId معرف المريض
     * @param date التاريخ
     * @param heure الوقت
     * @param type نوع الموعد
     * @return true ايلا نجح
     */
    public boolean save(Integer doctorId, Integer patientId, String date, String heure, String type) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            System.out.println("💾 AppointmentDAO: Creating appointment");
            System.out.println("   Doctor: " + doctorId + ", Patient: " + patientId);
            System.out.println("   Date: " + date + ", Time: " + heure);

            // ✅ تحقق أولاً واش slot available
            if (isSlotBooked(doctorId, date, heure)) {
                System.err.println("❌ AppointmentDAO: Slot already booked!");
                return false;
            }

            tx = em.getTransaction();
            tx.begin();

            String sql = "INSERT INTO appointments (doctor_id, patient_id, date, heure, statut, type) " +
                    "VALUES (:doctorId, :patientId, :date, :heure, 'CONFIRME', :type)";

            Query query = em.createNativeQuery(sql);
            Appointment appointment = new Appointment();
            Doctor doctor = new Doctor();
            doctor.setId(doctorId);
            Patient patient = new Patient();
            patient.setId(patientId);

            appointment.setDocteur(doctor);
            appointment.setPatient(patient);
            appointment.setDate(date);
            appointment.setHeure(heure);
            appointment.setStatut("CONFIRME");
            appointment.setType(type != null ? type : "CONSULTATION");
            em.persist(appointment);

            int inserted = query.executeUpdate();
            tx.commit();

            System.out.println("✅ AppointmentDAO: Inserted " + inserted + " appointment");
            return inserted > 0;

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            System.err.println("❌ AppointmentDAO: Error creating appointment");
            e.printStackTrace();
            return false;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * جيب appointments ديال patient
     *
     * @param patientId معرف المريض
     * @return List<Appointment> قائمة المواعيد
     */
    public List<Appointment> findByPatient(Integer patientId) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 AppointmentDAO: Finding appointments for patient " + patientId);

            String sql = "SELECT a.date, a.heure, a.statut, a.type " +
                    "FROM appointments a " +
                    "WHERE a.patient_id = :patientId " +
                    "ORDER BY a.date DESC, a.heure DESC";

            Query query = em.createNativeQuery(sql);
            Patient patient = new Patient();
            patient.setId(patientId);
            em.persist(patient);

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            List<Appointment> appointments = new ArrayList<>();
            for (Object[] row : results) {
                Appointment appt = new Appointment();
                appt.setDate((String) row[0]);
                appt.setHeure((String) row[1]);
                appt.setStatut((String) row[2]);
                appt.setType((String) row[3]);
                appointments.add(appt);
            }

            System.out.println("✅ AppointmentDAO: Found " + appointments.size() + " patient appointments");
            return appointments;

        } catch (Exception e) {
            System.err.println("❌ AppointmentDAO: Error in findByPatient");
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
     *
     * @param doctorId معرف الطبيب
     * @param date التاريخ
     * @param heure الوقت
     */
    public void cancel(Integer doctorId, String date, String heure) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            System.out.println("❌ AppointmentDAO: Cancelling appointment");
            System.out.println("   Doctor: " + doctorId + ", Date: " + date + ", Time: " + heure);

            tx = em.getTransaction();
            tx.begin();

            String sql = "UPDATE appointments SET statut = 'ANNULE' " +
                    "WHERE doctor_id = :doctorId " +
                    "AND date = :date " +
                    "AND heure = :heure";

            Query query = em.createNativeQuery(sql);
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);
            query.setParameter("heure", heure);

            int updated = query.executeUpdate();
            tx.commit();

            System.out.println("✅ AppointmentDAO: Cancelled " + updated + " appointment(s)");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            System.err.println("❌ AppointmentDAO: Error cancelling appointment");
            e.printStackTrace();
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
            System.out.println("🔍 AppointmentDAO: Finding all appointments for doctor " + doctorId);

            String sql = "SELECT date, heure, statut, type FROM appointments " +
                    "WHERE doctor_id = :doctorId " +
                    "ORDER BY date DESC, heure DESC";

            Query query = em.createNativeQuery(sql);
            query.setParameter("doctorId", doctorId);

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            List<Appointment> appointments = new ArrayList<>();
            for (Object[] row : results) {
                Appointment appt = new Appointment();
                appt.setDate((String) row[0]);
                appt.setHeure((String) row[1]);
                appt.setStatut((String) row[2]);
                appt.setType((String) row[3]);
                appointments.add(appt);
            }

            System.out.println("✅ AppointmentDAO: Found " + appointments.size() + " doctor appointments");
            return appointments;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Close EntityManagerFactory (call عند shutdown)
     */
    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}