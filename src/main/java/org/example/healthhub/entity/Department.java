package org.example.healthhub.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "departments")
public class Department {

    @Id
    @Column(length = 10)
    private String code;

    private String nom;
    private String description;

    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Specialty> specialties; // One department has many specialties

    public Department() {}

    public Department(String code, String nom, String description, List<Specialty> specialties) {
        this.code = code;
        this.nom = nom;
        this.description = description;
        this.specialties = specialties;
    }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public List<Specialty> getSpecialties() { return specialties; }
    public void setSpecialties(List<Specialty> specialties) { this.specialties = specialties; }

    @Override
    public String toString() {
        return "Department{" +
                "code='" + code + '\'' +
                ", nom='" + nom + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
