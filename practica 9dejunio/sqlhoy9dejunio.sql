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