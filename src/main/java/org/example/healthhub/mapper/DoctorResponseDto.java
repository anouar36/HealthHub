package org.example.healthhub.mapper;

import org.example.healthhub.dto.DoctorDTO;
import org.example.healthhub.entity.Doctor;
import org.example.healthhub.entity.Specialty;

public class DoctorResponseDto {

    public DoctorDTO doctorToDoctorDto(Doctor doctor){

        DoctorDTO doctorDto = new DoctorDTO();
        doctorDto.setMatricule(doctor.getMatricule());
        doctorDto.setTitre(doctor.getTitre());

        doctorDto.setSpecialite(doctor.getSpecialty().getNom());
        doctorDto.setEmail(doctor.getUser().getEmail());
        doctorDto.setNom(doctor.getUser().getNom());
        return  doctorDto;

    }
}
