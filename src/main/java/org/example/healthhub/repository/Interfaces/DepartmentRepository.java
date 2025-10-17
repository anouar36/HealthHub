package org.example.healthhub.repository.Interfaces;

import org.example.healthhub.entity.Department;
import java.util.List;

public interface DepartmentRepository {
    List<Department> getAllDepartments();
}
