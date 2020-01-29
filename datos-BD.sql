DELETE FROM medicamento;
DELETE FROM enfermedad;
DELETE FROM doctor;
DELETE FROM historial;
DELETE FROM paciente;
DELETE FROM consulta;
DELETE FROM consultaDiagnosticaEnfermedad;
DELETE FROM consultaRecetaMedicamento;

-- cada uno un paciente, cada paciente 5 consultas, 3 deben tener dos enfermedades y dos medicamentos
-- medicamentos
INSERT INTO medicamento (medicamentoID, nombre, presentacion)
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
INSERT INTO doctor (doctorID, cedula, nombreDoctor, apellidoDoctor, especialidadDoctor)
VALUES (1, 'C1', 'Juan', 'Perez', 'Nutriologo'),
(2, 'C2', 'Fatima', 'Gonzalez', 'Psicologo'),
(3, 'C3', 'Ruben', 'Lopez', 'Pediatra');

-- crear pacientes
INSERT INTO paciente (pacienteID, nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente, fechaNacimientoPaciente, generoPaciente, tipoSangrePaciente)
VALUES (1, 'Armando', 'Roque', 'Villasana', '2000-05-13', 'M', 'O+'),
(2, 'Emilio', 'Villarreal', 'Flores', '1998-10-11', 'M', 'B+'),
(3, 'Nestor', 'Rubio', 'Lopez', '1998-06-29', 'M', 'O+'),
(4, 'Erick', 'Hernandez', 'Vallejo', '1999-03-15', 'M', 'B-');

-- crear historiales de los pacientes
INSERT INTO historial (historialID, pacienteID, fechaUltimaConsulta, fechaUltimaActualizacion, horasEjercicio, fumador, tomador, horasSuenio, calidadSuenio)
VALUES (1, 1, '2020-01-24', '2020-01-27', 5, FALSE, FALSE, 8, 'Bueno'),
(2, 2, '2020-01-25', '2020-01-28', 3, FALSE, TRUE, 7, 'Regular'),
(3, 3, '2020-01-15','2020-01-27', 5, FALSE, TRUE, 7, 'Regular'),
(4, 4, '2020-01-26', '2020-01-29', 2, FALSE, FALSE, 6, 'Regular');

-- crear consultas

-- consultas de Armando
INSERT INTO consulta (consultaID, pacienteID, doctorID, numeroPoliza, fechaConsulta, pesoEnConsulta, estaturaEnConsulta, notaClinica, peea)
VALUES (1, 1, 1, NULL, '2019-01-27', 62, 1.7, 'nC 1', 'peea 1'),
(2, 1, 2, NULL, '2019-03-07', 62, 1.7, 'nC 2', 'peea 2'),
(3, 1, 1, NULL, '2019-06-20', 62, 1.7, 'nC 3', 'peea 3'),
(4, 1, 2, NULL, '2019-11-09', 62, 1.7, 'nC 4', 'peea 4'),
(5, 1, 1, NULL, '2020-01-24', 62, 1.7, 'nC 5', 'peea 5');

-- consultas de Emilio
INSERT INTO consulta (consultaID, pacienteID, doctorID, numeroPoliza, fechaConsulta, pesoEnConsulta, estaturaEnConsulta, notaClinica, peea)
VALUES (6, 2, 1, NULL, '2019-02-27', 60, 1.7, 'nC 6', 'peea 6'),
(7, 2, 2, NULL, '2019-04-07', 61, 1.7, 'nC 7', 'peea 7'),
(8, 2, 3, NULL, '2019-01-20', 60, 1.7, 'nC 8', 'peea 8'),
(9, 2, 2, NULL, '2019-10-09', 60, 1.7, 'nC 9', 'peea 9'),
(10, 2, 1, NULL, '2020-11-24', 59, 1.7, 'nC 10', 'peea 10');

-- consultas de Erick
INSERT INTO consulta (consultaID, pacienteID, doctorID, numeroPoliza, fechaConsulta, pesoEnConsulta, estaturaEnConsulta, notaClinica, peea)
VALUES (11, 4, 1, NULL, '2019-01-03', 65, 1.8, 'nC 11', 'peea 11'),
(12, 4, 2, NULL, '2019-03-23', 65, 1.8, 'nC 12', 'peea 12'),
(13, 4, 3, NULL, '2019-06-19', 64, 1.8, 'nC 13', 'peea 13'),
(14, 4, 2, NULL, '2019-11-10', 65, 1.8, 'nC 14', 'peea 14'),
(15, 4, 1, NULL, '2020-01-15', 65, 1.8, 'nC 15', 'peea 15');

-- consultas de Nestor
INSERT INTO consulta (consultaID, pacienteID, doctorID, numeroPoliza, fechaConsulta, pesoEnConsulta, estaturaEnConsulta, notaClinica, peea)
VALUES (16, 3, 1, NULL, '2019-01-17', 90, 1.77, 'nC 16', 'peea 16'),
(17, 3, 1, NULL, '2019-04-2', 90, 1.77, 'nC 17', 'peea 17'),
(18, 3, 3, NULL, '2019-07-19', 90, 1.77, 'nC 18', 'peea 18'),
(19, 3, 1, NULL, '2019-11-15', 90, 1.77, 'nC 19', 'peea 19'),
(20, 3, 2, NULL, '2020-01-15', 90, 1.77, 'nC 20', 'peea 20');



-- agregar diagnóstico de enfermedades
INSERT INTO consultaDiagnosticaEnfermedad (consultaID, enfermedadID)
VALUES (2, 3),
(2, 1),
(3, 3),
(3, 2),
(5,2),
(5, 1),
(6, 1),
(8, 2),
(10, 3),
(11, 3),
(13, 2),
(15, 2),
(16, 1),
(18, 1),
(20, 3);

-- agregar recetado de medicinas
INSERT INTO consultaRecetaMedicamento(consultaID, medicamentoID, fechaInicioReceta, fechaFinReceta, dosisReceta)
VALUES (2, 1, '2019-03-07', '2019-03-15', 'Una pastilla diario por las noches'),
(2, 2, '2019-03-07', '2019-03-15', 'Dos pastillsa diario por las noches'),
(3, 2, '2019-12-20', '2019-12-26', 'Una pastilla diario por las manianas'),
(3, 3, '2019-12-20', '2019-12-23', 'Una pastilla diario por la tarde'),
(5, 3, '2020-01-23', '2020-01-30', 'Una pastilla diario al mediodia'),
(5, 1, '2020-01-23', '2020-01-30', 'Media pastilla diario al mediodia'),
(6, 3, '2020-03-26', '2020-03-29', 'Una pastilla diario al mediodia'),
(8, 1, '2019-03-12', '2019-03-20', 'Una pastilla diario por las noches'),
(10, 1, '2019-04-13', '2019-04-20', 'Una pastilla diario al mediodia'),
(11, 2, '2019-05-14', '2019-05-21', 'Una pastilla diario por las manianas'),
(13, 3, '2019-06-09', '2019-06-15', 'Una pastilla diario por las noches'),
(15, 3, '2019-07-21', '2019-07-26', 'Una pastilla diario por las manianas'),
(16, 2, '2019-08-18', '2019-08-23', 'Una pastilla diario al mediodia'),
(18, 1, '2019-09-19', '2019-09-27', 'Una pastilla diario por las manianas'),
(20, 1, '2019-10-01', '2019-10-12', 'Una pastilla diario por las noches');