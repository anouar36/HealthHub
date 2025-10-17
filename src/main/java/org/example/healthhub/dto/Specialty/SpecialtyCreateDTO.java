package org.example.healthhub.dto.Specialty;

public class SpecialtyCreateDTO {

    private String nom;
    private String description;
    private String departmentCode;// Department ID/Code

    // Constructor vide
    public SpecialtyCreateDTO() {
    }

    // Constructor kaml
    public SpecialtyCreateDTO(String nom, String description, String departmentCode) {
        this.nom = nom;
        this.description = description;
        this.departmentCode = departmentCode;
    }

    // Constructor bla departmentCode (optional)
    public SpecialtyCreateDTO(String nom, String description) {
        this.nom = nom;
        this.description = description;
    }

    // Getters & Setters
    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDepartmentCode() {
        return departmentCode;
    }

    public void setDepartmentCode(String departmentCode) {
        this.departmentCode = departmentCode;
    }

    @Override
    public String toString() {
        return "SpecialtyCreateDTO{" +
                "nom='" + nom + '\'' +
                ", description='" + description + '\'' +
                ", departmentCode='" + departmentCode + '\'' +
                '}';
    }
}