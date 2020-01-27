-- 1. Nombre Paciente, NumConsultas
SELECT nombrePaciente, COUNT(consultaID) AS numConsultas
FROM paciente AS P
JOIN consulta AS C ON P.pacienteID = C.consultaID

-- 2. Nombre Medicamento, Num Veces Recetado de mayor a menor
SELECT nombreMedicamento

-- 3. Detalle de consultas de un paciente, como stored procedure
-- Datos: fecha consulta, edad paciente, doctor, peea, nota clínica
-- 4. Fecha inicio/fin Detalle paciente, nombre paciente, address, birthdate, todo lo del punto 4