DROP procedure IF EXISTS numeroConsultasPaciente;
DROP procedure IF EXISTS numeroConsultasPacientePorNombre;
DROP procedure IF EXISTS numeroVecesMedicamentoRecetado;
DROP procedure IF EXISTS detalleConsultasPacientePorNombre;

-- 1. Nombre Paciente, NumConsultas

-- todos
CREATE PROCEDURE numeroConsultasPaciente()
BEGIN
    SELECT nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente, COUNT(consultaID) AS numeroConsultas
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    GROUP BY nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente;
END;

-- pidiendo nombres
CREATE PROCEDURE numeroConsultasPacientePorNombre(IN p_nombre VARCHAR(100), IN p_apellidoPaterno VARCHAR(100), IN p_apellidoMaterno VARCHAR(100))
BEGIN
    SELECT nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente, COUNT(consultaID) AS numConsultas
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    where P.apellidoPaternoPaciente = p_apellidoPaterno AND P.apellidoMaternoPaciente = p_apellidoMaterno AND P.nombrePaciente = p_nombre
    GROUP BY nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente;
END;

-- 2. Nombre Medicamento, Num Veces Recetado de mayor a menor

-- todos
CREATE PROCEDURE numeroVecesMedicamentoRecetado()
BEGIN
    SELECT nombreMedicamento, presentacionMedicamento, COUNT(*) AS numeroVecesRecetado
    FROM medicamento AS M
    JOIN consultaRecetaMedicamento AS CRM ON M.medicamentoID = CRM.medicamentoID
    GROUP BY nombre, presentacion
    ORDER BY numeroVecesRecetado DESC;
END;



-- 3. Detalle de consultas de un paciente, como stored procedure
-- Datos: fecha consulta, edad paciente, doctor, peea, nota clínica
CREATE PROCEDURE detalleConsultasPacientePorNombre(IN p_nombre VARCHAR(100), IN p_apellidoPaterno VARCHAR(100), IN p_apellidoMaterno VARCHAR(100))
BEGIN
    SELECT fechaConsulta, TIMESTAMPDIFF(year, fechaNacimientoPaciente, fechaConsulta) AS edadPaciente, nombreDoctor, peea, notaClinica
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    JOIN doctor AS D ON C.doctorID = D.doctorID
    WHERE P.apellidoPaternoPaciente = p_apellidoPaterno AND P.apellidoMaternoPaciente = p_apellidoMaterno AND P.nombrePaciente = p_nombre;
END;


-- 4. Fecha inicio/fin Detalle paciente, nombre paciente, address, birthdate, todo lo del punto 4
CREATE PROCEDURE detalleConsultasPorFecha(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT fechaConsulta,nombrePaciente, apellidoPaternoPaciente, apellidoMaternoPaciente, TIMESTAMPDIFF(year, fechaNacimientoPaciente, fechaConsulta) AS edadPaciente, fechaNacimientoPaciente, nombreDoctor, peea, notaClinica
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    JOIN doctor AS D ON C.doctorID = D.doctorID
    WHERE fechaConsulta BETWEEN fecha_inicio AND fecha_fin;
END;