package org.example.healthhub.service;

import org.example.healthhub.dto.Department.DepartmentCreatDTO;
import org.example.healthhub.dto.Department.DepartmentDTO;
import org.example.healthhub.dto.Specialty.SpecialtyCreateDTO;
import org.example.healthhub.entity.Department;
import org.example.healthhub.entity.Specialty;
import org.example.healthhub.repository.implement.DepartmentDAO;
import org.example.healthhub.repository.implement.SpecialtyDAO;
import org.modelmapper.ModelMapper;

import java.util.ArrayList;
import java.util.List;

public class DepartmentService {

    private final DepartmentDAO departmentDAO;
    private final ModelMapper modelMapper;
    private final SpecialtyDAO specialtyDAO;


    public DepartmentService() {

        this.departmentDAO = new DepartmentDAO();
        this.modelMapper = new ModelMapper();
        this.specialtyDAO = new SpecialtyDAO();
    }

    public List<DepartmentDTO> getAllDepartments() {
        List<Department> departments = departmentDAO.getAllDepartments();
        List<DepartmentDTO> dtos = new ArrayList<>();

        for (Department d : departments) {
            DepartmentDTO dto = new DepartmentDTO(
                    d.getCode(),
                    d.getNom(),
                    d.getDescription()
            );
            dtos.add(dto);
        }

        return dtos;
    }
    public DepartmentDTO createDepartment(DepartmentCreatDTO departmentCreatDTO){
        Department department = modelMapper.map(departmentCreatDTO,Department.class);
        department = departmentDAO.createDepartment(department);
        return  modelMapper.map(department,DepartmentDTO.class);
    }
    public void addSpecialties(String departmentCode, List<SpecialtyCreateDTO> specialties) {

        Department department = departmentDAO.findByCode(departmentCode);

        if (department == null) {
            throw new IllegalArgumentException("Department not found with code: " + departmentCode);
        }

        System.out.println("✅ Department found: " + department.getNom());

        for (SpecialtyCreateDTO dto : specialties) {

            Specialty specialty = new Specialty();
            specialty.setCode(dto.getDepartmentCode()   );        // ✅ ZIDNA CODE
            specialty.setNom(dto.getNom());
            specialty.setDescription(dto.getDescription());
            specialty.setDepartment(department);

            specialtyDAO.create(specialty);

            System.out.println("✅ Specialty created: " + specialty.getNom());
        }

        System.out.println("✅ Total specialties added: " + specialties.size());
    }
    public DepartmentDTO getDepartmentByCode(String code) {
        System.out.println("====================================");
        System.out.println("🔍 SERVICE: getDepartmentByCode");
        System.out.println("📋 Code: " + code);
        System.out.println("====================================");

        try {
            if (code == null || code.trim().isEmpty()) {
                System.out.println("❌ SERVICE: Invalid code - null or empty");
                throw new IllegalArgumentException("Department code cannot be null or empty");
            }

            // البحث في قاعدة البيانات
            Department department = departmentDAO.findByCode(code.trim());

            if (department == null) {
                System.out.println("❌ SERVICE: Department not found");
                return null;
            }

            DepartmentDTO dto = modelMapper.map(department,DepartmentDTO.class);



            System.out.println("✅ SERVICE: Department found and converted to DTO");
            System.out.println("  Code: " + dto.getCode());
            System.out.println("  Nom: " + dto.getNom());
            System.out.println("  Description: " + dto.getDescription());
            System.out.println("====================================");

            return dto;

        } catch (IllegalArgumentException e) {
            System.out.println("❌ SERVICE: Validation error - " + e.getMessage());
            System.out.println("====================================");
            throw e;

        } catch (Exception e) {
            System.out.println("❌ SERVICE: Unexpected error:");
            e.printStackTrace();
            System.out.println("====================================");
            throw new RuntimeException("Error retrieving department: " + e.getMessage());
        }
    }
    public Boolean deleteDepartment(String code){
         return  departmentDAO.deleteDepartment(code);
    }



}
