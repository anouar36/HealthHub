package org.example.healthhub.dto.Patient;

import org.example.healthhub.repository.Enums.Role;
import java.time.LocalDate;

public class PatientDTO {

    private Integer id;
    private String nom;
    private String email;
    private Role role;
    private Boolean actif;
    private String CIN;
    private LocalDate naissance;
    private String sexe;
    private String adresse;
    private String telephone;
    private String sang;

    // Constructors
    public PatientDTO() {}

    public PatientDTO(Integer id, String nom, String email, Role role, Boolean actif,
                      String CIN, LocalDate naissance, String sexe, String adresse,
                      String telephone, String sang) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.role = role;
        this.actif = actif;
        this.CIN = CIN;
        this.naissance = naissance;
        this.sexe = sexe;
        this.adresse = adresse;
        this.telephone = telephone;
        this.sang = sang;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Boolean getActif() {
        return actif;
    }

    public void setActif(Boolean actif) {
        this.actif = actif;
    }

    public String getCIN() {
        return CIN;
    }

    public void setCIN(String CIN) {
        this.CIN = CIN;
    }

    public LocalDate getNaissance() {
        return naissance;
    }

    public void setNaissance(LocalDate naissance) {
        this.naissance = naissance;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getSang() {
        return sang;
    }

    public void setSang(String sang) {
        this.sang = sang;
    }

    @Override
    public String toString() {
        return "PatientDTO{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", email='" + email + '\'' +
                ", CIN='" + CIN + '\'' +
                ", naissance=" + naissance +
                ", sexe='" + sexe + '\'' +
                ", telephone='" + telephone + '\'' +
                '}';
    }
}