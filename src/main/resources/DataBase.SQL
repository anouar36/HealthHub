-- ============================================
-- Database: HealthHub
-- Tables for Users, Patients, Doctors, Departments, Specialties, Availability, Appointments, MedicalNotes
-- With logical inheritance: Doctor extends User (1–1 relation)
-- ============================================

-- 1️⃣ User Table
CREATE TABLE IF NOT EXISTS users (
                                     id SERIAL PRIMARY KEY,
                                     nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(50) NOT NULL,
    actif BOOLEAN DEFAULT TRUE
    );

-- Sample data
INSERT INTO users(nom, email, role, actif) VALUES
                                               ('Admin User','admin@healthhub.com','ADMIN',TRUE),
                                               ('Doctor User','doctor1@healthhub.com','DOCTOR',TRUE),
                                               ('Patient User','patient1@healthhub.com','PATIENT',TRUE);

-- 2️⃣ Patient Table
CREATE TABLE IF NOT EXISTS patients (
                                        CIN VARCHAR(20) PRIMARY KEY,
    naissance DATE NOT NULL,
    sexe VARCHAR(10),
    adresse VARCHAR(200),
    telephone VARCHAR(20),
    sang VARCHAR(5)
    );

-- Sample data
INSERT INTO patients(CIN, naissance, sexe, adresse, telephone, sang) VALUES
                                                                         ('CIN123','1990-05-20','Male','123 Main St','0612345678','O+'),
                                                                         ('CIN456','1985-08-12','Female','456 Elm St','0623456789','A-');

-- 3️⃣ Department Table
CREATE TABLE IF NOT EXISTS departments (
                                           code VARCHAR(20) PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT
    );

-- Sample data
INSERT INTO departments(code, nom, description) VALUES
                                                    ('D001','Cardiology','Department of heart and blood vessels'),
                                                    ('D002','Neurology','Department of brain and nerves');

-- 4️⃣ Specialty Table
CREATE TABLE IF NOT EXISTS specialties (
                                           code VARCHAR(20) PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    department_code VARCHAR(20),
    FOREIGN KEY(department_code) REFERENCES departments(code) ON DELETE SET NULL
    );

-- Sample data
INSERT INTO specialties(code, nom, description, department_code) VALUES
                                                                     ('S001','Cardiologist','Heart specialist','D001'),
                                                                     ('S002','Neurologist','Brain specialist','D002');

-- 5️⃣ Doctor Table (inherits logically from User)
CREATE TABLE IF NOT EXISTS doctors (
                                       id INT PRIMARY KEY,               -- same as users.id
                                       matricule VARCHAR(20) NOT NULL,
    titre VARCHAR(50),
    specialite_code VARCHAR(20),
    FOREIGN KEY(id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(specialite_code) REFERENCES specialties(code)
    );

-- Sample data
-- First insert user with role DOCTOR
INSERT INTO users(nom, email, role, actif)
VALUES ('Dr. Amine','amine@healthhub.com','DOCTOR',TRUE)
    RETURNING id;

-- Suppose id = 4, insert corresponding doctor
INSERT INTO doctors(id, matricule, titre, specialite_code)
VALUES (4,'DR001','MD','S001');

-- Another example
INSERT INTO users(nom, email, role, actif)
VALUES ('Dr. Sara','sara@healthhub.com','DOCTOR',TRUE)
    RETURNING id;

-- Suppose id = 5
INSERT INTO doctors(id, matricule, titre, specialite_code)
VALUES (5,'DR002','MD','S002');

-- 6️⃣ Availability Table
CREATE TABLE IF NOT EXISTS availability (
                                            id SERIAL PRIMARY KEY,
                                            doctor_id INT,
                                            jour VARCHAR(20),
    heure_debut TIME,
    heure_fin TIME,
    statut VARCHAR(20),
    validite DATE,
    FOREIGN KEY(doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
    );

-- Sample data
INSERT INTO availability(doctor_id, jour, heure_debut, heure_fin, statut, validite) VALUES
                                                                                        (4,'Monday','09:00','12:00','Available','2025-12-31'),
                                                                                        (5,'Tuesday','13:00','17:00','Available','2025-12-31');

-- 7️⃣ Appointment Table
CREATE TABLE IF NOT EXISTS appointments (
                                            id SERIAL PRIMARY KEY,
                                            date DATE NOT NULL,
                                            heure TIME NOT NULL,
                                            statut VARCHAR(20),
    patient_cin VARCHAR(20),
    doctor_id INT,
    type VARCHAR(50),
    FOREIGN KEY(patient_cin) REFERENCES patients(CIN) ON DELETE CASCADE,
    FOREIGN KEY(doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
    );

-- Sample data
INSERT INTO appointments(date, heure, statut, patient_cin, doctor_id, type) VALUES
                                                                                ('2025-10-10','10:00','Scheduled','CIN123',4,'Checkup'),
                                                                                ('2025-10-11','14:00','Scheduled','CIN456',5,'Consultation');

-- 8️⃣ MedicalNote Table
CREATE TABLE IF NOT EXISTS medical_notes (
                                             id SERIAL PRIMARY KEY,
                                             contenu TEXT,
                                             auteur_id INT,
                                             appointment_id INT,
                                             FOREIGN KEY(auteur_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
    );

-- Sample data
INSERT INTO medical_notes(contenu, auteur_id, appointment_id) VALUES
                                                                  ('Patient is in good health.',4,1),
                                                                  ('Patient needs further tests.',5,2);
