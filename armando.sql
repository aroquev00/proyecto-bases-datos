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

-- falta el FK al paciente, o del paciente al historial
CREATE TABLE historial (
    historialID INT,
    fechaUltimaConsulta DATE,
    fechaUltimaActualizacion DATE,
    horasEjercicio INT,
    fumador BOOLEAN,
    tomador BOOLEAN,
    horasSuenio INT,
    calidadSuenio VARCHAR(10),
    PRIMARY KEY (medicinaID)  
);

CREATE TABLE enfermedadPrevia (
    enfermedadPreviaID INT,
    fechaEnfermedad DATE,
    -- tratamientos? multivalue
    enfermedadID INT,
    PRIMARY KEY (enfermedadPreviaID),
    FOREIGN KEY (enfermedadID) REFERENCES enfermedad(enfermedadID)
);

CREATE TABLE enfermedad (
    enfermedadID INT,
    nombreEnfermedad VARCHAR(20),
    PRIMARY KEY (enfermedadID)
);

CREATE TABLE sintoma (
    sintomaID INT,
    nombreSintoma VARCHAR(20),
    descripcionSintoma VARCHAR(1000)
    PRIMARY KEY (sintomaID)
);