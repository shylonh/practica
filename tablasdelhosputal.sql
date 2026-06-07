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

USE master; 
GO
CREATE DATABASE BaseDeDatosPruebas; 
GO
DROP DATABASE BaseDeDatosPruebas; 
GO

USE HospitalDB;
GO

-- 51. Insertar 5 especialidades médicas.
INSERT INTO Especialidades (NombreEspecialidad, Descripcion) VALUES
('Cardiología', 'Tratamiento de afecciones del corazón y sistema circulatorio.'),
('Pediatría', 'Atención médica para bebés, niños y adolescentes.'),
('Dermatología', 'Diagnóstico y tratamiento de enfermedades de la piel.'),
('Ginecología', 'Cuidado de la salud del sistema reproductor femenino.'),
('Traumatología', 'Tratamiento de lesiones óseas, musculares y articulares.');
GO

-- 52. Insertar 10 médicos.

INSERT INTO Medicos (Nombre, Apellido, Correo, Salario, EspecialidadID) VALUES
('Carlos', 'Mendoza', 'carlos.mendoza@hospital.com', 4500.00, 1),
('Elena', 'Rostova', 'elena.rostova@hospital.com', 4200.00, 2),
('Jorge', 'Ramírez', 'jorge.ramirez@hospital.com', 4800.00, 3),
('Ana', 'Martínez', 'ana.martinez@hospital.com', 4600.00, 4),
('Luis', 'Gómez', 'luis.gomez@hospital.com', 5000.00, 5),
('Sofía', 'Castro', 'sofia.castro@hospital.com', 4300.00, 1),
('Miguel', 'Sanz', 'miguel.sanz@hospital.com', 4100.00, 2),
('Lucía', 'Fernández', 'lucia.fernandez@hospital.com', 4700.00, 3),
('Andrés', 'Peña', 'andres.pena@hospital.com', 4900.00, 4),
('Laura', 'Vargas', 'laura.vargas@hospital.com', 5200.00, 5);
GO

-- 53. Insertar 20 pacientes.
INSERT INTO Pacientes (Nombre, Apellido, FechaNacimiento, Correo, Edad) VALUES
('Juan', 'Pérez', '1990-05-12', 'juan.perez@mail.com', 36),
('María', 'López', '1985-08-22', 'maria.lopez@mail.com', 40),
('Pedro', 'García', '2000-01-15', 'pedro.garcia@mail.com', 26),
('Carmen', 'Sánchez', '1973-11-30', 'carmen.sanchez@mail.com', 52),
('Alejandro', 'Torres', '1995-03-09', 'alejandro.torres@mail.com', 31),
('Rosa', 'Díaz', '1968-07-19', 'rosa.diaz@mail.com', 57),
('David', 'Ruiz', '2010-04-25', 'david.ruiz@mail.com', 16),
('Martha', 'Morales', '1955-12-05', 'martha.morales@mail.com', 70),
('Javier', 'Jiménez', '1988-02-14', 'javier.jimenez@mail.com', 38),
('Patricia', 'Alvarado', '1992-10-10', 'patricia.alvarado@mail.com', 33),
('Diego', 'Espinoza', '2005-06-18', 'diego.espinoza@mail.com', 20),
('Elizabeth', 'Flores', '1980-09-01', 'elizabeth.flores@mail.com', 45),
('Ricardo', 'Benítez', '1977-05-28', 'ricardo.benitez@mail.com', 49),
('Silvia', 'Ortiz', '1999-08-14', 'silvia.ortiz@mail.com', 26),
('Fernando', 'Herrera', '1963-03-21', 'fernando.herrera@mail.com', 63),
('Beatriz', 'Gutiérrez', '1984-11-11', 'beatriz.gutierrez@mail.com', 41),
('Hugo', 'Castro', '2015-01-30', 'hugo.castro@mail.com', 11),
('Yolanda', 'Marín', '1970-07-07', 'yolanda.marin@mail.com', 55),
('Gabriel', 'Ríos', '1993-04-03', 'gabriel.rios@mail.com', 33),
('Natalia', 'Vega', '2002-12-25', 'natalia.vega@mail.com', 23);
GO

-- 54. Insertar 15 citas.
INSERT INTO Citas (FechaHora, PacienteID, MedicoID, Motivo, Estado) VALUES
('2026-06-01 09:00:00', 1, 1, 'Control cardiológico de rutina', 'Completada'),
('2026-06-01 10:30:00', 2, 2, 'Chequeo pediátrico anual', 'Completada'),
('2026-06-02 08:00:00', 3, 3, 'Consulta por dermatitis', 'Completada'),
('2026-06-02 11:15:00', 4, 4, 'Control ginecológico', 'Completada'),
('2026-06-03 14:00:00', 5, 5, 'Evaluación de fractura de esguince', 'Completada'),
('2026-06-03 16:00:00', 6, 1, 'Arritmia menor', 'Completada'),
('2026-06-04 09:30:00', 7, 2, 'Fiebre persistente', 'Programada'),
('2026-06-04 11:00:00', 8, 3, 'Revisión de lunares', 'Programada'),
('2026-06-05 08:30:00', 9, 4, 'Ecografía de control', 'Programada'),
('2026-06-05 10:00:00', 10, 5, 'Dolor crónico de rodilla', 'Programada'),
('2026-06-06 09:00:00', 11, 6, 'Presión arterial alta', 'Programada'),
('2026-06-06 12:00:00', 12, 7, 'Vacunación obligatoria', 'Programada'),
('2026-06-07 15:00:00', 13, 8, 'Alergias cutáneas', 'Programada'),
('2026-06-07 16:30:00', 14, 9, 'Consulta general preventiva', 'Programada'),
('2026-06-08 11:00:00', 15, 10, 'Dolor lumbar severo', 'Programada');
GO

-- 55. Insertar 10 habitaciones.
INSERT INTO Habitaciones (NumeroHabitacion, Tipo, Estado) VALUES
('101', 'Individual', 'Disponible'),
('102', 'Doble', 'Ocupada'),
('103', 'UCI', 'Ocupada'),
('104', 'Individual', 'Disponible'),
('105', 'Doble', 'Disponible'),
('201', 'Individual', 'Ocupada'),
('202', 'Doble', 'Disponible'),
('203', 'UCI', 'Disponible'),
('204', 'Individual', 'Ocupada'),
('205', 'Doble', 'Disponible');
GO

-- 56. Insertar 10 tratamientos.
INSERT INTO Tratamientos (NombreTratamiento, Descripcion, Costo, PacienteID) VALUES
('Hipertensión Etapa 1', 'Tratamiento con betabloqueadores y dieta baja en sodio.', 150.00, 1),
('Terapia Respiratoria', 'Uso de nebulizaciones por cuadro asmático severo.', 220.00, 7),
('Cuidado Post-Fractura', 'Inmovilización con yeso y analgésicos.', 350.00, 5),
('Tratamiento de Acné Severo', 'Aplicación tópica y antibióticos orales.', 180.00, 3),
('Control Diabético', 'Suministro de insulina y monitoreo de glucosa.', 400.00, 8),
('Rehabilitación Lumbar', 'Sesiones de fisioterapia dirigidas.', 300.00, 15),
('Tratamiento de Anemia', 'Suplementación de hierro endovenoso.', 125.00, 4),
('Antibióticoterapia UCI', 'Administración de antibióticos de amplio espectro.', 950.00, 11),
('Monitoreo Cardíaco', 'Uso de Holter por 24 horas y análisis.', 210.00, 6),
('Manejo del Dolor Crónico', 'Bloqueo terapéutico del dolor articular.', 600.00, 10);
GO

-- 57. Insertar 20 medicamentos.
INSERT INTO Medicamentos (NombreMedicamento, Presentacion, CantidadStock, TratamientoID) VALUES
('Losartán 50mg', 'Tableta', 500, 1),
('Amoxicilina 500mg', 'Cápsula', 300, 2),
('Ibuprofeno 400mg', 'Tableta', 1000, 3),
('Metformina 850mg', 'Tableta', 600, 5),
('Paracetamol 500mg', 'Tableta', 1500, 3),
('Salbutamol Inhalador', 'Aerosol', 150, 2),
('Insulina Glargina', 'Vial', 80, 5),
('Omeprazol 20mg', 'Cápsula', 800, 1),
('Diclofenaco Sódico', 'Ampolla', 200, 6),
('Hierro Aminoquelado', 'Tableta', 400, 7),
('Ceftriaxona 1g', 'Ampolla', 120, 8),
('Atorvastatina 20mg', 'Tableta', 450, 1),
('Clonazepam 2mg', 'Tableta', 250, 10),
('Tramadol 50mg', 'Cápsula', 350, 10),
('Lorandil 10mg', 'Tableta', 500, 4),
('Fluconazol 150mg', 'Cápsula', 180, 4),
('Ketorolaco 30mg', 'Ampolla', 150, 6),
('Complejo B', 'Tableta', 900, 7),
('Vancomicina 500mg', 'Vial', 90, 8),
('Enalapril 10mg', 'Tableta', 400, 9);
GO

-- 58. Insertar pacientes con todos los campos.
INSERT INTO Pacientes (Nombre, Apellido, FechaNacimiento, Telefono, Direccion, Correo, Edad, Genero, TipoSangre) 
VALUES ('Roberto', 'Gómez', '1982-04-14', '+505 8888-7777', 'Calle Central 123', 'roberto.gomez@mail.com', 44, 'M', 'O+');
GO

-- 59. Insertar médicos especialistas.
INSERT INTO Medicos (Nombre, Apellido, Correo, Salario, EspecialidadID, Turno, Experiencia) 
VALUES ('Francisco', 'Dávila', 'francisco.davila@hospital.com', 5500.00, 1, 'Mañana', 12); -- Especialidad 1 = Cardiología
GO

-- 60. Insertar citas con fecha actual.
INSERT INTO Citas (FechaHora, PacienteID, MedicoID, Motivo, Estado) 
VALUES (GETDATE(), 1, 1, 'Consulta de urgencia inmediata', 'En Progreso');
GO

-- 62. Insertar habitaciones ocupadas.
INSERT INTO Habitaciones (NumeroHabitacion, Tipo, Estado) 
VALUES ('301', 'UCI', 'Ocupada');
GO

-- 63. Insertar habitaciones disponibles.
INSERT INTO Habitaciones (NumeroHabitacion, Tipo, Estado) 
VALUES ('302', 'Individual', 'Disponible');
GO

-- 64. Insertar tratamientos activos.
INSERT INTO Tratamientos (NombreTratamiento, Descripcion, Costo, PacienteID) 
VALUES ('Quimioterapia Ciclo 1', 'ESTADO: ACTIVO. Sesiones semanales vigentes.', 2500.00, 3);
GO

-- 65. Insertar tratamientos finalizados.
INSERT INTO Tratamientos (NombreTratamiento, Descripcion, Costo, PacienteID) 
VALUES ('Fisioterapia Post-Operatoria', 'ESTADO: FINALIZADO. Alta médica otorgada.', 450.00, 4);
GO

-- 66. Actualizar teléfono de un paciente.
UPDATE Pacientes 
SET Telefono = '+505 7777-8888' 
WHERE PacienteID = 1;

-- 67. Actualizar dirección de un paciente.
UPDATE Pacientes 
SET Direccion = 'Bello Horizonte, De la rotonda 2c al norte' 
WHERE PacienteID = 2;

-- 68. Actualizar salario de un médico.
UPDATE Medicos 
SET Salario = 4950.00 
WHERE MedicoID = 1;

-- 69. Actualizar turno de un médico.
UPDATE Medicos 
SET Turno = 'Noche' 
WHERE MedicoID = 2;

-- 70. Cambiar estado de una cita.
UPDATE Citas 
SET Estado = 'Cancelada' 
WHERE CitaID = 7;

-- 71. Actualizar costo de consulta.
UPDATE Citas 
SET CostoConsulta = 85.00 
WHERE CitaID = 11;

-- 72. Actualizar nombre de especialidad.
UPDATE Especialidades 
SET NombreEspecialidad = 'Pediatría Neonatal' 
WHERE EspecialidadID = 2;

-- 73. Actualizar disponibilidad de habitación.
UPDATE Habitaciones 
SET Disponibilidad = 0 
WHERE HabitacionID = 1;

-- 74. Actualizar tratamiento activo.
UPDATE Tratamientos 
SET Descripcion = 'ESTADO: ACTIVO. Se duplica la dosis por recomendación médica.' 
WHERE TratamientoID = 1;

-- 75. Actualizar medicamento.
UPDATE Medicamentos 
SET CantidadStock = 480 
WHERE MedicamentoID = 1;

-- 76. Actualizar correo de paciente.
UPDATE Pacientes 
SET Correo = 'juan.perez.nuevo@mail.com' 
WHERE PacienteID = 1;

-- 77. Actualizar correo de médico.
UPDATE Medicos 
SET Correo = 'carlos.mendoza.update@hospital.com' 
WHERE MedicoID = 1;

-- 78. Actualizar fecha de cita.
UPDATE Citas 
SET FechaHora = '2026-06-20 14:30:00' 
WHERE CitaID = 8;

-- 79. Actualizar experiencia del médico.
UPDATE Medicos 
SET Experiencia = 14 
WHERE MedicoID = 1;

-- 80. Actualizar tipo de sangre.
UPDATE Pacientes 
SET TipoSangre = 'O-' 
WHERE PacienteID = 3;
GO