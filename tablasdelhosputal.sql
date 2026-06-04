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

-- 26. Agregar columna teléfono a Pacientes.
ALTER TABLE Pacientes ADD Telefono VARCHAR(20);

-- 27. Agregar columna dirección a Pacientes.
ALTER TABLE Pacientes ADD Direccion VARCHAR(255);

-- 28. Agregar columna género 
ALTER TABLE Pacientes ADD Genero CHAR(1); -- 'M' o 'F'

-- 29. Agregar columna tipo_sangre 
ALTER TABLE Pacientes ADD TipoSangre VARCHAR(5); -- Ejemplo: 'O+', 'A-'

-- 30. Agregar columna fecha_nacimiento 
ALTER TABLE Pacientes ADD FechaNacimiento DATE;
GO


-- 31. Modificar tamaño del campo nombre 
ALTER TABLE Pacientes ALTER COLUMN Nombre VARCHAR(150) NOT NULL;

-- 32. Modificar tamaño del campo dirección.
ALTER TABLE Pacientes ALTER COLUMN Direccion VARCHAR(500);
GO

-- 33. Agregar columna experiencia a Médicos.
ALTER TABLE Medicos ADD Experiencia INT; -- Representa años de experiencia

-- 34. Agregar columna turno
ALTER TABLE Medicos ADD Turno VARCHAR(20); -- Ejemplo: 'Mañana', 'Tarde', 'Noche'
GO

-- 35. Agregar columna observaciones 
ALTER TABLE Citas ADD Observaciones VARCHAR(MAX);

-- 36. Eliminar columna observaciones 
ALTER TABLE Citas DROP COLUMN Observaciones;
GO

-- 37. Agregar columna estado a Citas.
ALTER TABLE Citas ADD Estado VARCHAR(50);

-- 38. Agregar columna costo_consulta 
ALTER TABLE Citas ADD CostoConsulta DECIMAL(10, 2);

-- 39. Modificar tipo de dato del costo 
ALTER TABLE Citas ALTER COLUMN CostoConsulta MONEY;
GO

-- 40. Agregar columna disponibilidad a Habitaciones.

ALTER TABLE Habitaciones ADD Disponibilidad BIT; 
GO


-- MÓDULO IV - ELIMINACIÓN DE ESTRUCTURAS (DROP) 
USE HospitalDB;
GO

-- 41. Eliminar una tabla temporal.
CREATE TABLE #TablaTemporal (ID INT);
GO
DROP TABLE #TablaTemporal;
GO


-- 42. Eliminar una restricción CHECK.
ALTER TABLE Pacientes DROP CONSTRAINT CK_Paciente_Edad;
GO


-- 43. Eliminar una restricción UNIQUE.
ALTER TABLE Pacientes DROP CONSTRAINT UQ_Paciente_Correo;
GO


-- 44. Eliminar una columna.
ALTER TABLE Pacientes DROP COLUMN Telefono;
GO


-- 45. Eliminar una tabla de pruebas.
CREATE TABLE TablaPruebas (ID INT, Detalle VARCHAR(50));
GO
DROP TABLE TablaPruebas;
GO


-- 46. Crear y eliminar una tabla Auditoria.
CREATE TABLE Auditoria (
    AuditoriaID INT IDENTITY(1,1) PRIMARY KEY,
    Fecha datetime DEFAULT GETDATE(),
    Accion VARCHAR(255)
);
GO
DROP TABLE Auditoria;
GO


-- 47. Crear y eliminar una tabla Logs.
CREATE TABLE Logs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    Mensaje VARCHAR(MAX),
    Nivel VARCHAR(20)
);
GO
DROP TABLE Logs;
GO


-- 48. Eliminar una FOREIGN KEY.

ALTER TABLE Habitaciones DROP CONSTRAINT FK_Habitaciones_Pacientes;
GO


-- 49. Eliminar una tabla MedicamentosPrueba.
CREATE TABLE MedicamentosPrueba (ID INT, Nombre VARCHAR(50));
GO
DROP TABLE MedicamentosPrueba;
GO


-- 50. Eliminar una base de datos de pruebas.

USE master; -- Nos cambiamos a la base de datos del sistema
GO
CREATE DATABASE BaseDeDatosPruebas; -- Creamos la BD de prueba
GO
DROP DATABASE BaseDeDatosPruebas; -- La eliminamos por completo
GO

USE HospitalDB;
GO