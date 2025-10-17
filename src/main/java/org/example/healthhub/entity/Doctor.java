package org.example.healthhub.entity;

import jakarta.persistence.*;
import org.modelmapper.internal.bytebuddy.dynamic.TypeResolutionStrategy;

@Entity
@Table(name = "doctors")
public class Doctor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String matricule;
    private String titre;



    // ✅ NEW (صحيح) - استعمل id بدل code
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
            name = "specialty_id",           // Column في doctors table
            referencedColumnName = "id"      // ← IMPORTANT: Reference specialties.id (not code!)
    )
    private Specialty specialty;

    @OneToOne(fetch = FetchType.EAGER, cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REMOVE})
    @JoinColumn(name = "user_id")
    private User user;

    // Getters & Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getMatricule() { return matricule; }
    public void setMatricule(String matricule) { this.matricule = matricule; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public Specialty getSpecialty() { return specialty; }
    public void setSpecialty(Specialty specialty) { this.specialty = specialty; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}