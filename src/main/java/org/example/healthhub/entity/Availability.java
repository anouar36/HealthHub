package org.example.healthhub.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "availabilities")
public class Availability {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    @Column(name = "jour", length = 20)
    private String jour; // "Lundi", "Mardi"...

    @Column(name = "heure_debut", length = 10)
    private String heureDebut; // "09:00"

    @Column(name = "heure_fin", length = 10)
    private String heureFin; // "17:00"

    @Column(name = "statut", length = 20)
    private String statut; // "DISPONIBLE", "INDISPONIBLE"

    @Column(name = "validite", length = 20)
    private String validite; // "2025-12-31"

    // No-arg constructor (required by JPA)
    public Availability() {
    }

    public Availability(String jour, String heureDebut, String heureFin, String statut, String validite) {
        this.jour = jour;
        this.heureDebut = heureDebut;
        this.heureFin = heureFin;
        this.statut = statut;
        this.validite = validite;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public String getJour() {
        return jour;
    }

    public void setJour(String jour) {
        this.jour = jour;
    }

    public String getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(String heureDebut) {
        this.heureDebut = heureDebut;
    }

    public String getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(String heureFin) {
        this.heureFin = heureFin;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public String getValidite() {
        return validite;
    }

    public void setValidite(String validite) {
        this.validite = validite;
    }
}