package org.example.healthhub.repository.implement;

import jakarta.persistence.*;
import org.example.healthhub.entity.Department;
import org.example.healthhub.repository.Interfaces.DepartmentRepository;

import java.util.List;

public class DepartmentDAO implements DepartmentRepository {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("HealthHubPU");

    @Override
    public List<Department> getAllDepartments() {
        try (EntityManager em = emf.createEntityManager()) {
            TypedQuery<Department> query =
                    em.createQuery("SELECT d FROM Department d", Department.class);
            return query.getResultList();
        }
    }

    public Department createDepartment(Department department) {
        EntityManager em = null;
        EntityTransaction transaction = null;

        try {
            em = emf.createEntityManager();
            transaction = em.getTransaction();
            transaction.begin();

            em.persist(department);

            transaction.commit();

            System.out.println("✅ Department created successfully: " + department.getCode());
            return department;

        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Failed to create department: " + e.getMessage());

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public Department findByCode(String code) {
        EntityManager em = emf.createEntityManager();
        try {
            Department department = em.createQuery(
                            "SELECT d FROM Department d WHERE d.code = :code",
                            Department.class
                    )
                    .setParameter("code", code)
                    .getSingleResult();

            return department;

        } catch (NoResultException e) {
            System.out.println("❌ Department not found with code: " + code);
            return null;

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error finding department: " + e.getMessage());

        } finally {
            em.close();
        }
    }

    public Boolean deleteDepartment(String code) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        boolean delete = false;
        try{
            tx.begin();

            Department department = em.find(Department.class,code);

            if(department != null){
                em.remove(department);
                delete = true;
            }
            tx.commit();
        }catch (Exception e){
            tx.rollback();
            e.printStackTrace();

        }finally {
            em.close();
        }
        return delete;
    }
}
