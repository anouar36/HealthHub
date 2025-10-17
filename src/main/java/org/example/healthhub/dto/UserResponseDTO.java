package org.example.healthhub.dto;

import org.example.healthhub.repository.Enums.Role;

public class UserResponseDTO {
    private String nom;
    private String email;
    private Role role;
    private boolean actif;


    public UserResponseDTO(String nom, String email, Role role, boolean actif) {
        this.nom = nom;
        this.email = email;
        this.role = role;
        this.actif = actif;
    }
    public UserResponseDTO() {

    }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public boolean isActif() { return actif; }
    public void setActive(boolean actif) { this.actif = actif; }
}
