package org.example.healthhub.repository.implement;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import org.example.healthhub.entity.Specialty;
import org.example.healthhub.repository.Interfaces.SpecialtyRepository;


public class SpecialtyDAO implements SpecialtyRepository {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("HealthHubPU");

    public void create(Specialty specialty) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(specialty);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error: " + e.getMessage());
        } finally {
            em.close();
        }
    }
}
