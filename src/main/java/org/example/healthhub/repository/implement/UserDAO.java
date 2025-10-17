package org.example.healthhub.repository.implement;

import jakarta.persistence.*;
import jakarta.persistence.criteria.*;
import org.example.healthhub.dto.DoctorDTO;
import org.example.healthhub.entity.Doctor;
import org.example.healthhub.entity.User;
import org.example.healthhub.repository.Interfaces.UserRepository;

import java.util.ArrayList;
import java.util.List;

public class UserDAO implements UserRepository {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("HealthHubPU");


    @Override
    public User login(User user) {
        EntityManager em = emf.createEntityManager();
        try{
            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery<User> cq = cb.createQuery(User.class);
            Root<User> root = cq.from(User.class);

            Predicate emailPredicate = cb.equal(root.get("email"),user.getEmail());
            Predicate passwordPredicate = cb.equal(root.get("password"),user.getPassword());

            cq.select(root).where(cb.and(emailPredicate,passwordPredicate));

            return em.createQuery(cq).getResultStream().findFirst().orElse(null);

        } finally {
            em.close();
        }
    }

    @Override
    public User register(User user) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user); // Hibernate handles INSERT automatically
            em.getTransaction().commit();
            return user;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public User save(User user) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
            return user;
        } finally {
            em.close();
        }
    }

    @Override
    public User update(User user) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = null;

        try {
            System.out.println("💾 UserDAO: Updating user ID: " + user.getId());
            System.out.println("  Name: " + user.getNom());
            System.out.println("  Email: " + user.getEmail());
            System.out.println("  Actif: " + user.getActif());

            transaction = em.getTransaction();
            transaction.begin();

            User merged = em.merge(user);

            transaction.commit();

            System.out.println("✅ UserDAO: User updated successfully!");

            return merged;

        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            System.out.println("❌ UserDAO: Error updating user:");
            e.printStackTrace();
            throw new RuntimeException("Error updating user: " + e.getMessage());

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

}
