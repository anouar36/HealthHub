package org.example.healthhub.entity;

public class MedicalNote {
    private String contenu;
    private User auteur;
    private Appointment rendezVous;

    public MedicalNote() {}

    public MedicalNote(String contenu, User auteur, Appointment rendezVous) {
        this.contenu = contenu;
        this.auteur = auteur;
        this.rendezVous = rendezVous;
    }

    public String getContenu() { return contenu; }
    public void setContenu(String contenu) { this.contenu = contenu; }

    public User getAuteur() { return auteur; }
    public void setAuteur(User auteur) { this.auteur = auteur; }

    public Appointment getRendezVous() { return rendezVous; }
    public void setRendezVous(Appointment rendezVous) { this.rendezVous = rendezVous; }

    @Override
    public String toString() {
        return "MedicalNote{" +
                "contenu='" + contenu + '\'' +
                ", auteur=" + auteur +
                ", rendezVous=" + rendezVous +
                '}';
    }
}
