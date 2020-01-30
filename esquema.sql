DROP DATABASE expedienteMedico;
BEGIN;
CREATE DATABASE expedienteMedico;
USE expedienteMedico;

CREATE TABLE medicamento ( 
    medicamentoID INT,
    nombre VARCHAR(20),
    presentacion VARCHAR(50),
    PRIMARY KEY (medicamentoID)
);

CREATE TABLE enfermedad (
    enfermedadID INT,
    nombreEnfermedad VARCHAR(20),
    PRIMARY KEY (enfermedadID)
);

CREATE TABLE paciente(
  pacienteID int NOT NULL,
  nombrePaciente varchar(20),
  apellidoPaternoPaciente varchar(20),
  apellidoMaternoPaciente varchar(20),
  fechaNacimientoPaciente date,
  generoPaciente char,
  tipoSangrePaciente varchar(3),
  callePaciente VARCHAR(30),
  coloniaPaciente VARCHAR(30),
  ciudadPaciente VARCHAR(10),
  telefonoPaciente VARCHAR(10),
  PRIMARY KEY(pacienteID)
);

CREATE TABLE historial (
    historialID INT,
    pacienteID INT,
    fechaUltimaConsulta DATE,
    fechaUltimaActualizacion DATE,
    horasEjercicio INT,
    fumador BOOLEAN,
    tomador BOOLEAN,
    horasSuenio INT,
    calidadSuenio VARCHAR(10),
    PRIMARY KEY (historialID),
    FOREIGN KEY(pacienteID) REFERENCES paciente(pacienteID)
);

CREATE TABLE sintoma (
    sintomaID INT,
    nombreSintoma VARCHAR(20),
    descripcionSintoma VARCHAR(1000),
    PRIMARY KEY (sintomaID)
);

CREATE TABLE doctor(
  doctorID int,
  cedula char(18),
  nombreDoctor varchar(20),
  apellidoDoctor varchar(20),
  especialidadDoctor VARCHAR(20),
  PRIMARY KEY(doctorID)
);

CREATE TABLE seguroMedico(
  numeroPoliza int,
  pacienteID INT,
  vigenciaSeguroMedico date,
  expedicionSeguroMedico date,
  companiaSeguroMedico varchar(50),
  limiteSeguroMedico int,
  PRIMARY KEY(numeroPoliza),
  FOREIGN KEY (pacienteID) REFERENCES paciente(pacienteID)
);

CREATE TABLE consulta(
  consultaID int,
  pacienteID INT,
  doctorID INT,
  numeroPoliza INT,
  fechaConsulta date,
  pesoEnConsulta FLOAT,
  estaturaEnConsulta FLOAT,
  notaClinica varchar(500),
  peea varchar(500),
  PRIMARY KEY (consultaID),
  FOREIGN KEY(pacienteID) REFERENCES paciente(pacienteID),
  FOREIGN KEY(doctorID) REFERENCES doctor(doctorID),
  FOREIGN KEY(numeroPoliza) REFERENCES seguroMedico(numeroPoliza)
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


CREATE TABLE consultaDiagnosticaEnfermedad (
    consultaID INT,
    enfermedadID INT,
    PRIMARY KEY (consultaID, enfermedadID),
    FOREIGN KEY (consultaID) REFERENCES consulta(consultaID),
    FOREIGN KEY (enfermedadID) REFERENCES enfermedad(enfermedadID)
);

CREATE TABLE enfermedadPrevia (
    enfermedadPreviaID INT,
    historialID INT,
    fechaEnfermedad DATE,
    enfermedadID INT,
    tratamientoEnfermedadPrevia VARCHAR(1000),
    PRIMARY KEY (enfermedadPreviaID),
    FOREIGN KEY (historialID) REFERENCES historial(historialID),
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


CREATE TABLE consultaReportaSintoma (
    consultaID INT,
    sintomaID INT,
    PRIMARY KEY (consultaID, sintomaID),
    FOREIGN KEY (consultaID) REFERENCES consulta(consultaID),
    FOREIGN KEY (sintomaID) REFERENCES sintoma(sintomaID)
);

CREATE TABLE examen (
examenID INT,
tipoExamen VARCHAR(20),
fechaEmision DateTime,
nombre VARCHAR(15),
PRIMARY KEY(examenID)
); 

CREATE TABLE historialTieneExamen (
examenID INT,
historialID INT,
PRIMARY KEY (examenID, historialID),
FOREIGN KEY(examenID) references examen(examenID),
FOREIGN KEY(historialID) references historial(historialID)
);

CREATE TABLE pregunta(
preguntaID INT,
fechaUltimaEdicion DATE,
pregunta VARCHAR(100),
descripcion VARCHAR(1000),
PRIMARY KEY (preguntaID)
);

CREATE TABLE posibleRespuestas(
preguntaID INT,
posibleRespuesta VARCHAR(20),
PRIMARY KEY(preguntaID, posibleRespuesta),
FOREIGN KEY (preguntaID) references pregunta(preguntaID)
);

CREATE TABLE respuesta (
respuestaID INT,
examenID INT,
preguntaID INT,
fechaRespuesta date,
respuesta VARCHAR(20),
PRIMARY KEY (respuestaID),
FOREIGN KEY (examenID) references examen(examenID),
FOREIGN KEY (preguntaID) references pregunta(preguntaID)
);
END;