DROP procedure IF EXISTS numeroConsultasPaciente;
DROP procedure IF EXISTS numeroConsultasPacientePorNombre;
DROP procedure IF EXISTS numeroVecesMedicamentoRecetado;

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
    SELECT nombrePaciente, COUNT(consultaID) AS numConsultas
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    where P.apellidoPaternoPaciente = p_apellidoPaterno AND P.apellidoMaternoPaciente = p_apellidoMaterno AND P.nombrePaciente = p_nombre
    GROUP BY nombrePaciente;
END;

-- 2. Nombre Medicamento, Num Veces Recetado de mayor a menor

-- todos
CREATE PROCEDURE numeroVecesMedicamentoRecetado()
BEGIN
    SELECT nombre, presentacion, COUNT(*)
    FROM medicamento AS M
    JOIN consultaRecetaMedicamento AS CRM ON M.medicamentoID = CRM.medicamentoID
    GROUP BY nombre, presentacion;
END;



-- 3. Detalle de consultas de un paciente, como stored procedure
-- Datos: fecha consulta, edad paciente, doctor, peea, nota clínica
-- 4. Fecha inicio/fin Detalle paciente, nombre paciente, address, birthdate, todo lo del punto 4