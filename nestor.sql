CREATE TABLE Paciente(
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

CREATE TABLE SeguroMedico(
  numeroPoliza int,
  vigencia date,
  expedicion date,
  compañia varchar(50),
  limite int
  PRIMARY KEY(numeroPoliza)
);

CREATE TABLE Consulta(
  visitaID int,
  fecha date,
  peso double,
  estatura double,
  notaClinica varchar(500),
  peea varchar(500),
  PRIMARY KEY (visitaID),
  FOREIGN KEY(numeroPoliza) REFERENCES SeguroMedico(numeroPoliza),FOREIGN KEY(doctorID) REFERENCES Doctor(doctorID)
;)

CREATE TABLE Doctor(
  doctorID int,
  cedula char(18),
  nombre varchar(20),
  apellido varchar(20)
  PRIMARY KEY(doctorID)
);

  