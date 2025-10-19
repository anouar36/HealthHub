package org.example.healthhub.repository.Interfaces;

import org.example.healthhub.entity.Patient;
import java.util.List;
import java.util.Optional;

public interface PatientRepository {

    // Basic CRUD
    Patient save(Patient patient);
    //Patient findById(Long id);
    List<Patient> findAll();
    Patient update(Patient patient);
    Boolean delete(Integer id);

    // Custom queries
    Optional<Patient> findByUsername(String username);
    Optional<Patient> findByEmail(String email);
    //boolean existsByUsername(String username);
    Patient findById(Integer id) throws Exception;
    boolean existsByEmail(String email);
}