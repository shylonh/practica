
USE master;
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'EmpresaSQL')
BEGIN
    ALTER DATABASE EmpresaSQL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EmpresaSQL;
    END
GO
-- 1. Crear una base de datos llamada EmpresaSQL.
CREATE DATABASE EmpresaSQL;
GO

-- 2. Seleccionar la base de datos creada.
USE EmpresaSQL;
GO

-- 3. Crear una tabla llamada TDepartamento
CREATE TABLE TDepartamento (
    nDepartamentoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreDepartamento VARCHAR(100) NOT NULL UNIQUE
);
GO

-- 4. Crear una tabla llamada TCargo
CREATE TABLE TCargo (
    nCargoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreCargo VARCHAR(100) NOT NULL UNIQUE
);
GO

-- 5. Crear una tabla llamada TEmpleado
CREATE TABLE TEmpleado (
    nEmpleadoID INT IDENTITY(1,1) PRIMARY KEY,
    cNIF VARCHAR(20) UNIQUE,
    cNombre VARCHAR(100),
    cApellido VARCHAR(100),
    nDepartamentoID INT,
    nCargoID INT,
    dFechaContratacion DATE,
    nSalario DECIMAL(10, 2),
    
    -- Restricciones de Llave Foránea (Relaciones con las otras tablas)
    CONSTRAINT FK_Empleado_Departamento FOREIGN KEY (nDepartamentoID) 
        REFERENCES TDepartamento(nDepartamentoID),
    CONSTRAINT FK_Empleado_Cargo FOREIGN KEY (nCargoID) 
        REFERENCES TCargo(nCargoID)
);
GO

-- 6. Agregar restricción CHECK para que el salario sea mayor que 300.
ALTER TABLE TEmpleado
ADD CONSTRAINT CHK_Salario CHECK (nSalario > 300);
GO

-- 7. Agregar restricción DEFAULT para la fecha de contratación.
ALTER TABLE TEmpleado
ADD CONSTRAINT DEF_FechaContratacion DEFAULT GETDATE() FOR dFechaContratacion;
GO

-- 8. Establecer llave foránea entre TEmpleado y TDepartamento.
ALTER TABLE TEmpleado
ADD CONSTRAINT FK_Empleado_Departamento 
    FOREIGN KEY (nDepartamentoID) REFERENCES TDepartamento(nDepartamentoID);
GO

-- 9. Establecer llave foránea entre TEmpleado y TCargo.
ALTER TABLE TEmpleado
ADD CONSTRAINT FK_Empleado_Cargo 
    FOREIGN KEY (nCargoID) REFERENCES TCargo(nCargoID);
GO

-- 10 al 14. Crear la tabla TProyecto con todos los requisitos solicitados.
CREATE TABLE TProyecto (
    -- 11. Clave primaria autoincremental
    nProyectoID INT IDENTITY(1,1) PRIMARY KEY, 
    
    -- 12. Campo nombre del proyecto obligatorio 
    cNombreProyecto VARCHAR(150) NOT NULL,     
    
    -- 13. Fecha de inicio obligatoria 
    dFechaInicio DATE NOT NULL,                
    
    -- 14. Fecha de finalización
    dFechaFinalizacion DATE                    
);
GO

-- 15. Crear tabla intermedia TEmpleadoProyecto para relación muchos a muchos.
CREATE TABLE TEmpleadoProyecto (
    nEmpleadoID INT,
    nProyectoID INT,
    
    -- Definimos una llave primaria compuesta por ambos ID para evitar duplicados exactos
    PRIMARY KEY (nEmpleadoID, nProyectoID),
    CONSTRAINT FK_TEmpleadoProyecto_Empleado 
        FOREIGN KEY (nEmpleadoID) REFERENCES TEmpleado(nEmpleadoID),
    CONSTRAINT FK_TEmpleadoProyecto_Proyecto 
        FOREIGN KEY (nProyectoID) REFERENCES TProyecto(nProyectoID)
);
GO

-- 16. Agregar columna cEmail a TEmpleado.
ALTER TABLE TEmpleado 
ADD cEmail VARCHAR(150);
GO

-- 17. Agregar columna cTelefono.
-- (Le asignamos temporalmente un tamaño menor para luego modificarlo en el paso 26)
ALTER TABLE TEmpleado 
ADD cTelefono VARCHAR(15);
GO

-- 18. Modificar longitud de cNombre a 100 caracteres.
ALTER TABLE TEmpleado 
ALTER COLUMN cNombre VARCHAR(100);
GO

-- 19. Modificar longitud de cApellido a 100 caracteres.
ALTER TABLE TEmpleado 
ALTER COLUMN cApellido VARCHAR(100);
GO

-- 20. Agregar columna cDireccion.
ALTER TABLE TEmpleado 
ADD cDireccion VARCHAR(250);
GO

-- 21. Agregar columna nEdad.
ALTER TABLE TEmpleado 
ADD nEdad INT;
GO

-- 22. Crear restricción CHECK para edades entre 18 y 65 años.
ALTER TABLE TEmpleado 
ADD CONSTRAINT CHK_Edad CHECK (nEdad BETWEEN 18 AND 65);
GO

-- 23. Agregar restricción UNIQUE al correo electrónico.
ALTER TABLE TEmpleado 
ADD CONSTRAINT UQ_Email UNIQUE (cEmail);
GO

-- 24. Agregar columna bActivo tipo BIT con valor por defecto 1.
-- En SQL Server, es buena práctica nombrar la restricción DEFAULT (DEF_Activo).
ALTER TABLE TEmpleado 
ADD bActivo BIT CONSTRAINT DEF_Activo DEFAULT 1;
GO

-- 25. Eliminar la columna cDireccion.
ALTER TABLE TEmpleado 
DROP COLUMN cDireccion;
GO

-- 26. Cambiar el tipo de dato de teléfono a VARCHAR(20).
ALTER TABLE TEmpleado 
ALTER COLUMN cTelefono VARCHAR(20);
GO

-- 27. Agregar columna cGenero.
-- Usamos CHAR(1) ya que solo almacenará un carácter ('M' o 'F').
ALTER TABLE TEmpleado 
ADD cGenero CHAR(1);
GO

-- 28. Agregar restricción CHECK para que el género solo permita M o F.
ALTER TABLE TEmpleado 
ADD CONSTRAINT CHK_Genero CHECK (cGenero IN ('M', 'F'));
GO

-- 29. Agregar columna dFechaNacimiento.
ALTER TABLE TEmpleado 
ADD dFechaNacimiento DATE;
GO

-- 30. Crear una nueva tabla llamada TSucursal.
-- Como el ejercicio no especifica las columnas, creamos una estructura básica lógica.
CREATE TABLE TSucursal (
    nSucursalID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreSucursal VARCHAR(100) NOT NULL
);
GO

-- 31. Insertar 5 departamentos diferentes.
INSERT INTO TDepartamento (cNombreDepartamento) 
VALUES 
('Recursos Humanos'), 
('Tecnología'), 
('Ventas'), 
('Marketing'), 
('Finanzas');
GO

-- 32. Insertar 5 cargos diferentes.
INSERT INTO TCargo (cNombreCargo) 
VALUES 
('Gerente'), 
('Desarrollador Senior'), 
('Analista de Datos'), 
('Especialista de Marketing'), 
('Contador');
GO

-- 33. Insertar 10 empleados.
-- Se asume que los IDs de departamento y cargo van del 1 al 5 por las inserciones anteriores.
INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, cTelefono, nEdad, bActivo, cGenero, dFechaNacimiento)
VALUES 
('11111111A', 'Carlos', 'Ruiz', 1, 1, '2022-01-15', 1500.00, 'carlos.r@empresa.com', '555-0001', 45, 1, 'M', '1978-05-20'),
('22222222B', 'Lucia', 'Gomez', 2, 2, '2023-03-10', 1800.50, 'lucia.g@empresa.com', '555-0002', 32, 1, 'F', '1991-08-14'),
('33333333C', 'Miguel', 'Fernandez', 2, 3, '2023-06-01', 1200.00, 'miguel.f@empresa.com', '555-0003', 28, 1, 'M', '1995-11-02'),
('44444444D', 'Ana', 'Martinez', 3, 1, '2021-11-20', 1600.00, 'ana.m@empresa.com', '555-0004', 38, 1, 'F', '1985-02-25'),
('55555555E', 'Jorge', 'Lopez', 3, 3, '2022-08-15', 900.00, 'jorge.l@empresa.com', '555-0005', 25, 1, 'M', '1998-07-19'),
('66666666F', 'Laura', 'Diaz', 4, 4, '2023-01-10', 1100.00, 'laura.d@empresa.com', '555-0006', 29, 1, 'F', '1994-12-05'),
('77777777G', 'Pedro', 'Sanchez', 5, 5, '2020-05-18', 1400.00, 'pedro.s@empresa.com', '555-0007', 50, 1, 'M', '1973-04-10'),
('88888888H', 'Sofia', 'Romero', 4, 4, '2023-09-01', 1050.00, 'sofia.r@empresa.com', '555-0008', 26, 1, 'F', '1997-09-22'),
('99999999I', 'David', 'Alvarez', 2, 2, '2021-02-28', 1750.00, 'david.a@empresa.com', '555-0009', 35, 1, 'M', '1988-06-30'),
('00000000J', 'Elena', 'Torres', 1, 3, '2022-10-12', 950.00, 'elena.t@empresa.com', '555-0010', 40, 1, 'F', '1983-01-15');
GO

-- 34. Insertar 3 proyectos.
INSERT INTO TProyecto (cNombreProyecto, dFechaInicio, dFechaFinalizacion)
VALUES 
('Sistema de Gestión ERP', '2023-01-01', '2023-12-31'),
('Campaña Redes Sociales Q3', '2023-07-01', '2023-09-30'),
('Migración a la Nube', '2023-05-15', NULL); -- Proyecto aún no finalizado
GO

-- 35. Asignar empleados a proyectos (En la tabla intermedia TEmpleadoProyecto).
-- Asignaremos algunos empleados a los proyectos usando sus IDs
INSERT INTO TEmpleadoProyecto (nEmpleadoID, nProyectoID)
VALUES 
(2, 1), -- Lucia (Desarrolladora) al ERP
(3, 1), -- Miguel (Analista) al ERP
(9, 3), -- David (Desarrollador) a Migración
(6, 2), -- Laura (Marketing) a Campaña
(8, 2); -- Sofia (Marketing) a Campaña
GO

-- 36. Insertar un empleado utilizando el valor por defecto de fecha (dFechaContratacion).
-- Al omitir la columna "dFechaContratacion" en el INSERT, el motor aplica el DEFAULT GETDATE() que creamos en el paso 7.
INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nSalario, nEdad, cGenero)
VALUES ('12345678X', 'Roberto', 'Mendez', 800.00, 30, 'M');
GO

-- 37. Insertar un empleado con correo electrónico.
INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nSalario, nEdad, cGenero, cEmail)
VALUES ('87654321Y', 'Carmen', 'Vargas', 850.00, 27, 'F', 'carmen.v@empresa.com');
GO

-- 38. Insertar un empleado sin indicar estado activo.
-- Al omitir la columna "bActivo", aplicará la restricción DEFAULT 1 (paso 24).
INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nSalario, nEdad, cGenero, cEmail)
VALUES ('11223344Z', 'Hugo', 'Pinto', 750.00, 22, 'M', 'hugo.p@empresa.com');
GO

-- 39. Insertar registros usando múltiples VALUES.
-- Para este ejemplo, insertaremos varias sucursales en la tabla TSucursal creada en el paso 30, en una sola sentencia.
INSERT INTO TSucursal (cNombreSucursal)
VALUES 
('Sucursal Central - Managua'),
('Sucursal Norte - Estelí'),
('Sucursal Sur - Rivas');
GO

-- 40. Intentar insertar un salario negativo y analizar el error.
-- Esto generará un ERROR INTENCIONAL debido a la restricción CHECK (nSalario > 300) creada en el paso 6.
INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nSalario, nEdad, cGenero)
VALUES ('99887766W', 'Error', 'Humano', -150.00, 25, 'M');
GO


-- 41. Incrementar en 10% el salario de todos los empleados.
UPDATE TEmpleado 
SET nSalario = nSalario * 1.10;
GO

-- 42. Incrementar en 20% el salario de los empleados de un departamento específico.
UPDATE TEmpleado 
SET nSalario = nSalario * 1.20 
WHERE nDepartamentoID = 2;
GO

-- 43. Actualizar el correo electrónico de un empleado..
UPDATE TEmpleado 
SET cEmail = 'carlos.nuevo@empresa.com' 
WHERE nEmpleadoID = 1;
GO

-- 44. Modificar el cargo de un empleado.
UPDATE TEmpleado 
SET nCargoID = 1 
WHERE nEmpleadoID = 3;
GO

-- 45. Cambiar el departamento de dos empleados.
UPDATE TEmpleado 
SET nDepartamentoID = 5 
WHERE nEmpleadoID IN (4, 5);
GO

-- 46. Marcar como inactivos a los empleados con salario inferior a 500.
UPDATE TEmpleado 
SET bActivo = 0 
WHERE nSalario < 500;
GO

-- 47. Actualizar la fecha de finalización de un proyecto.
UPDATE TProyecto 
SET dFechaFinalizacion = '2024-02-10' 
WHERE nProyectoID = 3;
GO

-- 48. Asignar un nuevo proyecto a un empleado.
INSERT INTO TEmpleadoProyecto (nEmpleadoID, nProyectoID) 
VALUES (1, 3);
GO