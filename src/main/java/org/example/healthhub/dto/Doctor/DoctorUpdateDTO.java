package org.example.healthhub.dto.Doctor;

import org.example.healthhub.entity.Specialty;

public class DoctorUpdateDTO {

    private int id ;
    private String nom;
    private String email;
    private String specialite;
    private String titre;
    private boolean actif;
    private String matricule;

    public DoctorUpdateDTO() {}

    public DoctorUpdateDTO(int id,String nom, String email, String titre, String specialite, boolean actif,String matricule) {
        this.id = id ;
        this.nom = nom;
        this.email = email;
        this.titre = titre;
        this.specialite = specialite;
        this.actif = actif;
        this.matricule = matricule;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
}


