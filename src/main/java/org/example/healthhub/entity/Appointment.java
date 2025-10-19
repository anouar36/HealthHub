package org.example.healthhub.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "appointments")
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "date", length = 20)
    private String date; // "2025-10-21"

    @Column(name = "heure", length = 10)
    private String heure; // "09:00"

    @Column(name = "statut", length = 20)
    private String statut; // "CONFIRME", "ANNULE"

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id")
    private Doctor docteur;

    @Column(name = "type", length = 50)
    private String type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getHeure() {
        return heure;
    }

    public void setHeure(String heure) {
        this.heure = heure;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Doctor getDocteur() {
        return docteur;
    }

    public void setDocteur(Doctor docteur) {
        this.docteur = docteur;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}