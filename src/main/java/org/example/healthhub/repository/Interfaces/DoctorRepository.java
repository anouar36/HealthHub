package org.example.healthhub.repository.Interfaces;

import org.example.healthhub.entity.Doctor;

import java.util.List;

public interface DoctorRepository {
    List<Doctor> findAllDoctors();
    Doctor findById(int id);
    Doctor save(Doctor doctor);
    Doctor update(Doctor doctor);
    Boolean delete(Long id);
    List<Doctor> findByDepartmentId(String departmentId);


}
