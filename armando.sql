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

CREATE TABLE paciente(
  pacienteID int NOT NULL,
  nombre varchar(20),
  apellidoPaterno varchar(20),
  apellidoMaterno varchar(20),
  fechaNacimiento date,
  genero char,
  tipoSangre varchar(3),
  PRIMARY KEY(pacienteID)
  FOREIGN KEY(historialID) REFERENCES Historial(historalID),
  FOREIGN KEY(numeroPoliza) REFERENCES SeguroMedico(numeroPoliza),
  FOREIGN KEY(visitaID) REFERENCES Consulta(visitaID)
);

CREATE TABLE seguroMedico(
  numeroPoliza int,
  vigencia date,
  expedicion date,
  compañia varchar(50),
  limite int
  PRIMARY KEY(numeroPoliza)
);

CREATE TABLE consulta(
  consultaID int,
  fecha date,
  peso double,
  estatura double,
  notaClinica varchar(500),
  peea varchar(500),
  PRIMARY KEY (visitaID),
  FOREIGN KEY(numeroPoliza) REFERENCES SeguroMedico(numeroPoliza),
  FOREIGN KEY(doctorID) REFERENCES Doctor(doctorID)
);

CREATE TABLE doctor(
  doctorID int,
  cedula char(18),
  nombre varchar(20),
  apellido varchar(20)
  PRIMARY KEY(doctorID)
);

CREATE TABLE reportan (
    consultaID INT,
    sintomaID INT,
    FOREIGN KEY (consultaID) REFERENCES Consulta(consultaID),
    FOREIGN KEY (sintomaID) REFERENCES Sintoma(sintomaID)
);

CREATE TABLE examen (
examenID INT,
tipo CHAR,
fechaEmision DateTime,
nombre VARCHAR(15),
PRIMARY KEY(examenID)
); 

CREATE TABLE tieneExamen (
examenID INT,
historialID INT,
PRIMARY KEY (examenID,historialID),
FOREIGN KEY(examenID) references Examen(examenID),
FOREIGN KEY(historialID) references Historial(historialID)
);

CREATE TABLE pregunta(
preguntaID INT,
fechaUltimaEdicion DATETIME,
pregunta VARCHAR(100),
descripcion VARCHAR(1000),
PRIMARY KEY (preguntaID)
);

CREATE TABLE posibleRespuestas(
preguntaID INT,
posibleRespuesta CHAR,
PRIMARY KEY(preguntaID, posibleRespuesta),
FOREIGN KEY (preguntaID) references Pregunta(preguntaID)
);

CREATE TABLE respuesta (
respuestaID INT,
examenID INT,
preguntaID INT,
fechaUltimaEdicion datetime,
respuesta CHAR,
PRIMARY KEY (respuestaID),
FOREIGN KEY (examenID) references Examen(examenID),
FOREIGN KEY (preguntaID) references Pregunta(preguntaID)
);
