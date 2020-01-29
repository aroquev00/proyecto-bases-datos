-- 1. Nombre Paciente, NumConsultas
create procedure numeroConsultasPaciente(IN p_nombre varchar(100), IN p_apellidoPaterno varchar(100), IN p_apellidoMaterno varchar(100))
begin
    SELECT nombrePaciente, COUNT(consultaID) AS numConsultas
    FROM paciente AS P
    JOIN consulta AS C ON P.pacienteID = C.pacienteID
    where P.apellidoPaternoPaciente = p_apellidoPaterno AND P.apellidoMaternoPaciente = p_apellidoMaterno AND P.nombrePaciente = p_nombre
    GROUP BY nombrePaciente;
end;

-- 2. Nombre Medicamento, Num Veces Recetado de mayor a menor
SELECT nombreMedicamento, COUNT(*)
FROM medicamento AS M
JOIN consultaRecetaMedicamento AS CRM ON M.medicamentoID = CRM.medicamentoID
GROUP BY nombreMedicamento;

-- 3. Detalle de consultas de un paciente, como stored procedure
-- Datos: fecha consulta, edad paciente, doctor, peea, nota clínica
-- 4. Fecha inicio/fin Detalle paciente, nombre paciente, address, birthdate, todo lo del punto 4