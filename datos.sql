
-- cada uno un paciente, cada paciente 5 consultas, 3 deben tener dos enfermedades y dos medicamentos
-- medicamentos
INSERT INTO medicina (medicamentoID, nombre, presentacion)
VALUES (1, 'Loratadina', '10 mg'),
(2, 'Ibuprofeno', '200 mg'),
(3, 'Amoxicilina', '500 mg'),
(4, 'Omeprazol', '20 mg');

-- enfermedades
INSERT INTO enfermedad (enfermedadID, nombreEnfermedad)
VALUES (1, 'Coronavirus'),
(2, 'Influenza'),
(3, 'Sinusitis');

-- crear doctores
INSERT INTO doctor ()
VALUES ();

-- crear pacientes
INSERT INTO paciente (pacienteID, historialID, nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente, fechaNacimientoPaciente, generoPaciente, tipoSangrePaciente)
VALUES (1, 1, 'Armando', 'Roque', 'Villasana', 2000-05-13, 'M', 'O+'),
(),
(),
(),
();

-- crear historiales de los pacientes
INSERT INTO historial (historialID, fechaUltimaConsulta, fechaUltimaActualizacion, horasEjercicio, fumador, tomador, horasSuenio, calidadSuenio)
VALUES (1, 2020-01-24, 2020-01-27, 5, FALSE, FALSE, 8, 'Bueno'),
(),
(),
(),
();

-- crear consultas

-- consultas de Armando
INSERT INTO consulta (consultaID, pacienteID, doctorID, numeroPoliza, fechaConsulta, pesoEnConsulta, estaturaEnConsulta, notaClinica, peea)
VALUES (1, 1, 1, NULL, 2019-01-27, 62, 1.7, 'nC 1', 'peea 1'),
(2, 1, 2, NULL, 2019-03-07, 62, 1.7, 'nC 2', 'peea 2'),
(3, 1, 1, NULL, 2019-06-20, 62, 1.7, 'nC 3', 'peea 3'),
(4, 1, 2, NULL, 2019-11-09, 62, 1.7, 'nC 4', 'peea 4'),
(5, 1, 1, NULL, 2020-01-24, 62, 1.7, 'nC 5', 'peea 5');


-- agregar diagnóstico de enfermedades
INSERT INTO consultaDiagnosticaEnfermedad (consultaID, enfermedadID)
VALUES (2, 3),
(3, 3),
(5,2);

-- agregar recetado de medicinas
INSERT INTO consultaRecetaEnfermedad (consultaID, medicamentoID, fechaInicioReceta, fechaFinReceta, dosisReceta)
VALUES (2, 1, 2019-03-07, 2019-03-15, 'Una pastilla diario por las noches'),
(3, 2, 2019-06-20, 2019-7-10, 'Una pastilla diario por las manianas'),
(5, 3, 2020-01-24, 2020-01-30, 'Una pastilla diario al mediodia');






