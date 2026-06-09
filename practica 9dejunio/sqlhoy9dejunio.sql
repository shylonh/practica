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