package org.example.healthhub.repository.implement;

import jakarta.persistence.*;
import jakarta.persistence.criteria.*;
import org.example.healthhub.entity.Department;
import org.example.healthhub.entity.Doctor;
import org.example.healthhub.entity.Specialty;
import org.example.healthhub.entity.User;
import org.example.healthhub.repository.Interfaces.DoctorRepository;

import java.util.Collections;
import java.util.List;

public class DoctorDAO implements DoctorRepository {
     private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("HealthHubPU");


    @Override
    public List<Doctor> findAllDoctors() {
        try (EntityManager em = emf.createEntityManager()) {
            TypedQuery<Doctor> query = em.createQuery("SELECT d FROM Doctor d", Doctor.class);
            return query.getResultList();
        }
    }
    @Override
    public Doctor findById(int id) {
        try (EntityManager em = emf.createEntityManager()) {
            return em.find(Doctor.class, id);
        }
    }

    @Override
    public Doctor save(Doctor doctor) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(doctor);
            em.getTransaction().commit();
            return doctor;
        } finally {
            em.close();
        }
    }

    @Override
    public Doctor update(Doctor doctor) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = null;

        try {
            System.out.println("💾 DoctorDAO: Updating doctor ID: " + doctor.getId());

            transaction = em.getTransaction();
            transaction.begin();

            // ✅ User deja updated f UserDAO, ghir merge Doctor
            Doctor updatedDoctor = em.merge(doctor);

            transaction.commit();

            System.out.println("✅ DoctorDAO: Doctor updated successfully!");

            return updatedDoctor;

        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            System.out.println("❌ DoctorDAO: Error updating doctor:");
            e.printStackTrace();
            throw new RuntimeException("Error updating doctor: " + e.getMessage());

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    public List<Doctor> findByDepartmentId(String departmentId) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("🔍 DoctorDAO: Finding doctors for department ID: " + departmentId);

            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery<Doctor> cq = cb.createQuery(Doctor.class);
            Root<Doctor> doctor = cq.from(Doctor.class);

            // ✅ EAGER FETCH specialty, department, w user
            Fetch<Doctor, Specialty> specialtyFetch = doctor.fetch("specialty", JoinType.LEFT);
            specialtyFetch.fetch("department", JoinType.LEFT); // fetch department inside specialty
            doctor.fetch("user", JoinType.LEFT);

            // Join for WHERE clause
            Join<Doctor, Specialty> specialty = doctor.join("specialty", JoinType.INNER);
            Join<Specialty, Department> department = specialty.join("department", JoinType.INNER);

            // Detect ila departmentId numeric wla code
            Predicate deptPredicate;
            try {
                Integer depIdInt = Integer.valueOf(departmentId);
                deptPredicate = cb.equal(department.get("id"), depIdInt);
                System.out.println("🔎 Using department.id = " + depIdInt);
            } catch (NumberFormatException ex) {
                deptPredicate = cb.equal(department.get("code"), departmentId);
                System.out.println("🔎 Using department.code = " + departmentId);
            }

            cq.select(doctor)
                    .where(deptPredicate)
                    .distinct(true); // prevent duplicates

            List<Doctor> results = em.createQuery(cq).getResultList();
            System.out.println("✅ DoctorDAO: Found " + results.size() + " doctors");
            return results;

        } catch (Exception e) {
            System.err.println("❌ DoctorDAO: Error:");
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }
    @Override
    public Boolean delete(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Doctor doctor = em.find(Doctor.class, id);
            if (doctor != null) {
                em.remove(doctor);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } finally {
            em.close();
        }
    }
}