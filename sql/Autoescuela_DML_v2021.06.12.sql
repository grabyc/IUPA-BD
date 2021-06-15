#  Database Management System: MySQL/MariaDB
#  Diagram: EscuelaConductores
#  Author: Gabriel Raby
#  Date and time: 12/06/2021 18:57:29

USE AUTOESCUELA;

# UPDATING INFO

--
-- Agregar nuevo empleado con cargo de instructor junior (id=2)
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`, `es_supervisor`) VALUES (9, 'Carlos', 'Reutemann', '6548712', '03546822301', '2021-08-22', 1, 2, 3, 0);

--
-- Actualizar costo de todos los cursos un 25%
UPDATE TIPO_CURSO SET costo = costo * 1.25;

--
-- Actualizar el kilometraje del auto con patente 'AE501AB'
UPDATE AUTO SET kilometraje = kilometraje + 250 WHERE patente = 'AE501AB';

--
-- Eliminar los comentarios con más de un año de antigüedad
DELETE FROM COMENTARIO
WHERE id in (
	SELECT * FROM (
		SELECT c.id
		FROM COMENTARIO c
			INNER JOIN CLASE cl on cl.id = c.clase_id
		WHERE cl.horario_inicio <= DATE_ADD(CURDATE(), INTERVAL -1 YEAR)) as c
	);
