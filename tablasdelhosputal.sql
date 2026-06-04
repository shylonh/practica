CREATE DATABASE HospitalDB;  -- Crear una nueva base de datos llamada HospitalDB

SHOW DATABASES; 

select * from patients


use HospitalDB;

create schema patients
go

create schema doctores
go

crate schema especialidades
go

create schema citas
go

create table Patients (
	PatientID int primary key,
	nombre varchar(100) NOT NULL,
	Apellido varchar(100) NOT NULL,
	FechaNacimiento date NOT NULL,
	Telefono varchar(20) NOT NULL,
	Direccion varchar(200) NOT NULL
	);

create table doctores (
	DoctorID int primary key,
	nombre varchar(100) NOT NULL,
	Apellido varchar(100) NOT NULL,
	Especialidad varchar(100) NOT NULL,
	Telefono varchar(20) NOT NULL
	);

create table especialidades(
	EspecialidadID int primary key,
	NombreEspecialidad varchar(100) NOT NULL
	);

create table citas (
	CitaID int primary key,
	PatientID int NOT NULL,
	DoctorID int NOT NULL,
	FechaCita datetime NOT NULL,
	FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
	FOREIGN KEY (DoctorID) REFERENCES doctores(DoctorID)
	);	
	
create table habitaciones (
	HabitacionID int primary key,
	NumeroHabitacion varchar(10) NOT NULL,
	TipoHabitacion varchar(50) NOT NULL,
	Estado varchar(20) NOT NULL
	);

create table tratamientos (
	TratamientoID int primary key,
	NombreTratamiento varchar(100) NOT NULL,
	Descripcion varchar(500) NOT NULL
	);

create table medicamentos (
	MedicamentoID int primary key,
	NombreMedicamento varchar(100) NOT NULL,
	Dosis varchar(50) NOT NULL,
	Frecuencia varchar(50) NOT NULL
	);

	-- 11. Definir PRIMARY KEY en Pacientes.
ALTER TABLE Pacientes ADD CONSTRAINT PK_Pacientes PRIMARY KEY (PacienteID);

-- 12. Definir PRIMARY KEY en Médicos.
ALTER TABLE Medicos ADD CONSTRAINT PK_Medicos PRIMARY KEY (MedicoID);

-- 13. Agregar NOT NULL al nombre del paciente (Se usa ALTER COLUMN).
ALTER TABLE Pacientes ALTER COLUMN Nombre VARCHAR(100) NOT NULL;

-- 14. Agregar NOT NULL al nombre del médico (Se usa ALTER COLUMN).
ALTER TABLE Medicos ALTER COLUMN Nombre VARCHAR(100) NOT NULL;

-- 15. Crear una restricción UNIQUE para el correo del paciente.
ALTER TABLE Pacientes ADD Correo VARCHAR(100);
ALTER TABLE Pacientes ADD CONSTRAINT UQ_Paciente_Correo UNIQUE (Correo);

-- 16. Crear una restricción UNIQUE para el correo del médico.
ALTER TABLE Medicos ADD CONSTRAINT UQ_Medico_Correo UNIQUE (Correo);

-- 17. Agregar CHECK para edad mayor o igual a 0.
ALTER TABLE Pacientes ADD Edad INT;
ALTER TABLE Pacientes ADD CONSTRAINT CK_Paciente_Edad CHECK (Edad >= 0);

-- 18. Agregar CHECK para salario del médico mayor que 0.
ALTER TABLE Medicos ADD Salario DECIMAL(10, 2);
ALTER TABLE Medicos ADD CONSTRAINT CK_Medico_Salario CHECK (Salario > 0);

-- 19. Agregar DEFAULT para fecha de registro (Se usa GETDATE()).
ALTER TABLE Pacientes ADD FechaRegistro DATE CONSTRAINT DF_Paciente_FechaRegistro DEFAULT GETDATE();

-- 20. Crear FOREIGN KEY entre Médicos y Especialidades.
ALTER TABLE Medicos ADD EspecialidadID INT;
ALTER TABLE Medicos ADD CONSTRAINT FK_Medicos_Especialidades 
FOREIGN KEY (EspecialidadID) REFERENCES Especialidades(EspecialidadID);

-- 21. Crear FOREIGN KEY entre Citas y Pacientes.
ALTER TABLE Citas ADD CONSTRAINT FK_Citas_Pacientes 
FOREIGN KEY (PacienteID) REFERENCES Pacientes(PacienteID);

-- 22. Crear FOREIGN KEY entre Citas y Médicos.
ALTER TABLE Citas ADD CONSTRAINT FK_Citas_Medicos 
FOREIGN KEY (MedicoID) REFERENCES Medicos(MedicoID);

-- 23. Crear FOREIGN KEY entre Tratamientos y Pacientes.
ALTER TABLE Tratamientos ADD PacienteID INT;
ALTER TABLE Tratamientos ADD CONSTRAINT FK_Tratamientos_Pacientes 
FOREIGN KEY (PacienteID) REFERENCES Pacientes(PacienteID);

-- 24. Crear FOREIGN KEY entre Medicamentos y Tratamientos.
ALTER TABLE Medicamentos ADD TratamientoID INT;
ALTER TABLE Medicamentos ADD CONSTRAINT FK_Medicamentos_Tratamientos 
FOREIGN KEY (TratamientoID) REFERENCES Tratamientos(TratamientoID);

-- 25. Crear FOREIGN KEY entre Habitaciones y Pacientes.
ALTER TABLE Habitaciones ADD PacienteID INT;
ALTER TABLE Habitaciones ADD CONSTRAINT FK_Habitaciones_Pacientes 
FOREIGN KEY (PacienteID) REFERENCES Pacientes(PacienteID);
GO