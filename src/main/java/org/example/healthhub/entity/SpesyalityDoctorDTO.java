package org.example.healthhub.entity;


import org.example.healthhub.entity.Specialty;

public class SpesyalityDoctorDTO {
    private Long id;
    private String name;
    private String email;
    private String phone;
    private Specialty speciality; // 👈 object instead of string

    public SpesyalityDoctorDTO() {}

    public SpesyalityDoctorDTO(Long id, String name, String email, String phone, Specialty speciality) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.speciality = speciality;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Specialty getSpeciality() {
        return speciality;
    }

    public void setSpeciality(Specialty speciality) {
        this.speciality = speciality;
    }
}
