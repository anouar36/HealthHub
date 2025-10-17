package org.example.healthhub.dto.Doctor;


import org.example.healthhub.entity.Specialty;

public class DoctorCreateDTO {
    private String nom;
    private String email;
    private String password;
    private String matricule;
    private String titre;
    private String specialite;
    private String role;
    private boolean actif;

    public DoctorCreateDTO() {}

    public DoctorCreateDTO(String nom, String email,String password, String matricule, String titre, String specialite, String role, boolean actif) {
        this.nom = nom;
        this.email = email;
        this.password = password;
        this.matricule = matricule;
        this.titre = titre;
        this.specialite = specialite;
        this.role = role;
        this.actif = actif;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }


}
