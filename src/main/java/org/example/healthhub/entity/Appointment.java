package org.example.healthhub.entity;

public class Appointment {
    private String date;
    private String heure;
    private String statut;
    private Patient patient;
    private Doctor docteur;
    private String type;

    public Appointment() {}

    public Appointment(String date, String heure, String statut, Patient patient, Doctor docteur, String type) {
        this.date = date;
        this.heure = heure;
        this.statut = statut;
        this.patient = patient;
        this.docteur = docteur;
        this.type = type;
    }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getHeure() { return heure; }
    public void setHeure(String heure) { this.heure = heure; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public Doctor getDocteur() { return docteur; }
    public void setDocteur(Doctor docteur) { this.docteur = docteur; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    @Override
    public String toString() {
        return "Appointment{" +
                "date='" + date + '\'' +
                ", heure='" + heure + '\'' +
                ", statut='" + statut + '\'' +
                ", patient=" + patient +
                ", docteur=" + docteur +
                ", type='" + type + '\'' +
                '}';
    }
}
