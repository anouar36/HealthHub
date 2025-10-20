package org.example.healthhub.repository.implement;

import org.example.healthhub.entity.Availability;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class AvailabilityDAO {

    private EntityManagerFactory emf;

    /**
     * Constructor — Create EMF directly
     */
    public AvailabilityDAO() {
        this.emf = Persistence.createEntityManagerFactory("HealthHubPU");  // ✅ Same name
    }

    /**
     * Constructor مع EMF injection (optional)
     */
    public AvailabilityDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    /**
     * جيب availabilities ديال doctor حسب jour (يوم الأسبوع)
     *
     * @param doctorId معرف الطبيب
     * @param jour اسم اليوم ("Lundi", "Mardi", etc)
     * @return List<Availability> قائمة التوفرات
     */
    public List<Availability> findByDoctorAndJour(Integer doctorId, String jour) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 AvailabilityDAO: Finding availabilities for doctor " + doctorId + " on " + jour);

            // ✅ استعمل positional parameters (?1, ?2) بدل named parameters
                    String sql = "SELECT jour, heure_debut, heure_fin, statut, validite " +
                            "FROM availabilities " +
                            "WHERE doctor_id = ?1 " +
                            "AND jour= ?2 " +
                            "AND (statut IS NULL OR statut = 'DISPONIBLE') " +
                            "ORDER BY heure_debut";

            Query query = em.createNativeQuery(sql);
            query.setParameter(1, doctorId);  // ✅ positional parameter
            query.setParameter(2, jour);       // ✅ positional parameter

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            List<Availability> availabilities = new ArrayList<>();
            for (Object[] row : results) {
                Availability avail = new Availability();
                avail.setJour((String) row[0]);        // ✅ FIXED: setJour بدل set
                avail.setHeureDebut((String) row[1]);
                avail.setHeureFin((String) row[2]);
                avail.setStatut((String) row[3]);
                avail.setValidite((String) row[4]);
                availabilities.add(avail);
            }

            System.out.println("✅ AvailabilityDAO: Found " + availabilities.size() + " availability records");
            return availabilities;

        } catch (Exception e) {
            System.err.println("❌ AvailabilityDAO: Error in findByDoctorAndJour");
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * جيب كل availabilities ديال doctor (كل الأيام)
     *
     * @param doctorId معرف الطبيب
     * @return List<Availability> جميع التوفرات
     */
    public List<Availability> findByDoctor(Integer doctorId) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 AvailabilityDAO: Finding all availabilities for doctor " + doctorId);

            String sql = "SELECT jour, heure_debut, heure_fin, statut, validite " +
                    "FROM availabilities " +
                    "WHERE doctor_id = ?1 " +
                    "AND (statut IS NULL OR statut = 'DISPONIBLE') " +
                    "ORDER BY CASE jour " +
                    "  WHEN 'Lundi' THEN 1 " +
                    "  WHEN 'Mardi' THEN 2 " +
                    "  WHEN 'Mercredi' THEN 3 " +
                    "  WHEN 'Jeudi' THEN 4 " +
                    "  WHEN 'Vendredi' THEN 5 " +
                    "  WHEN 'Samedi' THEN 6 " +
                    "  WHEN 'Dimanche' THEN 7 " +
                    "END, heure_debut";

            Query query = em.createNativeQuery(sql);
            query.setParameter(1, doctorId);

            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();

            List<Availability> availabilities = new ArrayList<>();
            for (Object[] row : results) {
                Availability avail = new Availability();
                avail.setJour((String) row[0]);
                avail.setHeureDebut((String) row[1]);
                avail.setHeureFin((String) row[2]);
                avail.setStatut((String) row[3]);
                avail.setValidite((String) row[4]);
                availabilities.add(avail);
            }

            System.out.println("✅ AvailabilityDAO: Found " + availabilities.size() + " total availabilities");
            return availabilities;

        } catch (Exception e) {
            System.err.println("❌ AvailabilityDAO: Error in findByDoctor");
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Create availability جديد
     *
     * @param doctorId معرف الطبيب
     * @param availability بيانات التوفر
     */
    public void save(Integer doctorId, Availability availability) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            System.out.println("💾 AvailabilityDAO: Saving availability for doctor " + doctorId);

            tx = em.getTransaction();
            tx.begin();

            String sql = "INSERT INTO availabilities (doctor_id, jour, heure_debut, heure_fin, statut, validite) " +
                    "VALUES (?1, ?2, ?3, ?4, ?5, ?6)";

            Query query = em.createNativeQuery(sql);
            query.setParameter(1, doctorId);
            query.setParameter(2, availability.getJour());
            query.setParameter(3, availability.getHeureDebut());
            query.setParameter(4, availability.getHeureFin());
            query.setParameter(5, availability.getStatut() != null ? availability.getStatut() : "DISPONIBLE");
            query.setParameter(6, availability.getValidite());

            int inserted = query.executeUpdate();
            tx.commit();

            System.out.println("✅ AvailabilityDAO: Inserted " + inserted + " availability record");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            System.err.println("❌ AvailabilityDAO: Error saving availability");
            e.printStackTrace();
            throw new RuntimeException("Failed to save availability", e);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * حذف availability
     *
     * @param doctorId معرف الطبيب
     * @param jour اليوم
     * @param heureDebut وقت البداية
     */
    public void delete(Integer doctorId, String jour, String heureDebut) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            System.out.println("🗑️ AvailabilityDAO: Deleting availability for doctor " + doctorId + " on " + jour + " at " + heureDebut);

            tx = em.getTransaction();
            tx.begin();

            String sql = "DELETE FROM availabilities " +
                    "WHERE doctor_id = ?1 " +
                    "AND jour = ?2 " +
                    "AND heure_debut = ?3";

            Query query = em.createNativeQuery(sql);
            query.setParameter(1, doctorId);
            query.setParameter(2, jour);
            query.setParameter(3, heureDebut);

            int deleted = query.executeUpdate();
            tx.commit();

            System.out.println("✅ AvailabilityDAO: Deleted " + deleted + " availability record(s)");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            System.err.println("❌ AvailabilityDAO: Error deleting availability");
            e.printStackTrace();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * تحديث statut ديال availability
     */
    public void updateStatut(Integer doctorId, String jour, String heureDebut, String newStatut) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = null;
        try {
            System.out.println("🔄 AvailabilityDAO: Updating statut for doctor " + doctorId);

            tx = em.getTransaction();
            tx.begin();

            String sql = "UPDATE availabilities SET statut = ?1 " +
                    "WHERE doctor_id = ?2 AND jour = ?3 AND heure_debut = ?4";

            Query query = em.createNativeQuery(sql);
            query.setParameter(1, newStatut);
            query.setParameter(2, doctorId);
            query.setParameter(3, jour);
            query.setParameter(4, heureDebut);

            int updated = query.executeUpdate();
            tx.commit();

            System.out.println("✅ AvailabilityDAO: Updated " + updated + " record(s)");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            System.err.println("❌ AvailabilityDAO: Error updating statut");
            e.printStackTrace();
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