package org.example.healthhub.dto.Department;

public class DepartmentCreatDTO {

    private String code;
    private String nom;
    private String description;

    // ===== Constructors =====

    public DepartmentCreatDTO() {
    }

    public DepartmentCreatDTO(String code, String nom, String description) {
        this.code = code;
        this.nom = nom;
        this.description = description;
    }


    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

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


    public boolean isValid() {
        return code != null && !code.trim().isEmpty()
                && nom != null && !nom.trim().isEmpty();
    }


    @Override
    public String toString() {
        return "DepartmentCreateDTO{" +
                "code='" + code + '\'' +
                ", nom='" + nom + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}