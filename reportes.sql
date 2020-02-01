DROP procedure IF EXISTS numeroConsultasPaciente;
DROP procedure IF EXISTS numeroConsultasPacientePorNombre;
DROP procedure IF EXISTS numeroVecesMedicamentoRecetado;
DROP PROCEDURE IF EXISTS detalleConsultasPorFecha;
DROP PROCEDURE IF EXISTS antecedentesFamiliares;


DROP PROCEDURE IF EXISTS numeroCasosEnfermedades;
DROP PROCEDURE IF EXISTS numeroCasosEnfermedadesBusqueda;


-- 1. ExpedientePaciente

-- Datos Generales
DROP PROCEDURE IF EXISTS datosGeneralesPaciente;
CREATE PROCEDURE datosGeneralesPaciente(IN p_nombre VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT P.pacienteID AS ID, CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) AS nombrePaciente, TIMESTAMPDIFF(year, P.fechaNacimientoPaciente, CURDATE()) AS edadPaciente, P.generoPaciente, P.tipoSangrePaciente, CONCAT(P.callePaciente, ', Col. ', P.coloniaPaciente, ', ', P.ciudadPaciente) AS direccionPaciente, P.telefonoPaciente,
           CASE WHEN H.fumador = '0' THEN 'No' ELSE 'Si' END AS fumador,
           CASE WHEN H.tomador = '0' THEN 'No' ELSE 'Si' END AS tomador,
           H.horasSuenio, H.calidadSuenio, H.horasEjercicio, IFNULL(H.fechaUltimaConsulta, 'No registrado') AS fechaUltimaConsulta, H.fechaUltimaActualizacion
    FROM paciente AS P
    JOIN historial H on P.pacienteID = H.pacienteID
    WHERE CASE
        WHEN p_nombre = '' THEN P.pacienteID = p_ID
        ELSE CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) LIKE CONCAT('%', p_nombre, '%') OR P.pacienteID = p_ID
        END;
END;

-- Detalle de consultas
DROP PROCEDURE IF EXISTS detalleConsultasPaciente;
CREATE PROCEDURE detalleConsultasPaciente(IN p_nombre VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT C.consultaID, C.fechaConsulta, TIMESTAMPDIFF(year, fechaNacimientoPaciente, fechaConsulta) AS edadPaciente, CONCAT(nombreDoctor, ' ', apellidoDoctor) AS nombreDoctor, peea, notaClinica, e.enfermedadID, e.DSM5 AS enfermedadDiagnosticada, m.medicamentoID, m.nombreMedicamento, cRM.fechaInicioReceta, cRM.fechaFinReceta, CONCAT(sM.companiaSeguroMedico, ' Poliza: ',sM.numeroPoliza) AS aseguradora
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    JOIN doctor AS D ON C.doctorID = D.doctorID
    LEFT JOIN seguroMedico sM on C.numeroPoliza = sM.numeroPoliza
    LEFT JOIN consultaDiagnosticaEnfermedad cDE on C.consultaID = cDE.consultaID
    LEFT JOIN enfermedad e on cDE.enfermedadID = e.enfermedadID
    LEFT JOIN consultaRecetaMedicamento cRM on C.consultaID = cRM.consultaID
    LEFT JOIN medicamento m on cRM.medicamentoID = m.medicamentoID
    WHERE CASE
        WHEN p_nombre = '' THEN P.pacienteID = p_ID
        ELSE CONCAT(P.nombrePaciente, ' ', P.apellidoPaternoPaciente, ' ', P.apellidoMaternoPaciente) LIKE CONCAT('%', p_nombre, '%') OR P.pacienteID = p_ID
        END;
end;


-- 1. Nombre Paciente, NumConsultas

-- todos
CREATE PROCEDURE numeroConsultasPaciente()
BEGIN
    SELECT CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombrePaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, CURDATE()) AS edadPaciente, COUNT(consultaID) AS numeroConsultas
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    GROUP BY nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, CURDATE());
END;

-- pidiendo nombres
CREATE PROCEDURE numeroConsultasPacientePorNombre(IN p_nombre VARCHAR(100), IN p_apellidoPaterno VARCHAR(100), IN p_apellidoMaterno VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombrePaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, CURDATE()) AS edadPaciente, COUNT(consultaID) AS numConsultas
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    WHERE (P.apellidoPaternoPaciente = p_apellidoPaterno AND P.apellidoMaternoPaciente = p_apellidoMaterno AND P.nombrePaciente = p_nombre) OR P.pacienteID = p_ID
    GROUP BY nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, CURDATE());
END;

-- 2. Nombre Medicamento, Num Veces Recetado de mayor a menor

-- todos
CREATE PROCEDURE numeroVecesMedicamentoRecetado()
BEGIN
    SELECT M.medicamentoID AS ID, M.nombreMedicamento AS nombre, M.presentacionMedicamento AS presentacion, M.miligramosMedicamento AS miligramos, M.sustanciaActivaMedicamento AS sustanciaActiva, IFNULL(M.usoMedicamento, 'No registrado') AS uso, M.numeroMedicamento AS numero, COUNT(*) AS numeroVecesRecetado
    FROM medicamento AS M
    JOIN consultaRecetaMedicamento AS CRM ON M.medicamentoID = CRM.medicamentoID
    GROUP BY M.medicamentoID ,M.nombreMedicamento, M.presentacionMedicamento, M.miligramosMedicamento, M.sustanciaActivaMedicamento, M.usoMedicamento, M.numeroMedicamento
    ORDER BY numeroVecesRecetado DESC;
END;



-- 4. Fecha inicio/fin Detalle paciente, nombre paciente, address, birthdate, todo lo del punto 4
CREATE PROCEDURE detalleConsultasPorFecha(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT fechaConsulta, CONCAT(nombrePaciente, ' ', apellidoPaternoPaciente, ' ', apellidoMaternoPaciente) AS nombrePaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, fechaConsulta) AS edadPaciente, fechaNacimientoPaciente, CONCAT(nombreDoctor, ' ', apellidoDoctor) AS nombreDoctor, peea, notaClinica
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    JOIN doctor AS D ON C.doctorID = D.doctorID
    WHERE fechaConsulta BETWEEN fecha_inicio AND fecha_fin;
END;

-- 5. Antecedentes familiares
CREATE PROCEDURE antecedentesFamiliares(IN p_nombre VARCHAR(100), IN p_apellidoPaterno VARCHAR(100), IN p_apellidoMaterno VARCHAR(100), IN p_ID INT)
BEGIN
    SELECT CONCAT(F.nombrePaciente, ' ', F.apellidoPaternoPaciente, ' ', F.apellidoMaternoPaciente) AS nombreFamiliar, AF.parentesco AS parentesco, IEPF.DSM5 AS enfermedad, EPF.fechaEnfermedad, TIMESTAMPDIFF(year, F.fechaNacimientoPaciente, EPF.fechaEnfermedad) AS edadAlPadecer, EPF.tratamientoEnfermedadPrevia AS tratamientoRecibido
    FROM paciente AS P
    JOIN historial AS HP ON P.pacienteID = HP.pacienteID
    JOIN antecedenteFamiliar AS AF ON HP.historialID = AF.historialPacienteID
    JOIN historial AS HF ON AF.historialFamiliarID = HF.historialID
    JOIN paciente AS F ON HF.pacienteID = F.pacienteID
    JOIN enfermedadPrevia AS EPF ON HF.historialID = EPF.historialID
    JOIN enfermedad AS IEPF ON EPF.enfermedadPreviaID = IEPF.enfermedadID
    WHERE (P.apellidoPaternoPaciente = p_apellidoPaterno AND P.apellidoMaternoPaciente = p_apellidoMaterno AND P.nombrePaciente = p_nombre) OR P.pacienteID = p_ID;
END;


CREATE PROCEDURE numeroCasosEnfermedades()
BEGIN
    SELECT E.enfermedadID, E.ICD9CM, E.ICD10M, E.DSM5, COUNT(*) AS numeroCasos
    FROM enfermedad E
    JOIN consultaDiagnosticaEnfermedad CDE ON E.enfermedadID = CDE.enfermedadID
    GROUP BY E.enfermedadID, E.ICD9CM, E.ICD10M, E.DSM5;
END;

CREATE PROCEDURE numeroCasosEnfermedadesBusqueda(IN e_DSM5 VARCHAR(500), IN e_ID INT)
BEGIN
    SELECT E.enfermedadID, E.ICD9CM, E.ICD10M, E.DSM5, IFNULL(COUNT(CDE.enfermedadID), 0) AS numeroCasos
    FROM enfermedad E
    LEFT JOIN consultaDiagnosticaEnfermedad CDE ON E.enfermedadID = CDE.enfermedadID
    WHERE E.DSM5 LIKE CONCAT('%', e_DSM5, '%') OR E.enfermedadID = e_ID
    GROUP BY E.enfermedadID, E.ICD9CM, E.ICD10M, E.DSM5
    ORDER BY COUNT(CDE.enfermedadID) DESC;
END;


