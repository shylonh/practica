
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

-- 49. Eliminar un empleado específico mediante su NIF.
DELETE FROM TEmpleado 
WHERE cNIF = '12345678X';
GO

-- 50. Eliminar todos los empleados inactivos.
DELETE FROM TEmpleado 
WHERE bActivo = 0;
GO

-- 51. Eliminar un proyecto específico.
DELETE FROM TProyecto 
WHERE nProyectoID = 4;
GO

-- 52. Eliminar las asignaciones de un empleado en la tabla TEmpleadoProyecto.
DELETE FROM TEmpleadoProyecto 
WHERE nEmpleadoID = 2;
GO

-- 53. Eliminar un departamento que no tenga empleados asociados.
DELETE FROM TDepartamento 
WHERE nDepartamentoID NOT IN (
    SELECT DISTINCT nDepartamentoID 
    FROM TEmpleado 
    WHERE nDepartamentoID IS NOT NULL
);
GO

-- 54. Mostrar todos los empleados ordenados por apellido.
SELECT * FROM TEmpleado 
ORDER BY cApellido ASC;
GO

-- 55. Mostrar empleados con salario mayor a 1,000.
SELECT * FROM TEmpleado 
WHERE nSalario > 1000;
GO

-- 56. Mostrar empleados activos.
SELECT * FROM TEmpleado 
WHERE bActivo = 1;
GO

-- 57. Mostrar empleados contratados durante el año actual.
SELECT * FROM TEmpleado 
WHERE YEAR(dFechaContratacion) = YEAR(GETDATE());
GO

-- 58. Mostrar empleados y el nombre de su departamento.
SELECT E.nEmpleadoID, E.cNombre, E.cApellido, D.cNombreDepartamento
FROM TEmpleado E
INNER JOIN TDepartamento D ON E.nDepartamentoID = D.nDepartamentoID;
GO

-- 59. Mostrar empleados y el nombre de su cargo.
SELECT E.nEmpleadoID, E.cNombre, E.cApellido, C.cNombreCargo
FROM TEmpleado E
INNER JOIN TCargo C ON E.nCargoID = C.nCargoID;
GO

-- 60. Mostrar empleados asignados a proyectos.
SELECT DISTINCT E.nEmpleadoID, E.cNombre, E.cApellido
FROM TEmpleado E
INNER JOIN TEmpleadoProyecto EP ON E.nEmpleadoID = EP.nEmpleadoID;
GO

-- 61. Mostrar cantidad de empleados por departamento.
SELECT D.cNombreDepartamento, COUNT(E.nEmpleadoID) AS TotalEmpleados
FROM TDepartamento D
LEFT JOIN TEmpleado E ON D.nDepartamentoID = E.nDepartamentoID
GROUP BY D.cNombreDepartamento;
GO

-- 62. Mostrar salario promedio por departamento.
SELECT D.cNombreDepartamento, AVG(E.nSalario) AS SalarioPromedio
FROM TDepartamento D
INNER JOIN TEmpleado E ON D.nDepartamentoID = E.nDepartamentoID
GROUP BY D.cNombreDepartamento;
GO

-- 63. Mostrar salario máximo y mínimo por departamento.
SELECT D.cNombreDepartamento, 
       MAX(E.nSalario) AS SalarioMaximo, 
       MIN(E.nSalario) AS SalarioMinimo
FROM TDepartamento D
INNER JOIN TEmpleado E ON D.nDepartamentoID = E.nDepartamentoID
GROUP BY D.cNombreDepartamento;
GO

-- 64. Mostrar los proyectos con más de dos empleados asignados.
SELECT P.cNombreProyecto, COUNT(EP.nEmpleadoID) AS EmpleadosAsignados
FROM TProyecto P
INNER JOIN TEmpleadoProyecto EP ON P.nProyectoID = EP.nProyectoID
GROUP BY P.cNombreProyecto
HAVING COUNT(EP.nEmpleadoID) > 2;
GO

-- 65. Mostrar empleados cuyo apellido inicia con "G".
SELECT * FROM TEmpleado 
WHERE cApellido LIKE 'G%';
GO

-- 66. Mostrar empleados ordenados por salario descendente.
SELECT * FROM TEmpleado 
ORDER BY nSalario DESC;
GO

-- 67. Mostrar los tres salarios más altos.
SELECT TOP 3 nSalario, cNombre, cApellido 
FROM TEmpleado 
ORDER BY nSalario DESC;
GO

-- 68. Mostrar empleados con edad entre 25 y 40 años.
SELECT * FROM TEmpleado 
WHERE nEdad BETWEEN 25 AND 40;
GO

-- 69. Mostrar cantidad total de empleados activos.
SELECT COUNT(*) AS CantidadEmpleadosActivos 
FROM TEmpleado 
WHERE bActivo = 1;
GO

-- 70. Mostrar el total de proyectos registrados.
SELECT COUNT(*) AS TotalProyectosRegistrados 
FROM TProyecto;
GO

-- 71. Eliminar la restricción CHECK de edad.
ALTER TABLE TEmpleado 
DROP CONSTRAINT CHK_Edad;
GO

-- 72. Eliminar la restricción UNIQUE del correo.
ALTER TABLE TEmpleado 
DROP CONSTRAINT UQ_Email;
GO

-- 73. Agregar nuevamente ambas restricciones.
ALTER TABLE TEmpleado 
ADD CONSTRAINT CHK_Edad CHECK (nEdad BETWEEN 18 AND 65);

ALTER TABLE TEmpleado 
ADD CONSTRAINT UQ_Email UNIQUE (cEmail);
GO

-- 74. Eliminar la tabla TEmpleadoProyecto.
DROP TABLE TEmpleadoProyecto;
GO

-- 75. Eliminar la tabla TProyecto.
DROP TABLE TProyecto;
GO

-- 76. Eliminar la tabla TEmpleado.
DROP TABLE TEmpleado;
GO

-- 77. Eliminar la tabla TCargo.
DROP TABLE TCargo;
GO

-- 78. Eliminar la tabla TDepartamento.
DROP TABLE TDepartamento;
GO

-- 79. Eliminar la tabla TSucursal.
DROP TABLE TSucursal;
GO

USE master;
GO

ALTER DATABASE EmpresaSQL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE EmpresaSQL;
GO
-- 81. Crear una tabla TCliente con al menos 8 campos y restricciones.
CREATE TABLE TCliente (
    nClienteID INT IDENTITY(1,1) PRIMARY KEY,
    cNombre VARCHAR(100) NOT NULL,
    cApellido VARCHAR(100) NOT NULL,
    cIdentificacion VARCHAR(20) NOT NULL CONSTRAINT UQ_Cliente_Identificacion UNIQUE,
    cEmail VARCHAR(150) CONSTRAINT UQ_Cliente_Email UNIQUE,
    cTelefono VARCHAR(20),
    nEdad INT CONSTRAINT CHK_Cliente_Edad CHECK (nEdad >= 18),
    dFechaRegistro DATE CONSTRAINT DEF_Cliente_Fecha DEFAULT GETDATE(),
    bActivo BIT CONSTRAINT DEF_Cliente_Activo DEFAULT 1
);
GO

-- 82. Crear una tabla TVenta relacionada con TCliente.
CREATE TABLE TVenta (
    nVentaID INT IDENTITY(1,1) PRIMARY KEY,
    nClienteID INT NOT NULL,
    nSucursalID INT NOT NULL,
    dFechaVenta DATE NOT NULL,
    nMontoTotal DECIMAL(12,2) NOT NULL CONSTRAINT CHK_Venta_Monto CHECK (nMontoTotal >= 0),
    cEstado VARCHAR(20) CONSTRAINT DEF_Venta_Estado DEFAULT 'Completado',
    CONSTRAINT FK_TVenta_Cliente FOREIGN KEY (nClienteID) REFERENCES TCliente(nClienteID),
    CONSTRAINT FK_TVenta_Sucursal FOREIGN KEY (nSucursalID) REFERENCES TSucursal(nSucursalID)
);
GO

-- 83. Registrar 20 clientes.
INSERT INTO TCliente (cNombre, cApellido, cIdentificacion, cEmail, cTelefono, nEdad) VALUES
('Juan', 'Perez', '001-010190-0001A', 'juan.perez@mail.com', '8888-1111', 35),
('Maria', 'Lopez', '001-020292-0002B', 'maria.lopez@mail.com', '8888-2222', 28),
('Pedro', 'Torres', '001-030388-0003C', 'pedro.torres@mail.com', '8888-3333', 42),
('Ana', 'Castro', '001-040495-0004D', 'ana.castro@mail.com', '8888-4444', 31),
('Luis', 'Mendoza', '001-050591-0005E', 'luis.mendoza@mail.com', '8888-5454', 33),
('Sofia', 'Reyes', '001-060694-0006F', 'sofia.reyes@mail.com', '8888-6666', 26),
('Carlos', 'Sosa', '001-070785-0007G', 'carlos.sosa@mail.com', '8888-7777', 40),
('Elena', 'Gaitan', '001-080893-0008H', 'elena.gaitan@mail.com', '8888-8888', 30),
('Jorge', 'Blandon', '001-090989-0009I', 'jorge.blandon@mail.com', '8888-9999', 37),
('Lucia', 'Herrera', '001-101096-0010J', 'lucia.herrera@mail.com', '8888-1234', 25),
('Andres', 'Espinoza', '001-111184-0011K', 'andres.es@mail.com', '8888-5678', 41),
('Diana', 'Valle', '001-121297-0012L', 'diana.valle@mail.com', '8888-9012', 24),
('Ricardo', 'Arce', '001-131383-0013M', 'ricardo.arce@mail.com', '8888-3456', 43),
('Gabriela', 'Mejia', '001-141490-0014N', 'gabriela.m@mail.com', '8888-7890', 36),
('Roberto', 'Silva', '001-151587-0015O', 'roberto.silva@mail.com', '8888-2345', 39),
('Vanessa', 'Luna', '001-161695-0016P', 'vanessa.luna@mail.com', '8888-6789', 29),
('Manuel', 'Rizo', '001-171782-0017Q', 'manuel.rizo@mail.com', '8888-0123', 44),
('Tatiana', 'Cruz', '001-181894-0018R', 'tatiana.cruz@mail.com', '8888-4567', 32),
('Francisco', 'Duarte', '001-191986-0019S', 'fran.duarte@mail.com', '8888-8901', 38),
('Sonia', 'Pastora', '001-202091-0020T', 'sonia.p@mail.com', '8888-2468', 34),
-- Clientes extras sin compras para el paso 86:
('Cliente', 'SinCompra1', '001-212199-0021U', 'test1@mail.com', '8888-1357', 27),
('Cliente', 'SinCompra2', '001-222299-0022V', 'test2@mail.com', '8888-2460', 27);
GO

-- 84. Registrar 50 ventas.
INSERT INTO TVenta (nClienteID, nSucursalID, dFechaVenta, nMontoTotal) VALUES
(1, 1, '2026-01-10', 150.00), (2, 1, '2026-01-15', 2500.00), (3, 2, '2026-01-20', 340.00), (4, 3, '2026-01-25', 120.00), (5, 2, '2026-01-28', 850.00),
(6, 1, '2026-02-02', 95.00), (7, 3, '2026-02-14', 1100.00), (8, 2, '2026-02-18', 420.00), (9, 1, '2026-02-22', 2150.00), (10, 3, '2026-02-27', 60.00),
(11, 2, '2026-03-03', 1300.00), (12, 1, '2026-03-08', 500.00), (13, 3, '2026-03-12', 75.00), (14, 2, '2026-03-19', 2400.00), (15, 1, '2026-03-25', 180.00),
(16, 3, '2026-04-02', 950.00), (17, 2, '2026-04-09', 310.00), (18, 1, '2026-04-15', 1250.00), (19, 3, '2026-04-22', 415.00), (20, 1, '2026-04-29', 90.00),
(1, 2, '2026-05-05', 600.00), (2, 3, '2026-05-12', 150.00), (3, 1, '2026-05-18', 2200.00), (4, 2, '2026-05-24', 80.00), (5, 3, '2026-05-30', 710.00),
(6, 2, '2026-01-12', 540.00), (7, 1, '2026-02-15', 300.00), (8, 3, '2026-03-20', 125.00), (9, 2, '2026-04-25', 990.00), (10, 1, '2026-05-02', 115.00),
(11, 3, '2026-01-22', 800.00), (12, 2, '2026-02-28', 450.00), (13, 1, '2026-03-15', 1600.00), (14, 3, '2026-04-10', 220.00), (15, 2, '2026-05-14', 75.00),
(16, 1, '2026-01-05', 135.00), (17, 3, '2026-02-10', 670.00), (18, 2, '2026-03-22', 3000.00), (19, 1, '2026-04-18', 105.00), (20, 3, '2026-05-26', 850.00),
(1, 3, '2026-02-20', 450.00), (2, 2, '2026-03-14', 190.00), (3, 3, '2026-04-05', 730.00), (4, 1, '2026-05-11', 1200.00), (5, 1, '2026-03-01', 310.00),
(6, 3, '2026-04-12', 400.00), (7, 2, '2026-05-19', 85.00), (8, 1, '2026-01-30', 950.00), (9, 3, '2026-02-25', 160.00), (10, 2, '2026-03-11', 520.00);
GO

-- 85. Actualizar precios o montos de ventas según una condición.
UPDATE TVenta
SET nMontoTotal = nMontoTotal * 0.95
WHERE nMontoTotal > 2000;
GO

-- 86. Eliminar clientes sin ventas.
-- Removerá los dos clientes de prueba que agregamos con IDs 21 y 22.
DELETE FROM TCliente
WHERE nClienteID NOT IN (SELECT DISTINCT nClienteID FROM TVenta);
GO

-- 87. Consultar los 5 clientes con mayores compras.
SELECT TOP 5 C.nClienteID, C.cNombre, C.cApellido, SUM(V.nMontoTotal) AS TotalComprado
FROM TCliente C
INNER JOIN TVenta V ON C.nClienteID = V.nClienteID
GROUP BY C.nClienteID, C.cNombre, C.cApellido
ORDER BY TotalComprado DESC;
GO

-- 88. Consultar ventas por mes.
SELECT YEAR(dFechaVenta) AS Anio, MONTH(dFechaVenta) AS Mes, SUM(nMontoTotal) AS TotalMontoMes, COUNT(nVentaID) AS Transacciones
FROM TVenta
GROUP BY YEAR(dFechaVenta), MONTH(dFechaVenta)
ORDER BY Anio, Mes;
GO

-- 89. Consultar promedio de ventas por cliente.
SELECT C.nClienteID, C.cNombre, C.cApellido, AVG(V.nMontoTotal) AS PromedioPorCompra
FROM TCliente C
INNER JOIN TVenta V ON C.nClienteID = V.nClienteID
GROUP BY C.nClienteID, C.cNombre, C.cApellido;
GO

-- 90. Generar un reporte consolidado utilizando JOIN entre tres tablas.
SELECT V.nVentaID, 
       (C.cNombre + ' ' + C.cApellido) AS NombreCliente, 
       S.cNombreSucursal AS SucursalDeVenta, 
       V.dFechaVenta, 
       V.nMontoTotal AS MontoFinal Pagado
FROM TVenta V
INNER JOIN TCliente C ON V.nClienteID = C.nClienteID
INNER JOIN TSucursal S ON V.nSucursalID = S.nSucursalID;
GO