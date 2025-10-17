package org.example.healthhub.dto;

public class UserRequestDTO {
    private String  email;
    private String  password;

    public UserRequestDTO(String email, String password) {
        this.email = email;
        this.password = password;
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

    public static class DoctorDTO {
        private Long id;
        private String nom;
        private String email;
        private String matricule;
        private String titre;
        private String specialiteCode;
        public DoctorDTO() {}

        public DoctorDTO(Long id, String nom, String email, String matricule, String titre, String specialiteCode) {
            this.id = id;
            this.nom = nom;
            this.email = email;
            this.matricule = matricule;
            this.titre = titre;
            this.specialiteCode = specialiteCode;
        }

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }

        public String getNom() { return nom; }
        public void setNom(String nom) { this.nom = nom; }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getMatricule() { return matricule; }
        public void setMatricule(String matricule) { this.matricule = matricule; }

        public String getTitre() { return titre; }
        public void setTitre(String titre) { this.titre = titre; }

        public String getSpecialiteCode() { return specialiteCode; }
        public void setSpecialiteCode(String specialiteCode) { this.specialiteCode = specialiteCode; }
    }
}
