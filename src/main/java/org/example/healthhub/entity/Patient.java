package org.example.healthhub.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "patients")
@PrimaryKeyJoinColumn(name = "id")
public class Patient extends User {

    @Column(name = "cin", unique = true)
    private String CIN;

    @Column(name = "naissance")
    private LocalDate naissance;

    @Column(name = "sexe")
    private String sexe;

    @Column(name = "adresse")
    private String adresse;

    @Column(name = "telephone")
    private String telephone;

    @Column(name = "sang")
    private String sang;

    // Constructors
    public Patient() {
        super();
    }

    public Patient(String CIN, LocalDate naissance, String sexe, String adresse, String telephone, String sang) {
        this.CIN = CIN;
        this.naissance = naissance;
        this.sexe = sexe;
        this.adresse = adresse;
        this.telephone = telephone;
        this.sang = sang;
    }

    // Getters & Setters
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
}