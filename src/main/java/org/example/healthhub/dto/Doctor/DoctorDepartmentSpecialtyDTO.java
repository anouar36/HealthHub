package org.example.healthhub.dto.Doctor;

public class DoctorDepartmentSpecialtyDTO {

    private Integer id;
    private String matricule;
    private String titre;

    // User information (from User entity)
    private String nom;
    private String prenom;
    private String email;
    private String telephone;

    // Specialty information
    private Long specialtyId;
    private String specialtyCode;
    private String specialtyName;

    // Department information
    private String departmentCode;
    private String departmentName;

    // Display fields
    private String fullName;        // "Dr. Sarah Johnson"
    private String experience;      // "15 years" (optional)

    // Constructors
    public DoctorDepartmentSpecialtyDTO() {}

    public DoctorDepartmentSpecialtyDTO(Integer id, String nom, String prenom, String email, String titre) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.titre = titre;
        this.fullName = "Dr. " + prenom + " " + nom;
    }

    // Getters & Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
        updateFullName();
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
        updateFullName();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public Long getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(Long specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getSpecialtyCode() {
        return specialtyCode;
    }

    public void setSpecialtyCode(String specialtyCode) {
        this.specialtyCode = specialtyCode;
    }

    public String getSpecialtyName() {
        return specialtyName;
    }

    public void setSpecialtyName(String specialtyName) {
        this.specialtyName = specialtyName;
    }

    public String getDepartmentCode() {
        return departmentCode;
    }

    public void setDepartmentCode(String departmentCode) {
        this.departmentCode = departmentCode;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    // Helper method
    private void updateFullName() {
        if (prenom != null && nom != null) {
            this.fullName = "Dr. " + prenom + " " + nom;
        }
    }

    @Override
    public String toString() {
        return "DoctorDTO{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", titre='" + titre + '\'' +
                ", specialtyName='" + specialtyName + '\'' +
                ", departmentName='" + departmentName + '\'' +
                '}';
    }
}
