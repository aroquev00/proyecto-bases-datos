DELETE FROM respuesta;
DELETE FROM pregunta;
DELETE FROM instanciaExamen;
DELETE FROM examen;

-- agregar los exámenes

INSERT INTO examen VALUES
(1, 'Examen Depresion', '2019-01-01'),
(2, 'Examen Ansiedad', '2019-01-01');

 -- agregar preguntas de los exámenes

 INSERT INTO pregunta VALUES

 -- primer examen (Depresión)

 ('1A','1','1','Sentimientos de culpa', NULL),
 ('1B','2','1',  'Suicidio', NULL),
 ('1C','3','1',  'Insomnio precoz', NULL),
 ('1D', '4','1', 'Insomnio intermedio',NULL),
 ('1E','5','1', 'Insomnio tardio', NULL),
 ('1F', '6','1', 'Trabajo y actividades', NULL),
 ('1G', '7','1', 'Inhibicion psicomotora','Lentitud de pensamiento y lenguaje, facultad de concentración disminuida, disminución de la actividad motora'),
 ('1H','8','1', 'Agitacion psicomotra', NULL),
 ('1I','9','1', 'Ansiedad psiquica', NULL),
 ('1J','10','1', 'Ansiedad somatica','signos físicos de ansiedad: gastrointestinales:
 sequedad de boca, diarrea, eructos, indigestión, etc; cardiovasculares: palpitaciones,
 cefaleas; respiratorios: hiperventilación, suspiros; frecuencia de micción incrementada; transpiración'),
 ('1K','11','1', 'Sintomas somaticos gastroinstestinales', NULL),
 ('1L', '12','1', 'Sintomas somaticos generales', NULL),
 ('1M','13','1', 'Sintomas genitales' , 'tales como: disminución de la libido y trastornos menstruales'),
 ('1N','14','1',  'Hipocondria', NULL),
 ('1O','15','1', 'Perdida de peso', NULL),
 ('1P','16','1', 'Introspeccion', 'insight'),

 -- segundo examen (Ansiedad)

 ('2A', '1','2','Estado de animo ansioso','Preocupaciones, anticipacion de lo peor, aprension (anticipacion temerosa), irritabilidad'),
 ('2B','2','2','Tension','Sensación de tensión, imposibilidad de relajarse, reacciones con sobresalto, llanto fácil, temblores, sensación de inquietud'),
 ('2C','3','2','Temores','A la oscuridad, a los desconocidos, a quedarse solo, a los animales grandes, al tráfico, a las multitudes.'),
 ('2D','4','2','Insomnio','Dificultad para dormirse, sueño interrumpido, sueño insatisfactorio y cansancio al despertar.'),
 ('2E','5','2','Cognitivo','Dificultad para concentrarse, mala memoria.'),
 ('2F','6','2','Estado de ánimo deprimido','Pérdida de interés, insatisfacción en las diversiones, depresión, despertar prematuro, cambios de humor durante el día.'),
 ('2G','7','2','Síntomas somáticos generales (musculares)','Dolores y molestias musculares, rigidez muscular, contracciones musculares, sacudidas clónicas, crujir de
 dientes, voz temblorosa.'),
 ('2H','8','2','Síntomas somáticos generales (sensoriales)','Zumbidos de oídos, visión borrosa, sofocos y escalofríos, sensación de debilidad, sensación de hormigueo.'),
 ('2I','9','2','Síntomas cardiovasculares','Taquicardia, palpitaciones, dolor en el pecho, latidos vasculares, sensación de desmayo, extrasístole.'),
 ('2J','10','2','Síntomas respiratorios','Opresión o constricción en el pecho, sensación de ahogo, suspiros, disnea.'),
 ('2K','11','2','Síntomas gastrointestinales','Dificultad para tragar, gases, dispepsia: dolor antes y después de comer, sensación de ardor, sensación de estómago lleno,
 vómitos acuosos, vómitos, sensación de estómago vacío, digestión lenta, borborigmos (ruido intestinal), diarrea, pérdida de peso, estreñimiento.'),
 ('2L','12','2','Síntomas genitourinarios','Micción frecuente, micción urgente, amenorrea, menorragia, aparición de la frigidez, eyaculación precoz,
ausencia de erección, impotencia'),
 ('2M','13','2','Síntomas autónomos.','Boca seca, rubor, palidez, tendencia a sudar, vértigos, cefaleas de tensión, piloerección (pelos de punta)'),
 ('2N','14','2','Comportamiento en la entrevista (general y fisiológico)','Tenso, no relajado, agitación nerviosa: manos, dedos cogidos, apretados, tics, enrollar un pañuelo; inquietud; pasearse de un lado a otro, temblor de manos, ceño
fruncido, cara tirante, aumento del tono muscular, suspiros, palidez facial. Tragar saliva, eructar, taquicardia de reposo, frecuencia respiratoria por encima de 20 res/min, sacudidas
enérgicas de tendones, temblor, pupilas dilatadas,exoftalmos (proyección anormal del globo del ojo), sudor,tics en los párpados.');

-- agregar instancia de exámenes

INSERT INTO instanciaExamen VALUES
(100,1,1,'2019-01-27'),
(102,2,6,'2020-02-27'),
(104,1,11,'2019-01-03'),
(105,2,12,'2019-03-23'),
(106,2,16,'2019-01-17'),
(107,1,17,'2019-04-02');

-- agregar respuestas de dos instancias (104 y 105) faltan las otras

INSERT INTO respuesta VALUES

-- Respuestas Erick

(401,'1A',104 ,2),
(402,'1B',104 ,2),
(403,'1C',104 ,2),
(404,'1D',104 ,2),
(405,'1E',104 ,2),
(406,'1F',104 ,2),
(407,'1G',104 ,2),
(408,'1H',104 ,2),
(409,'1I',104 ,2),
(410,'1J',104 ,2),
(411,'1K',104 ,2),
(412,'1L',104 ,2),
(413,'1M',104 ,2),
(414,'1N',104 ,2),
(415,'1O',104 ,2),
(416,'1P',104 ,2),

(417,'2A',105 ,2),
(418,'2B',105 ,2),
(419,'2C',105 ,2),
(420,'2D',105 ,2),
(421,'2E',105 ,2),
(422,'2F',105 ,2),
(423,'2G',105 ,2),
(424,'2H',105 ,2),
(425,'2I',105 ,2),
(426,'2J',105 ,2),
(427,'2K',105 ,2),
(428,'2L',105 ,2),
(429,'2M',105 ,2),
(430,'2N',105 ,2),

-- Respuestas Armando

(431,'1A',100 ,3),
(432,'1B',100 ,2),
(433,'1C',100 ,2),
(434,'1D',100 ,3),
(435,'1E',100 ,0),
(436,'1F',100 ,1),
(437,'1G',100 ,1),
(438,'1H',100 ,4),
(439,'1I',100 ,2),
(440,'1J',100 ,1),
(441,'1K',100 ,2),
(442,'1L',100 ,1),
(443,'1M',100 ,0),
(444,'1N',100 ,3),
(445,'1O',100 ,4),
(446,'1P',100 ,4),

-- Respuestas Emilio

(447,'2A',102 ,1),
(448,'2B',102 ,2),
(449,'2C',102 ,0),
(450,'2D',102 ,3),
(451,'2E',102 ,2),
(452,'2F',102 ,2),
(453,'2G',102 ,2),
(454,'2H',102 ,3),
(455,'2I',102 ,3),
(456,'2J',102 ,1),
(457,'2K',102 ,3),
(458,'2L',102 ,4),
(459,'2M',102 ,3),
(460,'2N',102 ,0),

-- Respuestas Nestor

(461,'2A',106 ,4),
(462,'2B',106 ,1),
(463,'2C',106 ,0),
(464,'2D',106 ,3),
(465,'2E',106 ,2),
(466,'2F',106 ,0),
(467,'2G',106 ,1),
(468,'2H',106 ,3),
(469,'2I',106 ,0),
(470,'2J',106 ,2),
(471,'2K',106 ,2),
(472,'2L',106 ,4),
(473,'2M',106 ,2),
(474,'2N',106 ,1),

(475,'1A',107 ,2),
(476,'1B',107 ,1),
(477,'1C',107 ,2),
(478,'1D',107 ,3),
(479,'1E',107 ,2),
(480,'1F',107 ,4),
(481,'1G',107 ,0),
(482,'1H',107 ,1),
(483,'1I',107 ,3),
(484,'1J',107 ,2),
(485,'1K',107 ,2),
(486,'1L',107 ,0),
(487,'1M',107 ,1),
(488,'1N',107 ,4),
(489,'1O',107 ,2),
(490,'1P',107 ,3);
