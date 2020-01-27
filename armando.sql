-- Historial médico
-- enfermedades previas
-- síntoma
-- catalogo enfermedades
-- medicamento
-- receta

CREATE TABLE medicamento (
    medicamentoID INT,
    nombre VARCHAR(20),
    presentacion VARCHAR(50),
    PRIMARY KEY (medicamentoID)
);

CREATE TABLE consultaRecetaMedicamento (
    consultaID INT,
    medicamentoID INT,
    fechaInicioReceta DATE,
    fechaFinReceta DATE,
    dosisReceta VARCHAR(100),
    PRIMARY KEY (consultaID, medicamentoID),
    FOREIGN KEY (consultaID) REFERENCES consulta(consultaID),
    FOREIGN KEY (medicamentoID) REFERENCES medicamento(medicamentoID)
);

CREATE TABLE enfermedad (
    enfermedadID INT,
    nombreEnfermedad VARCHAR(20),
    PRIMARY KEY (enfermedadID)
);

CREATE TABLE consultaDiagnosticaEnfermedad (
    consultaID INT,
    enfermedadID INT,
    PRIMARY KEY (consultaID, enfermedadID),
    FOREIGN KEY (consultaID) REFERENCES consulta(consultaID),
    FOREIGN KEY (enfermedadID) REFERENCES enfermedad(enfermedadID)
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
    PRIMARY KEY (medicamentoID)  
);

CREATE TABLE enfermedadPrevia (
    enfermedadPreviaID INT,
    fechaEnfermedad DATE,
    tratamientoEnfermedadPrevia VARCHAR(1000),
    enfermedadID INT,
    PRIMARY KEY (enfermedadPreviaID),
    FOREIGN KEY (enfermedadID) REFERENCES enfermedad(enfermedadID)
);

CREATE TABLE antecedenteFamiliar (
    historialPacienteID INT,
    historialFamiliarID INT,
    parentesco VARCHAR(20),
    PRIMARY KEY (historialPacienteID, historialFamiliarID),
    FOREIGN KEY (historialPacienteID) REFERENCES paciente(pacienteID),
    FOREIGN KEY (historialFamiliarID) REFERENCES paciente(pacienteID)
);

CREATE TABLE sintoma (
    sintomaID INT,
    nombreSintoma VARCHAR(20),
    descripcionSintoma VARCHAR(1000)
    PRIMARY KEY (sintomaID)
);