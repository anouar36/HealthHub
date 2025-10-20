package org.example.healthhub.service;

import org.example.healthhub.dto.Patient.PatientCreateDTO;
import org.example.healthhub.dto.Patient.PatientDTO;
import org.example.healthhub.dto.Patient.PatientUpdateDTO;
import org.example.healthhub.entity.Patient;
import org.example.healthhub.repository.Enums.Role;
import org.example.healthhub.repository.implement.PatientDAO;
import org.modelmapper.ModelMapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


public class PatientService {

    private final PatientDAO patientDAO;
    private final ModelMapper modelMapper;


    public PatientService() {
        this.patientDAO = new PatientDAO();
        this.modelMapper = new ModelMapper();

    }

    /**
     * Get all patients
     */
    /**
     * Get patient by username (returns null if not found)
     */
    public PatientDTO getPatientByUsernameSimple(String username) {
        System.out.println("🔍 PatientService: Getting patient by username: " + username);

        try {
            Patient patient = patientDAO.findByUsernameSimple(username);

            if (patient == null) {
                System.out.println("⚠️ PatientService: Patient not found for username: " + username);
                return null;
            }

            PatientDTO dto = new PatientDTO();
            dto.setId(patient.getId());
            dto.setNom(patient.getNom());
            dto.setEmail(patient.getEmail());
            dto.setCIN(patient.getCIN());
            dto.setTelephone(patient.getTelephone());
            dto.setAdresse(patient.getAdresse());
            dto.setSexe(patient.getSexe());
            dto.setNaissance(patient.getNaissance());
            dto.setSang(patient.getSang());
            dto.setActif(patient.getActif());

            System.out.println("✅ PatientService: Found patient ID=" + dto.getId() + ", Nom=" + dto.getNom());
            return dto;

        } catch (Exception e) {
            System.err.println("❌ PatientService: Error getting patient");
            e.printStackTrace();
            return null;
        }
    }
    public List<PatientDTO> getAllPatients() {
        try {
            List<Patient> patients = patientDAO.findAll();
            return patients.stream()
                    .map(patient -> modelMapper.map(patient, PatientDTO.class))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to retrieve patients", e);
        }
    }

    /**
     * Get patient by ID
     */
    public PatientDTO getPatientById(Integer id) {
        try {
            if (id == null) {
                throw new IllegalArgumentException("Patient ID cannot be null");
            }

            Patient patient = patientDAO.findById(id);

            if (patient == null) {
                return null;
            }

            return modelMapper.map(patient, PatientDTO.class);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to retrieve patient by ID: " + id, e);
        }
    }

    /**
     * Get patient by CIN
     */
    public PatientDTO getPatientByCIN(String CIN) {
        try {
            if (CIN == null || CIN.trim().isEmpty()) {
                throw new IllegalArgumentException("CIN cannot be null or empty");
            }

            Patient patient = patientDAO.findByCIN(CIN);

            if (patient == null) {
                return null;
            }

            return modelMapper.map(patient, PatientDTO.class);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to retrieve patient by CIN", e);
        }
    }
    public Optional<PatientDTO> getPatientByUsername(String username) {
        System.out.println("📋 PatientService: Getting patient by username: " + username);

        try {
            Optional<Patient> patientOpt = patientDAO.findByUsername(username);

            if (patientOpt.isPresent()) {
                Patient patient = patientOpt.get();
                PatientDTO dto =modelMapper.map(patient,PatientDTO.class);

                System.out.println("✅ PatientService: Patient found - " + dto.getNom());
                return Optional.of(dto);
            } else {
                System.out.println("⚠️ PatientService: Patient not found for username: " + username);
                return Optional.empty();
            }

        } catch (Exception e) {
            System.err.println("❌ PatientService: Error getting patient: " + e.getMessage());
            e.printStackTrace();
            return Optional.empty();
        }
    }

    /**
     * Get patient by Email
     */
    public PatientDTO getPatientByEmail(String email) {
        try {
            if (email == null || email.trim().isEmpty()) {
                throw new IllegalArgumentException("Email cannot be null or empty");
            }

             Optional<Patient> patient = patientDAO.findByEmail(email);

            if (patient == null) {
                return null;
            }

            return modelMapper.map(patient, PatientDTO.class);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to retrieve patient by email", e);
        }
    }

    /**
     * Create new patient
     */
    public PatientDTO createPatient(PatientCreateDTO createDTO) {
        try {
            System.out.println("====================================");
            System.out.println("🔵 Creating patient: " + createDTO.getNom());

            validateCreateDTO(createDTO);

            if (patientDAO.existsByCIN(createDTO.getCIN())) {
                throw new IllegalArgumentException("CIN already exists: " + createDTO.getCIN());
            }

            if (patientDAO.existsByEmail(createDTO.getEmail())) {
                throw new IllegalArgumentException("Email already exists: " + createDTO.getEmail());
            }

            // Map DTO to Entity
            Patient patient = modelMapper.map(createDTO, Patient.class);

            // ✅ تأكد أن الـ ID فارغ
            patient.setId(null);

            // Save
            Patient savedPatient = patientDAO.save(patient);

            System.out.println("✅ Patient created with ID: " + savedPatient.getId());
            System.out.println("====================================");

            return modelMapper.map(savedPatient, PatientDTO.class);

        } catch (IllegalArgumentException e) {
            System.err.println("❌ Validation error: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            System.err.println("❌ Unexpected error: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to create patient", e);
        }
    }
    /**
     * Update existing patient
     */
    public PatientDTO updatePatient(PatientUpdateDTO updateDTO) {
        try {
            if (updateDTO.getId() == null) {
                throw new IllegalArgumentException("Patient ID is required for update");
            }

            Patient existingPatient = patientDAO.findById(updateDTO.getId());

            if (existingPatient == null) {
                return null;
            }

            validateUpdateDTO(updateDTO);

            if (!existingPatient.getCIN().equals(updateDTO.getCIN())) {
                if (patientDAO.existsByCIN(updateDTO.getCIN())) {
                    throw new IllegalArgumentException("CIN already exists: " + updateDTO.getCIN());
                }
            }

            if (!existingPatient.getEmail().equals(updateDTO.getEmail())) {
                if (patientDAO.existsByEmail(updateDTO.getEmail())) {
                    throw new IllegalArgumentException("Email already exists: " + updateDTO.getEmail());
                }
            }

            existingPatient.setNom(updateDTO.getNom());
            existingPatient.setEmail(updateDTO.getEmail());
            existingPatient.setCIN(updateDTO.getCIN());
            existingPatient.setNaissance(updateDTO.getNaissance());
            existingPatient.setSexe(updateDTO.getSexe());
            existingPatient.setTelephone(updateDTO.getTelephone());
            existingPatient.setAdresse(updateDTO.getAdresse());
            existingPatient.setSang(updateDTO.getSang());

            if (updateDTO.getActif() != null) {
                existingPatient.setActif(updateDTO.getActif());
            }

            Patient updatedPatient = patientDAO.update(existingPatient);

            return modelMapper.map(updatedPatient, PatientDTO.class);

        } catch (IllegalArgumentException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to update patient", e);
        }
    }

    /**
     * Delete patient
     */
    public boolean deletePatient(Integer id) {
        try {
            if (id == null) {
                throw new IllegalArgumentException("Patient ID cannot be null");
            }

            return patientDAO.delete(id);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to delete patient", e);
        }
    }


    /**
     * Get active patients only
     */
    public List<PatientDTO> getActivePatients() {
        try {
            List<Patient> patients = patientDAO.findActivePatients();
            return patients.stream()
                    .map(patient -> modelMapper.map(patients, PatientDTO.class))
                    .collect(Collectors.toList());

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get active patients", e);
        }
    }

    /**
     * Get total patient count
     */
    public Long getTotalPatientCount() {
        try {
            return patientDAO.count();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get patient count", e);
        }
    }

    /**
     * Activate/Deactivate patient
     */
    public boolean togglePatientStatus(Integer id) {
        try {
            if (id == null) {
                throw new IllegalArgumentException("Patient ID cannot be null");
            }

            Patient patient = patientDAO.findById(id);

            if (patient == null) {
                return false;
            }

            patient.setActif(!patient.getActif());
            patientDAO.update(patient);

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to toggle patient status", e);
        }
    }

    // ==================== VALIDATION METHODS ====================

    private void validateCreateDTO(PatientCreateDTO dto) {
        if (dto.getNom() == null || dto.getNom().trim().isEmpty()) {
            throw new IllegalArgumentException("Le nom est requis");
        }
        if (dto.getEmail() == null || dto.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("L'email est requis");
        }
        if (dto.getCIN() == null || dto.getCIN().trim().isEmpty()) {
            throw new IllegalArgumentException("Le CIN est requis");
        }
        if (dto.getTelephone() == null || dto.getTelephone().trim().isEmpty()) {
            throw new IllegalArgumentException("Le téléphone est requis");
        }
        if (dto.getNaissance() == null) {
            throw new IllegalArgumentException("La date de naissance est requise");
        }
        if (dto.getSexe() == null || dto.getSexe().trim().isEmpty()) {
            throw new IllegalArgumentException("Le sexe est requis");
        }
        if (dto.getPassword() == null || dto.getPassword().length() < 6) {
            throw new IllegalArgumentException("Le mot de passe doit contenir au moins 6 caractères");
        }
    }

    private void validateUpdateDTO(PatientUpdateDTO dto) {
        if (dto.getNom() == null || dto.getNom().trim().isEmpty()) {
            throw new IllegalArgumentException("Le nom est requis");
        }
        if (dto.getEmail() == null || dto.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("L'email est requis");
        }
        if (dto.getCIN() == null || dto.getCIN().trim().isEmpty()) {
            throw new IllegalArgumentException("Le CIN est requis");
        }
        if (dto.getTelephone() == null || dto.getTelephone().trim().isEmpty()) {
            throw new IllegalArgumentException("Le téléphone est requis");
        }
        if (dto.getNaissance() == null) {
            throw new IllegalArgumentException("La date de naissance est requise");
        }
        if (dto.getSexe() == null || dto.getSexe().trim().isEmpty()) {
            throw new IllegalArgumentException("Le sexe est requis");
        }
    }

}