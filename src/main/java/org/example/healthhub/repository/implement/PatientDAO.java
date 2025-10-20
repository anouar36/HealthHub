package org.example.healthhub.repository.implement;

import jakarta.persistence.*;
import jakarta.persistence.criteria.*;
import org.example.healthhub.entity.Patient;
import org.example.healthhub.entity.User;
import org.example.healthhub.repository.Enums.Role;
import org.example.healthhub.repository.Interfaces.PatientRepository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;


public class PatientDAO implements PatientRepository {

    private SessionFactory sessionFactory;
    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("HealthHubPU");
    public PatientDAO() {
        this.sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    /**
     * Find patient by username (returns null if not found)
     */
    public Patient findByUsernameSimple(String username) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 PatientDAO: Finding patient by username: " + username);

            String jpql = "SELECT p FROM Patient p " +
                    "WHERE p.email = :username " +
                    "AND p.actif = true";

            TypedQuery<Patient> query = em.createQuery(jpql, Patient.class);
            query.setParameter("username", username);
            query.setMaxResults(1);

            List<Patient> results = query.getResultList();

            if (results.isEmpty()) {
                System.out.println("⚠️ PatientDAO: No patient found for: " + username);
                return null;
            }

            Patient patient = results.get(0);
            System.out.println("✅ PatientDAO: Found patient ID=" + patient.getId() + ", Nom=" + patient.getNom());

            return patient;

        } catch (Exception e) {
            System.err.println("❌ PatientDAO: Error in findByUsernameSimple");
            e.printStackTrace();
            return null;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    public Patient save(Patient patient) {
        Transaction transaction = null;
        Session session = sessionFactory.openSession();

        try {
            transaction = session.beginTransaction();


            patient.setId(null);

            if (patient.getActif() == null) {
                patient.setActif(true);
            }
            if (patient.getRole() == null) {
                patient.setRole(Role.PATIENT);
            }

            session.persist(patient);

            session.flush();

            transaction.commit();

            System.out.println("✅ Patient saved with ID: " + patient.getId());

            return patient;

        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("❌ Error saving patient: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to save patient", e);
        } finally {
            session.close();
        }
    }

    @Override
    public Patient update(Patient patient) {
        Transaction transaction = null;
        Session session = sessionFactory.openSession();

        try {
            transaction = session.beginTransaction();
            session.update(patient);
            transaction.commit();

            return patient;

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Failed to update patient", e);
        } finally {
            session.close();
        }
    }

    /**
     * Delete a patient by ID
     */
    @Override
    public Boolean delete(Integer id) {
        Transaction transaction = null;
        Session session = sessionFactory.openSession();

        try {
            transaction = session.beginTransaction();

            Patient patient = session.get(Patient.class, id);

            if (patient != null) {
                session.delete(patient);
                transaction.commit();
                return true;
            }

            transaction.commit();
            return false;

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Failed to delete patient", e);
        } finally {
            session.close();
        }
    }


    @Override
    public Optional<Patient> findByEmail(String email) {
        EntityManager em = emf.createEntityManager();
        try {
            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery<Patient> cq = cb.createQuery(Patient.class);
            Root<Patient> patient = cq.from(Patient.class);

            // Fetch user
            patient.fetch("user", JoinType.LEFT);

            // Join for WHERE
            Join<Patient, User> userJoin = patient.join("user", JoinType.INNER);

            // WHERE
            Predicate emailPredicate = cb.equal(userJoin.get("email"), email);

            cq.select(patient)
                    .distinct(true)
                    .where(emailPredicate);

            TypedQuery<Patient> query = em.createQuery(cq);

            try {
                return Optional.of(query.getSingleResult());
            } catch (NoResultException e) {
                return Optional.empty();
            }
        } finally {
            em.close();
        }
    }

    /**
     * Get all patients
     */
    @Override
    public List<Patient> findAll() {
        Session session = sessionFactory.openSession();

        try {
            Query<Patient> query = session.createQuery("FROM Patient ORDER BY nom ASC", Patient.class);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Failed to retrieve patients", e);
        } finally {
            session.close();
        }
    }

    /**
     * Find patient by CIN
     */
    public Patient findByCIN(String CIN) {
        Session session = sessionFactory.openSession();

        try {
            Query<Patient> query = session.createQuery("FROM Patient WHERE CIN = :cin", Patient.class);
            query.setParameter("cin", CIN);

            List<Patient> results = query.list();
            return results.isEmpty() ? null : results.get(0);

        } catch (Exception e) {
            throw new RuntimeException("Failed to find patient by CIN", e);
        } finally {
            session.close();
        }
    }




    /**
     * Search patients by name, CIN, or email
     */
    public List<Patient> search(String searchTerm) {
        Session session = sessionFactory.openSession();

        try {
            Query<Patient> query = session.createQuery(
                    "FROM Patient WHERE LOWER(nom) LIKE LOWER(:search) OR " +
                            "LOWER(CIN) LIKE LOWER(:search) OR " +
                            "LOWER(email) LIKE LOWER(:search) ORDER BY nom ASC",
                    Patient.class
            );
            query.setParameter("search", "%" + searchTerm + "%");

            return query.list();

        } catch (Exception e) {
            throw new RuntimeException("Failed to search patients", e);
        } finally {
            session.close();
        }
    }

    /**
     * Count total patients
     */
    public Long count() {
        Session session = sessionFactory.openSession();

        try {
            Query<Long> query = session.createQuery("SELECT COUNT(p) FROM Patient p", Long.class);
            return query.uniqueResult();
        } catch (Exception e) {
            throw new RuntimeException("Failed to count patients", e);
        } finally {
            session.close();
        }
    }

    /**
     * Check if CIN already exists
     */
    public boolean existsByCIN(String CIN) {
        Session session = sessionFactory.openSession();

        try {
            Query<Long> query = session.createQuery("SELECT COUNT(p) FROM Patient p WHERE p.CIN = :cin", Long.class);
            query.setParameter("cin", CIN);

            Long count = query.uniqueResult();
            return count > 0;

        } catch (Exception e) {
            throw new RuntimeException("Failed to check CIN", e);
        } finally {
            session.close();
        }
    }

    /**
     * Check if email already exists
     */
    public boolean existsByEmail(String email) {
        Session session = sessionFactory.openSession();

        try {
            Query<Long> query = session.createQuery("SELECT COUNT(p) FROM Patient p WHERE p.email = :email", Long.class);
            query.setParameter("email", email);

            Long count = query.uniqueResult();
            return count > 0;

        } catch (Exception e) {
            throw new RuntimeException("Failed to check email", e);
        } finally {
            session.close();
        }
    }

    /**
     * Get patients by blood type
     */
    public List<Patient> findByBloodType(String sang) {
        Session session = sessionFactory.openSession();

        try {
            Query<Patient> query = session.createQuery("FROM Patient WHERE sang = :sang ORDER BY nom ASC", Patient.class);
            query.setParameter("sang", sang);

            return query.list();

        } catch (Exception e) {
            throw new RuntimeException("Failed to find patients by blood type", e);
        } finally {
            session.close();
        }
    }

    /**
     * Get active patients only
     */
    public List<Patient> findActivePatients() {
        Session session = sessionFactory.openSession();

        try {
            Query<Patient> query = session.createQuery("FROM Patient WHERE actif = true ORDER BY nom ASC", Patient.class);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Failed to retrieve active patients", e);
        } finally {
            session.close();
        }
    }

    public Optional<Patient> findByUsername(String username) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 PatientDAO: Finding patient by username: " + username);

            // ✅ Query via inherited User fields
            String jpql = "SELECT p FROM Patient p " +
                    "WHERE p.email = :username " +  // email field من User
                    "AND p.actif = true";

            TypedQuery<Patient> query = em.createQuery(jpql, Patient.class);
            query.setParameter("username", username);
            query.setMaxResults(1);

            List<Patient> results = query.getResultList();

            if (results.isEmpty()) {
                System.out.println("⚠️ PatientDAO: No patient found for: " + username);
                return Optional.empty();
            }

            Patient patient = results.get(0);
            System.out.println("✅ PatientDAO: Found patient ID=" + patient.getId() + ", Nom=" + patient.getNom());

            return Optional.of(patient);

        } catch (Exception e) {
            System.err.println("❌ PatientDAO: Error in findByUsername");
            e.printStackTrace();
            return Optional.empty();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Find patient by ID
     */
    public Patient findById(Integer id) throws Exception {
        EntityManager em = emf.createEntityManager();
        try {
            Patient patient = em.find(Patient.class, id);
            if (patient == null) {
                throw new Exception("Patient with ID " + id + " not found.");
            }
            return patient;
        } catch (Exception e) {
            throw new Exception("Error while finding patient: " + e.getMessage(), e);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

}