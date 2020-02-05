-- 1. ExpedientePaciente

-- 1.1 Datos Generales
DROP PROCEDURE IF EXISTS datosGeneralesPaciente;
CREATE PROCEDURE datosGeneralesPaciente(IN p_nombre VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT P.pacienteID AS ID, CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) AS nombrePaciente, TIMESTAMPDIFF(year, P.fechaNacimientoPaciente, CURDATE()) AS edadPaciente, P.generoPaciente, P.tipoSangrePaciente, CONCAT(P.callePaciente, ', Col. ', P.coloniaPaciente, ', ', P.ciudadPaciente) AS direccionPaciente, P.telefonoPaciente,
           CASE WHEN H.fumador = '0' THEN 'No' ELSE 'Si' END AS fumador,
           CASE WHEN H.tomador = '0' THEN 'No' ELSE 'Si' END AS tomador,
           H.horasSuenio, H.calidadSuenio, H.horasEjercicio, COUNT(c.consultaID) AS numeroConsultas, IFNULL(H.fechaUltimaConsulta, 'No registrado') AS fechaUltimaConsulta, H.fechaUltimaActualizacion
    FROM paciente AS P
    JOIN historial H on P.pacienteID = H.pacienteID
    JOIN consulta c on P.pacienteID = c.pacienteID
    WHERE CASE
        WHEN p_nombre = '' THEN P.pacienteID = p_ID
        ELSE CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) LIKE CONCAT('%', p_nombre, '%') OR P.pacienteID = p_ID
        END
    GROUP BY P.pacienteID, nombrePaciente, edadPaciente, P.generoPaciente, P.tipoSangrePaciente, direccionPaciente, P.telefonoPaciente, H.fumador, H.tomador, H.horasSuenio, H.calidadSuenio, H.horasEjercicio, H.fechaUltimaConsulta, H.fechaUltimaActualizacion;
END;

-- 1.2 Detalle de consultas
DROP PROCEDURE IF EXISTS detalleConsultasPaciente;
CREATE PROCEDURE detalleConsultasPaciente(IN p_nombre VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT C.consultaID, C.fechaConsulta, TIMESTAMPDIFF(year, fechaNacimientoPaciente, fechaConsulta) AS edadPaciente, C.pesoEnConsulta AS peso, C.estaturaEnConsulta AS estatura, CONCAT(nombreDoctor, ' ', apellidoDoctor) AS nombreDoctor, D.especialidadDoctor, peea, notaClinica, COUNT(DISTINCT cDE.enfermedadID) AS numeroEnfermedadesDiagnosticadas, COUNT(DISTINCT cRM.medicamentoID) AS numeroMedicamentosRecetados, IFNULL(CONCAT(sM.companiaSeguroMedico, ' Poliza: ',sM.numeroPoliza), 'Sin seguro') AS aseguradora
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    JOIN doctor AS D ON C.doctorID = D.doctorID
    LEFT JOIN seguroMedico sM on C.numeroPoliza = sM.numeroPoliza
    LEFT JOIN consultaDiagnosticaEnfermedad cDE on C.consultaID = cDE.consultaID
    LEFT JOIN consultaRecetaMedicamento cRM on C.consultaID = cRM.consultaID
    WHERE CASE
        WHEN p_nombre = '' THEN P.pacienteID = p_ID
        ELSE CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) LIKE CONCAT('%', p_nombre, '%') OR P.pacienteID = p_ID
        END
    GROUP BY C.consultaID, C.fechaConsulta, edadPaciente, peso, estatura, nombreDoctor, D.especialidadDoctor, peea, notaClinica, aseguradora
    ORDER BY C.fechaConsulta DESC;
END;

-- 1.3 Detalle enefermedades diagnosticadas
DROP PROCEDURE IF EXISTS detalleEnfermedadesPaciente;
CREATE PROCEDURE detalleEnfermedadesPaciente(IN p_nombre VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT C.consultaID, C.fechaConsulta, TIMESTAMPDIFF(year, fechaNacimientoPaciente, fechaConsulta) AS edadPaciente, CONCAT(nombreDoctor, ' ', apellidoDoctor) AS nombreDoctor, D.especialidadDoctor, e.enfermedadID, e.DSM5, e.ICD9CM, e.ICD10M
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    JOIN doctor AS D ON C.doctorID = D.doctorID
    JOIN consultaDiagnosticaEnfermedad cDE on C.consultaID = cDE.consultaID
    JOIN enfermedad e on cDE.enfermedadID = e.enfermedadID
    WHERE CASE
        WHEN p_nombre = '' THEN P.pacienteID = p_ID
        ELSE CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) LIKE CONCAT('%', p_nombre, '%') OR P.pacienteID = p_ID
        END
    ORDER BY C.fechaConsulta DESC;
END;

-- 1.4 Detalle medicamentos recetados
DROP PROCEDURE IF EXISTS detalleMedicamentosPaciente;
CREATE PROCEDURE detalleMedicamentosPaciente(IN p_nombre VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT C.consultaID, C.fechaConsulta, TIMESTAMPDIFF(year, fechaNacimientoPaciente, fechaConsulta) AS edadPaciente, CONCAT(nombreDoctor, ' ', apellidoDoctor) AS nombreDoctor, D.especialidadDoctor, m.medicamentoID, m.nombreMedicamento, m.sustanciaActivaMedicamento, m.miligramosMedicamento, IFNULL(m.presentacionMedicamento, 'No definido') AS presentacionMedicamento, IFNULL(m.usoMedicamento, 'No registrado') AS usoMedicamento, fechaInicioReceta, fechaFinReceta, cRM.dosisReceta AS dosis
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    JOIN doctor AS D ON C.doctorID = D.doctorID
    JOIN consultaRecetaMedicamento cRM on C.consultaID = cRM.consultaID
    JOIN medicamento m on cRM.medicamentoID = m.medicamentoID
    WHERE CASE
        WHEN p_nombre = '' THEN P.pacienteID = p_ID
        ELSE CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) LIKE CONCAT('%', p_nombre, '%') OR P.pacienteID = p_ID
        END
    ORDER BY C.fechaConsulta DESC;
END;

-- 1.5 Resultados de exámenes
DROP PROCEDURE IF EXISTS resultadosExamenesGeneral;
CREATE PROCEDURE resultadosExamenesGeneral(IN p_nombre VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT P.pacienteID, C.consultaID, IE.instanciaID, IE.examenID, e.tipoExamen, IE.fechaPresentado, SUM(respuesta) AS Resultado,
           CASE
              WHEN e.tipoExamen = 'Examen Depresion' THEN (CASE
                  WHEN SUM(respuesta) <= 7 THEN 'Normal range'
                  WHEN SUM(respuesta) > 7 AND SUM(respuesta) < 20 THEN 'Mild to moderate depression'
                  ELSE 'Severe depression'
                  END)
              ELSE (CASE
                  WHEN SUM(respuesta) < 17 THEN 'Mild anxiety'
                  WHEN SUM(respuesta) >= 17 AND SUM(respuesta) <= 24 THEN 'Moderate anxiety'
                  ELSE 'Severe anxiety'
              END)
          END AS evaluacion
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID=C.pacienteID
    JOIN instanciaExamen AS IE ON C.consultaID=IE.consultaID
    JOIN respuesta AS R ON R.instanciaID=IE.instanciaID
    JOIN examen e on IE.examenID = e.examenID
    WHERE CASE
        WHEN p_nombre = '' THEN P.pacienteID = p_ID
        ELSE CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) LIKE CONCAT('%', p_nombre, '%') OR P.pacienteID = p_ID
        END
    GROUP BY P.pacienteID, C.consultaID, IE.instanciaID, IE.examenID, e.tipoExamen, IE.fechaPresentado;
END;



-- 1.6 Antecedentes familiares
DROP PROCEDURE IF EXISTS antecedentesFamiliares;
CREATE PROCEDURE antecedentesFamiliares(IN p_nombre VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT CONCAT(F.nombrePaciente, ' ', F.apellidoPaternoPaciente, ' ', F.apellidoMaternoPaciente) AS nombreFamiliar, AF.parentesco, IEPF.enfermedadID AS enfermedadID, IEPF.DSM5 AS enfermedad, EPF.fechaEnfermedad, TIMESTAMPDIFF(year, F.fechaNacimientoPaciente, EPF.fechaEnfermedad) AS edadAlPadecer, EPF.tratamientoEnfermedadPrevia AS tratamientoRecibido
    FROM paciente AS P
    JOIN historial AS HP ON P.pacienteID = HP.pacienteID
    JOIN antecedenteFamiliar AS AF ON HP.historialID = AF.historialPacienteID
    JOIN historial AS HF ON AF.historialFamiliarID = HF.historialID
    JOIN paciente AS F ON HF.pacienteID = F.pacienteID
    JOIN enfermedadPrevia AS EPF ON HF.historialID = EPF.historialID
    JOIN enfermedad AS IEPF ON EPF.enfermedadPreviaID = IEPF.enfermedadID
    WHERE CASE
        WHEN p_nombre = '' THEN P.pacienteID = p_ID
        ELSE CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) LIKE CONCAT('%', p_nombre, '%') OR P.pacienteID = p_ID
        END
    ORDER BY nombreFamiliar, fechaEnfermedad DESC;
END;

-- 2 Detalle de exámenes por paciente
DROP PROCEDURE IF EXISTS reporteExamenes;
CREATE PROCEDURE reporteExamenes(IN p_nombre VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT P.pacienteID, CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) AS nombrePaciente, C.consultaID, d.nombreDoctor, IE.instanciaID, e.examenID, e.tipoExamen, IE.fechaPresentado, SUM(respuesta) AS Resultado,
           CASE
              WHEN e.tipoExamen = 'Examen Depresion' THEN (CASE
                  WHEN SUM(respuesta) <= 7 THEN 'Normal range'
                  WHEN SUM(respuesta) > 7 AND SUM(respuesta) < 20 THEN 'Mild to moderate depression'
                  ELSE 'Severe depression'
                  END)
              ELSE (CASE
                  WHEN SUM(respuesta) < 17 THEN 'Mild anxiety'
                  WHEN SUM(respuesta) >= 17 AND SUM(respuesta) <= 24 THEN 'Moderate anxiety'
                  ELSE 'Severe anxiety'
              END)
          END AS evaluacion
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID=C.pacienteID
    JOIN doctor d on C.doctorID = d.doctorID
    JOIN instanciaExamen AS IE ON C.consultaID=IE.consultaID
    JOIN respuesta AS R ON R.instanciaID=IE.instanciaID
    JOIN examen e on IE.examenID = e.examenID
    WHERE CASE
        WHEN p_nombre = '' THEN P.pacienteID = p_ID
        ELSE CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) LIKE CONCAT('%', p_nombre, '%') OR P.pacienteID = p_ID
        END
    GROUP BY P.pacienteID, C.consultaID, d.nombreDoctor, IE.instanciaID, e.examenID, e.tipoExamen, IE.fechaPresentado;
END;

-- 2.1.1. Detalle de un examen específico, con sus preguntas y resultados
DROP PROCEDURE IF EXISTS reporteExamenBusqueda;
CREATE PROCEDURE reporteExamenBusqueda(IN e_instanciaID INT)
BEGIN
    SELECT P.pacienteID, CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) AS nombrePaciente, C.consultaID, CONCAT(d.nombreDoctor, ' ', d.apellidoDoctor) AS nombreDoctor, IE.instanciaID, IE.examenID, e.tipoExamen, IE.fechaPresentado, SUM(respuesta) AS Resultado,
           CASE
              WHEN e.tipoExamen = 'Examen Depresion' THEN (CASE
                  WHEN SUM(respuesta) <= 7 THEN 'Normal range'
                  WHEN SUM(respuesta) > 7 AND SUM(respuesta) < 20 THEN 'Mild to moderate depression'
                  ELSE 'Severe depression'
                  END)
              ELSE (CASE
                  WHEN SUM(respuesta) < 17 THEN 'Mild anxiety'
                  WHEN SUM(respuesta) >= 17 AND SUM(respuesta) <= 24 THEN 'Moderate anxiety'
                  ELSE 'Severe anxiety'
              END)
          END AS evaluacion
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID=C.pacienteID
    JOIN doctor d on C.doctorID = d.doctorID
    JOIN instanciaExamen AS IE ON C.consultaID=IE.consultaID
    JOIN respuesta AS R ON R.instanciaID=IE.instanciaID
    JOIN examen e on IE.examenID = e.examenID
    WHERE IE.instanciaID = e_instanciaID
    GROUP BY P.pacienteID, C.consultaID, d.nombreDoctor, IE.examenID, e.tipoExamen, IE.fechaPresentado;
END;

-- 2.1.2. Preguntas y resultados
DROP PROCEDURE IF EXISTS detallePreguntasExamenBusqueda;
CREATE PROCEDURE detallePreguntasExamenBusqueda(IN e_instanciaID INT)
BEGIN
  SELECT p.preguntaID, p.pregunta, IFNULL(p.descripcion, '') AS descripcion, r.respuesta, r.respuestaID
  FROM instanciaExamen iE
  JOIN respuesta r ON iE.instanciaID = r.instanciaID
  JOIN pregunta p ON r.preguntaID = p.preguntaID
  WHERE iE.instanciaID = e_instanciaID;
END;

-- 3. Lista de pacientes con su número de consultas
DROP PROCEDURE IF EXISTS numeroConsultasPaciente;
CREATE PROCEDURE numeroConsultasPaciente()
BEGIN
    SELECT CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombrePaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, CURDATE()) AS edadPaciente, COUNT(consultaID) AS numeroConsultas, H.fechaUltimaConsulta
    FROM paciente AS P
    JOIN historial H on P.pacienteID = H.pacienteID
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    GROUP BY nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente, edadPaciente, fechaUltimaConsulta
    ORDER BY numeroConsultas;
END;


-- 4. Nombre Medicamento, Número de Veces Recetado de mayor a menor
DROP PROCEDURE IF EXISTS numeroVecesMedicamentoRecetado;
CREATE PROCEDURE numeroVecesMedicamentoRecetado()
BEGIN
    SELECT M.medicamentoID AS ID, M.nombreMedicamento AS nombre, IFNULL(M.presentacionMedicamento, 'No definido') AS presentacion, M.miligramosMedicamento AS miligramos, M.sustanciaActivaMedicamento AS sustanciaActiva, IFNULL(M.usoMedicamento, 'No registrado') AS uso, M.numeroMedicamento AS numero, COUNT(*) AS numeroVecesRecetado
    FROM medicamento AS M
    JOIN consultaRecetaMedicamento AS CRM ON M.medicamentoID = CRM.medicamentoID
    GROUP BY M.medicamentoID, M.nombreMedicamento, M.presentacionMedicamento, M.miligramosMedicamento, M.sustanciaActivaMedicamento, M.usoMedicamento, M.numeroMedicamento
    ORDER BY numeroVecesRecetado DESC;
END;

-- 5. Nombre Medicamento, Número de Veces Recetado por búsqueda
DROP PROCEDURE IF EXISTS numeroVecesMedicamentoRecetadoBusqueda;
CREATE PROCEDURE numeroVecesMedicamentoRecetadoBusqueda(IN m_dato VARCHAR(500), IN m_ID INT)
BEGIN
    SELECT M.medicamentoID AS ID, M.nombreMedicamento AS nombre, IFNULL(M.presentacionMedicamento, 'No definido') AS presentacion, M.miligramosMedicamento AS miligramos, M.sustanciaActivaMedicamento AS sustanciaActiva, IFNULL(M.usoMedicamento, 'No registrado') AS uso, M.numeroMedicamento AS numero, IFNULL(COUNT(CRM.consultaID), 0) AS numeroVecesRecetado
    FROM medicamento AS M
    LEFT JOIN consultaRecetaMedicamento AS CRM ON M.medicamentoID = CRM.medicamentoID
    WHERE CASE
        WHEN m_dato = '' THEN M.medicamentoID = m_ID
        ELSE M.nombreMedicamento LIKE CONCAT('%', m_dato, '%') OR M.presentacionMedicamento = m_dato OR M.miligramosMedicamento = m_dato OR M.sustanciaActivaMedicamento LIKE CONCAT('%', m_dato, '%') OR M.usoMedicamento LIKE CONCAT('%', m_dato, '%') OR M.numeroMedicamento = m_dato OR M.medicamentoID = m_ID
    END
    GROUP BY M.medicamentoID, M.nombreMedicamento, M.presentacionMedicamento, M.miligramosMedicamento, M.sustanciaActivaMedicamento, M.usoMedicamento, M.numeroMedicamento
    ORDER BY numeroVecesRecetado DESC;
END;

-- 6. Búsqueda de consultas por Fecha inicio/fin
DROP PROCEDURE IF EXISTS detalleConsultasPorFecha;
CREATE PROCEDURE detalleConsultasPorFecha(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT C.fechaConsulta, C.consultaID, P.pacienteID, CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombrePaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, fechaConsulta) AS edadPaciente, fechaNacimientoPaciente, C.pesoEnConsulta AS peso, C.estaturaEnConsulta AS estatura, CONCAT(nombreDoctor, ' ', apellidoDoctor) AS nombreDoctor, D.especialidadDoctor, peea, notaClinica, COUNT(DISTINCT cDE.enfermedadID) AS numeroEnfermedadesDiagnosticadas, COUNT(DISTINCT cRM.medicamentoID) AS numeroMedicamentosRecetados
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    JOIN doctor AS D ON C.doctorID = D.doctorID
    LEFT JOIN consultaDiagnosticaEnfermedad cDE on C.consultaID = cDE.consultaID
    LEFT JOIN consultaRecetaMedicamento cRM on C.consultaID = cRM.consultaID
    WHERE fechaConsulta BETWEEN fecha_inicio AND fecha_fin
    GROUP BY C.fechaConsulta, C.consultaID, P.pacienteID, nombrePaciente, edadPaciente, fechaNacimientoPaciente, peso, estatura, nombreDoctor, D.especialidadDoctor, peea, notaClinica
    ORDER BY fechaConsulta DESC;
END;


-- 7. Desplegar número de casos de cada enfermedad
DROP PROCEDURE IF EXISTS numeroCasosEnfermedades;
CREATE PROCEDURE numeroCasosEnfermedades()
BEGIN
    SELECT E.enfermedadID, E.ICD9CM, E.ICD10M, E.DSM5, COUNT(*) AS numeroCasos
    FROM enfermedad E
    JOIN consultaDiagnosticaEnfermedad CDE ON E.enfermedadID = CDE.enfermedadID
    GROUP BY E.enfermedadID, E.ICD9CM, E.ICD10M, E.DSM5
    ORDER BY numeroCasos DESC;
END;


-- 8. Desplegar número de casos de cada enfermedad por búsqueda
DROP PROCEDURE IF EXISTS numeroCasosEnfermedadesBusqueda;
CREATE PROCEDURE numeroCasosEnfermedadesBusqueda(IN e_DSM5 VARCHAR(500), IN e_codigo VARCHAR(10), IN e_ID INT)
BEGIN
    SELECT E.enfermedadID, IFNULL(E.ICD9CM, 'No definido') AS ICD9CM, IFNULL(E.ICD10M, 'No definido') AS ICD10CM, E.DSM5, IFNULL(COUNT(CDE.enfermedadID), 0) AS numeroCasos
    FROM enfermedad E
    LEFT JOIN consultaDiagnosticaEnfermedad CDE ON E.enfermedadID = CDE.enfermedadID
    WHERE CASE
        WHEN e_DSM5 = '' THEN e_codigo = E.ICD9CM OR e_codigo = E.ICD10M OR E.enfermedadID = e_ID
        ELSE E.DSM5 LIKE CONCAT('%', e_DSM5, '%') OR e_codigo = E.ICD9CM OR e_codigo = E.ICD10M OR E.enfermedadID = e_ID
    END
    GROUP BY E.enfermedadID, E.ICD9CM, E.ICD10M, E.DSM5
    ORDER BY numeroCasos DESC;
END;

-- 9. Desplegar todos los pacientes que han sufrido ceirta enfermedad por busqueda
DROP PROCEDURE IF EXISTS pacientesQueHanPadecidoEnfermedad;
CREATE PROCEDURE pacientesQueHanPadecidoEnfermedad(IN e_DSM5 VARCHAR(500), IN e_codigo VARCHAR(10), IN e_ID INT)
BEGIN
    SELECT E.enfermedadID, IFNULL(E.ICD9CM, 'No definido') AS ICD9CM, IFNULL(E.ICD10M, 'No definido') AS ICD10CM, E.DSM5, p.pacienteID, CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombrePaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, fechaConsulta) AS edadAlDiagnosticar, generoPaciente, c.fechaConsulta AS fechaDiagnostico
    FROM enfermedad E
    JOIN consultaDiagnosticaEnfermedad cDE on E.enfermedadID = cDE.enfermedadID
    JOIN consulta c on cDE.consultaID = c.consultaID
    JOIN paciente p on c.pacienteID = p.pacienteID
    WHERE CASE
        WHEN e_DSM5 = '' THEN e_codigo = E.ICD9CM OR e_codigo = E.ICD10M OR E.enfermedadID = e_ID
        ELSE E.DSM5 LIKE CONCAT('%', e_DSM5, '%') OR e_codigo = E.ICD9CM OR e_codigo = E.ICD10M OR E.enfermedadID = e_ID
    END;
END;

-- 10. Desplegar pacientes que no tienen seguro
DROP PROCEDURE IF EXISTS pacientesSinSeguro;
CREATE PROCEDURE pacientesSinSeguro()
BEGIN
    SELECT P.pacienteID, CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombrePaciente, fechaNacimientoPaciente, generoPaciente, telefonoPaciente, CONCAT(P.callePaciente, ', Col. ', P.coloniaPaciente, ', ', P.ciudadPaciente) AS direccionPaciente
    FROM paciente P
    LEFT JOIN seguroMedico S on P.pacienteID = S.pacienteID
    WHERE S.pacienteID IS NULL;
END;

-- 11. Desplegar pacientes que tienen cierto seguro
DROP PROCEDURE IF EXISTS pacientesPorSeguro;
CREATE PROCEDURE pacientesPorSeguro(IN compania VARCHAR(100))
BEGIN
    SELECT P.pacienteID, CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombrePaciente, fechaNacimientoPaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, current_date) AS edad, generoPaciente, telefonoPaciente, S.companiaSeguroMedico AS compania, S.numeroPoliza, S.vigenciaSeguroMedico, CONCAT(P.callePaciente, ', Col. ', P.coloniaPaciente, ', ', P.ciudadPaciente) AS direccionPaciente
    FROM paciente P
    JOIN seguroMedico S on P.pacienteID = S.pacienteID
    WHERE S.companiaSeguroMedico LIKE CONCAT('%', compania, '%');
END;

-- 12. Desplegar los pacientes por ciudad
DROP PROCEDURE IF EXISTS pacientesPorCiudad;
CREATE PROCEDURE pacientesPorCiudad(IN ciudad varchar(100))
BEGIN
    SELECT P.pacienteID, CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombrePaciente, fechaNacimientoPaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, current_date) AS edad, tipoSangrePaciente, CONCAT(P.callePaciente, ', Col. ', P.coloniaPaciente, ', ', P.ciudadPaciente) AS direccionPaciente, telefonoPaciente
    FROM paciente P
    WHERE ciudadPaciente LIKE CONCAT('%', ciudad, '%')
    ORDER BY direccionPaciente;
END;

-- 13. Desplegar los pacientes por edad
DROP PROCEDURE IF EXISTS pacientesPorEdad;
CREATE PROCEDURE pacientesPorEdad(IN edad int)
BEGIN
    SELECT P.pacienteID, CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombreDelPaciente, fechaNacimientoPaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, current_date) AS edad, tipoSangrePaciente, CONCAT(P.callePaciente, ', Col. ', P.coloniaPaciente, ', ', P.ciudadPaciente) AS direccionPaciente, telefonoPaciente
    FROM paciente P
    WHERE TIMESTAMPDIFF(year, fechaNacimientoPaciente, current_date) = edad
    ORDER BY fechaNacimientoPaciente DESC;
END;

-- 14. Desplegar los pacientes por tipo de sangre
DROP PROCEDURE IF EXISTS pacientesPorSangre;
CREATE PROCEDURE pacientesPorSangre(IN sangre varchar(10))
BEGIN
    SELECT P.pacienteID, CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombreDelPaciente, fechaNacimientoPaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, current_date) AS edad, tipoSangrePaciente, CONCAT(P.callePaciente, ', Col. ', P.coloniaPaciente, ', ', P.ciudadPaciente) AS direccionPaciente, telefonoPaciente
    FROM paciente P
    WHERE tipoSangrePaciente = sangre
    ORDER BY tipoSangrePaciente;
END;

-- Transaccion para borrar a un paciente
DROP PROCEDURE IF EXISTS deletePatient;
CREATE PROCEDURE deletePatient(IN p_name varchar(100), p_apellidoPaterno varchar(100), p_apellidoMaterno varchar(100), IN p_id int)
BEGIN
    SELECT @pacienteID := P.pacienteID AS pacienteID, CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombreDelPacienteABorrar
    FROM paciente P
    WHERE P.nombrePaciente = p_name AND P.apellidoPaternoPaciente = p_apellidoPaterno AND P.apellidoMaternoPaciente = p_apellidoMaterno AND P.pacienteID = p_id;
    START TRANSACTION;

    -- delete all diagnosics
    DELETE FROM consultaDiagnosticaEnfermedad
    WHERE consultaID IN (SELECT consultaID FROM consulta WHERE pacienteID = @pacienteID);

    -- delete all medication prescriptions
    DELETE FROM consultaRecetaMedicamento
    WHERE consultaID IN (SELECT consultaID FROM consulta WHERE pacienteID = @pacienteID);

    -- delete all visits to doctor
    DELETE FROM consulta
    WHERE pacienteID = @pacienteID;

    -- delete all insurance belonging to patient
    DELETE FROM seguroMedico
    WHERE pacienteID = @pacienteID;

    -- delete previous sickness
    DELETE FROM enfermedadPrevia
    WHERE historialID IN (SELECT historialID FROM historial WHERE pacienteID = @pacienteID);

    -- delete all antecedentes familiares
    DELETE FROM antecedenteFamiliar
    WHERE historialFamiliarID IN (SELECT historialID FROM historial WHERE pacienteID = @pacienteID) OR historialPacienteID IN (SELECT historialID FROM historial WHERE pacienteID = @pacienteID);

    -- delete all exam answers
    DELETE FROM respuesta
    WHERE instanciaID IN (SELECT instanciaID FROM instanciaExamen WHERE consultaID IN (SELECT consultaID FROM consulta WHERE pacienteID = @pacienteID));

    -- delete all exam instances
    DELETE FROM instanciaExamen
    WHERE consultaID IN (SELECT consultaID FROM consulta WHERE pacienteID = @pacienteID);

    -- delete historial
    DELETE FROM historial
    WHERE pacienteID = @pacienteID;

    -- delete patient
    DELETE FROM paciente
    WHERE pacienteID = @pacienteID;

    COMMIT;
END;