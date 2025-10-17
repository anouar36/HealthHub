package org.example.healthhub.dto.Patient;

import java.time.LocalDate;

public class PatientUpdateDTO {

    private Integer id;
    private String nom;
    private String email;
    private String CIN;
    private LocalDate naissance;
    private String sexe;
    private String adresse;
    private String telephone;
    private String sang;
    private Boolean actif;

    // Constructors
    public PatientUpdateDTO() {}

    public PatientUpdateDTO(Integer id, String nom, String email, String CIN,
                            LocalDate naissance, String sexe, String adresse,
                            String telephone, String sang, Boolean actif) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.CIN = CIN;
        this.naissance = naissance;
        this.sexe = sexe;
        this.adresse = adresse;
        this.telephone = telephone;
        this.sang = sang;
        this.actif = actif;
    }

    public PatientUpdateDTO(Integer id, String nom, String email, String CIN,
                            String dateNaissance, String sexe, String adresse,
                            String telephone, String sang, Boolean actif) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.CIN = CIN;
        this.naissance = LocalDate.parse(dateNaissance);
        this.sexe = sexe;
        this.adresse = adresse;
        this.telephone = telephone;
        this.sang = sang;
        this.actif = actif;
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

    public Boolean getActif() {
        return actif;
    }

    public void setActif(Boolean actif) {
        this.actif = actif;
    }

    @Override
    public String toString() {
        return "PatientUpdateDTO{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", email='" + email + '\'' +
                ", CIN='" + CIN + '\'' +
                ", naissance=" + naissance +
                ", sexe='" + sexe + '\'' +
                ", telephone='" + telephone + '\'' +
                ", actif=" + actif +
                '}';
    }
}