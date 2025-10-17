        package org.example.healthhub.service;

        import org.example.healthhub.dto.Doctor.DoctorCreateDTO;
        import org.example.healthhub.dto.Doctor.DoctorDepartmentSpecialtyDTO;
        import org.example.healthhub.dto.Doctor.DoctorUpdateDTO;
        import org.example.healthhub.dto.DoctorDTO;
        import org.example.healthhub.entity.Doctor;
        import org.example.healthhub.entity.Specialty;
        import org.example.healthhub.entity.User;
        import org.example.healthhub.repository.Enums.Role;
        import org.example.healthhub.repository.implement.DoctorDAO;
        import org.example.healthhub.repository.implement.UserDAO;
        import org.modelmapper.ModelMapper;

        import java.util.List;
        import java.util.stream.Collectors;

        public class DoctorService {
            private final DoctorDAO doctorDAO;
            private final ModelMapper modelMapper;
            private  final UserDAO userDAO;

            public DoctorService() {
                this.doctorDAO = new DoctorDAO();
                this.userDAO = new UserDAO();
                this.modelMapper = new ModelMapper();

                // Mapping for Doctor -> DoctorDTO
                modelMapper.typeMap(Doctor.class, DoctorDTO.class).addMappings(mapper -> {
                    mapper.map(src -> src.getUser().getNom(), DoctorDTO::setNom);
                    mapper.map(src -> src.getUser().getEmail(), DoctorDTO::setEmail);
                    mapper.map(src -> src.getUser().getActif(), DoctorDTO::setActif);
                });
            }

            public DoctorDTO addDoctor(DoctorCreateDTO dto) {
                User user = new User();

                user.setNom(dto.getNom());
                user.setEmail(dto.getEmail());
                user.setPassword(dto.getPassword());
                user.setActif(dto.isActif());
                user.setRole(Role.valueOf(dto.getRole().toUpperCase()));

                Specialty specialty = new Specialty();
                specialty.setNom(dto.getSpecialite());

                Doctor doctor = new Doctor();
                doctor.setMatricule(dto.getMatricule());
                doctor.setTitre(dto.getTitre());
                doctor.setSpecialty(specialty);
                doctor.setUser(user);



                Doctor savedDoctor = doctorDAO.save(doctor); // Hibernate will save both doctor and user

                return modelMapper.map(savedDoctor, DoctorDTO.class);
            }


            public List<DoctorDTO> getAllDoctor() {
                List<Doctor> doctors = doctorDAO.findAllDoctors();
                doctors.forEach(System.out::println); // Optional: for debugging
                return doctors.stream()
                        .map(doctor -> modelMapper.map(doctor, DoctorDTO.class))
                        .collect(Collectors.toList());
            }

            public DoctorDTO findDoctorById(int id) {
                Doctor doctor = doctorDAO.findById(id);
                if (doctor == null) return null;
                return modelMapper.map(doctor, DoctorDTO.class);
            }

            public DoctorDTO updateDoctor(DoctorUpdateDTO dto) {
                System.out.println("====================================");
                System.out.println("🔧 SERVICE: updateDoctor");
                System.out.println("====================================");

                // 1. Find existing doctor
                Doctor existingDoctor = doctorDAO.findById(dto.getId());
                if (existingDoctor == null) {
                    throw new RuntimeException("Doctor not found with ID: " + dto.getId());
                }

                System.out.println("✅ Doctor found: " + existingDoctor.getMatricule());

                // 2. Update Doctor fields
                System.out.println("📝 Updating Doctor fields...");
                existingDoctor.setMatricule(dto.getMatricule());
                existingDoctor.setTitre(dto.getTitre());
                Specialty specialty = new Specialty();
                specialty.setNom(dto.getSpecialite());
                existingDoctor.setSpecialty(specialty);

                // 3. Update User fields
                User user = existingDoctor.getUser();
                if (user != null) {
                    System.out.println("📝 Updating User fields...");
                    System.out.println("  Old Name: " + user.getNom() + " → New: " + dto.getNom());
                    System.out.println("  Old Email: " + user.getEmail() + " → New: " + dto.getEmail());

                    user.setNom(dto.getNom());
                    user.setEmail(dto.getEmail());
                    user.setActif(dto.isActif());

                    System.out.println("💾 Updating User in database...");
                    User updatedUser = userDAO.update(user);
                    System.out.println("✅ User updated: " + updatedUser.getEmail());

                } else {
                    System.out.println("⚠️ WARNING: Doctor has no linked User!");
                }

                // 4. Update Doctor
                System.out.println("💾 Updating Doctor in database...");
                Doctor updated = doctorDAO.update(existingDoctor);
                System.out.println("✅ Doctor updated!");

                // 5. Convert to DTO
                DoctorDTO result = modelMapper.map(updated, DoctorDTO.class);

                System.out.println("✅ Update completed successfully!");
                System.out.println("====================================");

                return result;
            }

            public boolean deleteDoctor(Long id) {
                return doctorDAO.delete(id);
            }

            public List<DoctorDepartmentSpecialtyDTO> getDoctorsByDepartmentId(String departmentId) {
                List<Doctor> doctors = doctorDAO.findByDepartmentId(departmentId);
                return doctors.stream()
                        .map(doctor -> {

                            DoctorDepartmentSpecialtyDTO dto = modelMapper.map(doctor,DoctorDepartmentSpecialtyDTO.class);

                            // Add specialty name
                            if (doctor.getSpecialty() != null) {
                                dto.setDepartmentName(doctor.getSpecialty().getDepartment().getNom());
                                dto.setSpecialtyId(doctor.getSpecialty().getId());
                            }
                            // Add department ID
                            if (doctor.getSpecialty() != null && doctor.getSpecialty().getDepartment() != null) {
                                dto.setDepartmentCode(doctor.getSpecialty().getDepartment().getCode());
                            }
                            return dto;
                        })
                        .collect(Collectors.toList());
            }
        }
