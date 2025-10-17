package org.example.healthhub.dto;

public class DoctorDTO {
    private int id ;
    private String nom;
    private String email;
    private String matricule;
    private String titre;
    private String specialite;
    private Boolean actif;

    public DoctorDTO() {
    }

    // getters
    public String getNom() { return nom; }
    public String getEmail() { return email; }
    public String getMatricule() { return matricule; }
    public String getTitre() { return titre; }
    public String getSpecialite() { return specialite; }
    public Boolean getActif(){return actif ;}

    public void setNom(String nom) {
        this.nom = nom;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    public void setTitre(String titre) {
        this.titre = titre;
    }
    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }
    public void setActif(Boolean actif){ this.actif = actif ;}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
