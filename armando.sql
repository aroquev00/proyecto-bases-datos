-- Historial médico
-- enfermedades previas
-- síntoma
-- catalogo enfermedades
-- medicina

CREATE TABLE medicina (
    medicinaID INT,
    nombre VARCHAR(20),
    presentacion VARCHAR(50),
    PRIMARY KEY (medicinaID)
);

CREATE TABLE historial (
    historialID INT,
    fechaUltimaConsulta DATE,
    fechaActualizacion DATE,
    horasEjercicio INT,
    fumador BOOLEAN NOT NULL,
    tomador BOOLEAN NOT NULL,
    horasSuenio INT,
    calidadSuenio VARCHAR(10),
    PRIMARY KEY (medicinaID)  
);

CREATE TABLE enfermedadPrevia (

);

CREATE TABLE enfermedad (

);

CREATE TABLE sintoma (

);