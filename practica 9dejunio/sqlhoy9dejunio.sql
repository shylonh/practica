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