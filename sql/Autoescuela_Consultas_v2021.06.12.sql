use AUTOESCUELA;

--
-- 1) Dirección de todas las sucursales y nombre y teléfono del supervisor

SELECT 
	s.nombre as Sucursal, 
	s.domicilio as Domicilio, 
    c.nombre as Localidad,
    concat(e.apellido, ', ', e.nombre) as Supervisor,
    e.telefono as Telefono
FROM SUCURSAL s
	INNER JOIN CIUDAD c on s.ciudad_id = c.id
	INNER JOIN EMPLEADO e on s.id = e.sucursal_id
WHERE e.es_supervisor = 1;


--
-- 2) Detalle de los instructores cuyo carnet de conducir está próximo a vencerse 
--      (para este ejercicio, se toma "próximo" como "en menos de un año")

SELECT 
    concat(e.apellido, ', ', e.nombre) as Instructor,
    e.dni as DNI,
    e.telefono as Telefono,
    c.nombre as Cargo,
    s.nombre as Sucursal,
    e.fecha_caducidad_carnet as 'Fecha Caducidad Carnet',
    CASE WHEN e.fecha_caducidad_carnet < CURDATE() 
		THEN 'CADUCADO' 
        ELSE DATEDIFF(DATE_ADD(CURDATE(), INTERVAL 1 YEAR), e.fecha_caducidad_carnet) 
	END as 'Dias hasta caducar'
FROM EMPLEADO e
	INNER JOIN CARGO c on e.cargo_id = c.id
    INNER JOIN SUCURSAL s on e.sucursal_id = s.id
WHERE c.nombre LIKE '%Instructor%' AND
	e.fecha_caducidad_carnet <= DATE_ADD(CURDATE(), INTERVAL 1 YEAR);


--
-- 3) Contacto de los alumnos para llamarlos y recordarles el turno de su próxima clase 
--      (para este ejercicio, se llamará a los que tengan una clase dentro de los próximos 30 días)

SELECT 
	c.nombre as Cliente,
    c.telefono as Telefono,
    pc.prox_clase as 'Horario Próxima Clase'
FROM CLIENTE c
	INNER JOIN 
		(SELECT s.cliente_id, MIN(cl.horario_inicio) as prox_clase
		FROM SOLICITUD s 
			INNER JOIN CURSO cu on cu.id = s.curso_id
			INNER JOIN CLASE cl on cl.curso_id = cu.id
		WHERE cl.horario_inicio BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH)
		GROUP BY s.cliente_id
        ) pc on pc.cliente_id = c.id
ORDER BY c.id, pc.prox_clase;    

--
-- 4) Contacto de los alumnos para llamarlos y gestionar el cobro de curso solicitado 

SELECT 
	c.nombre as Cliente,
    c.telefono as Telefono,
    tc.nombre as 'Curso Pendiente',
    tc.costo as 'Costo Pendiente'
FROM CLIENTE c
	INNER JOIN SOLICITUD s on s.cliente_id = c.id
	INNER JOIN CURSO cu on cu.id = s.curso_id
    INNER JOIN TIPO_CURSO tc on tc.id = cu.tipo_curso_id
WHERE cu.esta_pagado = 0;    


--
-- 5) Cantidad de alumnos que reprobaron los exámenes de manejo en el último mes 

SELECT 
	count(*) as 'Cantidad Desaprobados'
FROM CLIENTE c
	INNER JOIN SOLICITUD s on s.cliente_id = c.id
	INNER JOIN CURSO cu on cu.id = s.curso_id
	INNER JOIN EXAMEN e on e.curso_id = cu.id
WHERE e.esta_aprobado = 0 AND
	e.horario BETWEEN DATE_ADD(CURDATE(), INTERVAL -1 MONTH) AND CURDATE();

--
-- 6) Disponibilidad de autos la semana próxima 
--      (para este ejercicio, se considera que un auto está disponible cuando tiene entre 1 y 10 horas disponibles dentro de la semana)

SELECT 
	a.nombre as Auto,
    a.patente as Patente,
    s.nombre as Sucursal,
    CASE WHEN h.horas IS NULL THEN 10 ELSE 10 - h.horas END as 'Horas Disponibles'
FROM AUTO a
	INNER JOIN SUCURSAL s on s.id = a.sucursal_id
	LEFT JOIN (
		SELECT c.auto_id, SUM(Hour(TIMEDIFF(c.horario_fin, c.horario_inicio))) as horas
		FROM CLASE c
		WHERE c.horario_inicio BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 WEEK)
		GROUP BY c.auto_id
		HAVING SUM(Hour(TIMEDIFF(c.horario_fin, c.horario_inicio))) <= 10) h on a.id = h.auto_id;

--
-- 7) Ingresos en concepto de clases sueltas por sucursal en el último año 

SELECT SUM(tc.costo) as 'Ingresos Clases Sueltas'
FROM CURSO c
	INNER JOIN TIPO_CURSO tc on tc.id = c.tipo_curso_id
WHERE c.esta_pagado = 1 AND 
	c.tipo_curso_id = 1 AND
    c.fecha_inicio BETWEEN DATE_ADD(CURDATE(), INTERVAL -1 YEAR) AND CURDATE();
    

--
-- 8) Reporte de instructores indicando para el último trimestre, la cantidad de clases dadas y puntaje obtenido

SELECT 
	    concat(e.apellido, ', ', e.nombre) as Instructor,
        ca.nombre as Cargo,
        CASE WHEN cl.clases is null THEN 0 ELSE cl.clases END as 'Cantidad Clases',
        CASE WHEN cl.promedio is null THEN 0 ELSE cl.promedio END as 'Puntaje Promedio'
FROM EMPLEADO e
	INNER JOIN CARGO ca on ca.id = e.cargo_id
    LEFT JOIN
		(SELECT cu.empleado_id, count(c.id) clases, round(avg(com.puntaje),2) as promedio
		FROM CLASE c
			INNER JOIN CURSO cu on cu.id = c.curso_id
			LEFT JOIN COMENTARIO com on com.clase_id = c.id
		WHERE c.horario_inicio BETWEEN DATE_ADD(CURDATE(), INTERVAL -3 MONTH) AND CURDATE()
		GROUP BY cu.empleado_id) cl on e.id = cl.empleado_id
WHERE ca.nombre LIKE '%Instructor%'
ORDER BY 3 desc,4 desc;

--
-- 9) Reporte de los vehículos indicando patente, titular, kilometraje, y sucursal donde se encuentra

SELECT 
	a.nombre as Auto,
    a.patente as Patente,
    a.titular as Titular,
    a.kilometraje as Kms,
    s.nombre as Sucursal,
    c.nombre as Ciudad
FROM AUTO a
	INNER JOIN SUCURSAL s on s.id = a.sucursal_id
    INNER JOIN CIUDAD c on c.id = s.ciudad_id;
    
--
-- 10) Agenda de clases de la próxima semana con instructor, auto y cliente

SELECT 
	c.id as 'Código Clase',
    c.horario_inicio as Horario,
    time_format(timediff(c.horario_fin, c.horario_inicio), "%H %i") as Duracion,
	concat(e.apellido, ', ', e.nombre) as Instructor,
	e.telefono as 'Teléfono Instructor',
    a.nombre as Auto,
    a.patente as Patente,
    cl.nombre as Cliente,
    cl.telefono as 'Teléfono Cliente'
FROM CLASE c
	INNER JOIN CURSO cu on cu.id = c.curso_id
    INNER JOIN EMPLEADO e on e.id = cu.empleado_id
    INNER JOIN AUTO a on a.id = c.auto_id
    INNER JOIN SOLICITUD s on s.curso_id = cu.id
    INNER JOIN CLIENTE cl on cl.id = s.cliente_id
WHERE c.horario_inicio between CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 10 WEEK)
ORDER BY c.horario_inicio;
