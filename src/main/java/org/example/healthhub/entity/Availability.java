package org.example.healthhub.entity;

public class Availability {
    private String jour;
    private String heureDebut;
    private String heureFin;
    private String statut;
    private String validite;

    public Availability() {}

    public Availability(String jour, String heureDebut, String heureFin, String statut, String validite) {
        this.jour = jour;
        this.heureDebut = heureDebut;
        this.heureFin = heureFin;
        this.statut = statut;
        this.validite = validite;
    }

    public String getJour() { return jour; }
    public void setJour(String jour) { this.jour = jour; }

    public String getHeureDebut() { return heureDebut; }
    public void setHeureDebut(String heureDebut) { this.heureDebut = heureDebut; }

    public String getHeureFin() { return heureFin; }
    public void setHeureFin(String heureFin) { this.heureFin = heureFin; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public String getValidite() { return validite; }
    public void setValidite(String validite) { this.validite = validite; }

    @Override
    public String toString() {
        return "Availability{" +
                "jour='" + jour + '\'' +
                ", heureDebut='" + heureDebut + '\'' +
                ", heureFin='" + heureFin + '\'' +
                ", statut='" + statut + '\'' +
                ", validite='" + validite + '\'' +
                '}';
    }
}
