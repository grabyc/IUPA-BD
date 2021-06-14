#  Created with Kata Kuntur - Data Modeller
#  Version: 2.5.4
#  Web Site: http://katakuntur.jeanmazuelos.com/

#  Database Management System: MySQL/MariaDB
#  Diagram: EscuelaConductores
#  Author: Gabriel Raby
#  Date and time: 12/06/2021 18:57:29

DROP SCHEMA IF EXISTS AUTOESCUELA;

CREATE SCHEMA AUTOESCUELA;
USE AUTOESCUELA;

# GENERATING TABLES
CREATE TABLE `SUCURSAL` (
	`id` INTEGER NOT NULL,
	`nombre` VARCHAR(100) NOT NULL,
	`domicilio` VARCHAR(500) DEFAULT NULL,
	`ciudad_id` INTEGER NOT NULL,
	KEY(`ciudad_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `EMPLEADO` (
	`id` INTEGER NOT NULL,
	`nombre` VARCHAR(100) NOT NULL,
	`apellido` VARCHAR(100) NOT NULL,
	`dni` VARCHAR(10) NOT NULL,
	`telefono` VARCHAR(14) NOT NULL,
	`fecha_caducidad_carnet` DATE DEFAULT NULL,
	`pais_id` INTEGER NOT NULL,
	KEY(`pais_id`),
	`cargo_id` INTEGER NOT NULL,
	KEY(`cargo_id`),
	`sucursal_id` INTEGER NOT NULL,
	KEY(`sucursal_id`),
    `es_supervisor` BIT NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `CIUDAD` (
	`id` INTEGER NOT NULL,
	`nombre` VARCHAR(100) NOT NULL,
	`provincia_id` INTEGER NOT NULL,
	KEY(`provincia_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `PROVINCIA` (
	`id` INTEGER NOT NULL,
	`nombre` VARCHAR(100) NOT NULL,
	`pais_id` INTEGER NOT NULL,
	KEY(`pais_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `PAIS` (
	`id` INTEGER NOT NULL,
	`nombre` VARCHAR(100) NOT NULL,
	`nacionalidad` VARCHAR(100) NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `CARGO` (
	`id` INTEGER NOT NULL,
	`nombre` VARCHAR(100) NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `CLIENTE` (
	`id` INTEGER NOT NULL,
	`nombre` VARCHAR(100) NOT NULL,
	`telefono` VARCHAR(14) NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `SOLICITUD` (
	`id` INTEGER NOT NULL,
	`fecha` DATE NOT NULL,
	`sucursal_id` INTEGER NOT NULL,
	KEY(`sucursal_id`),
	`cliente_id` INTEGER NOT NULL,
	KEY(`cliente_id`),
	`curso_id` INTEGER NOT NULL,
	KEY(`curso_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `CURSO` (
	`id` INTEGER NOT NULL,
	`fecha_inicio` DATE NOT NULL,
	`esta_pagado` BIT NOT NULL,
	`esta_aprobado` BIT DEFAULT NULL,
	`empleado_id` INTEGER NOT NULL,
	KEY(`empleado_id`),
	`tipo_curso_id` INTEGER NOT NULL,
	KEY(`tipo_curso_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `TIPO_CURSO` (
	`id` INTEGER NOT NULL,
	`nombre` VARCHAR(100) NOT NULL,
	`cantidad_clases` TINYINT NOT NULL,
	`habilita_examen` BIT NOT NULL,
	`cantidad_intentos_examen` TINYINT NOT NULL,
	`costo` DECIMAL(10,2) NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `CLASE` (
	`id` INTEGER NOT NULL,
	`horario_inicio` DATETIME NOT NULL,
	`horario_fin` DATETIME NOT NULL,
	`curso_id` INTEGER NOT NULL,
	KEY(`curso_id`),
	`AUTO_id` INTEGER NOT NULL,
	KEY(`AUTO_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `AUTO` (
	`id` INTEGER NOT NULL,
	`nombre` VARCHAR(50) NOT NULL,
	`patente` VARCHAR(10) NOT NULL,
	`titular` VARCHAR(100) NOT NULL,
	`kilometraje` BIGINT NOT NULL,
	`sucursal_id` INTEGER NOT NULL,
	KEY(`sucursal_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `EXAMEN` (
	`id` INTEGER NOT NULL,
	`horario` DATETIME NOT NULL,
	`nro_intento` TINYINT NOT NULL,
	`esta_aprobado` BIT NOT NULL,
	`motivo_desaprobado` VARCHAR(500) DEFAULT NULL,
	`puntaje` TINYINT NOT NULL,
	`curso_id` INTEGER NOT NULL,
	KEY(`curso_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `COMENTARIO` (
	`id` INTEGER NOT NULL,
	`puntaje` TINYINT NOT NULL,
	`comentario` VARCHAR(500) DEFAULT NULL,
	`clase_id` INTEGER NOT NULL,
	KEY(`clase_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

# POPULATING TABLES

--
-- Volcado de datos para la tabla `SUCURSAL`

INSERT INTO `SUCURSAL`(`id`, `nombre`, `domicilio`, `ciudad_id`) VALUES (1, 'Sucursal Neuquén', 'San Martín 434', 1);
INSERT INTO `SUCURSAL`(`id`, `nombre`, `domicilio`, `ciudad_id`) VALUES (2, 'Sucursal Cipolletti', 'Tres Arroyos 950', 2);
INSERT INTO `SUCURSAL`(`id`, `nombre`, `domicilio`, `ciudad_id`) VALUES (3, 'Sucursal Comodoro Rivadavia', 'Buenos Aires 335', 3);

--
-- Volcado de datos para la tabla `EMPLEADO`

INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`, `es_supervisor`) VALUES (1, 'Chano', 'Carpentier', '28578425', '01147896524', '2023-10-15', 1, 1, 1, 1);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`, `es_supervisor`) VALUES (2, 'Manu', 'Urcera', '30578963', '02994854878', '2022-04-05', 1, 2, 1, 0);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`, `es_supervisor`) VALUES (3, 'Juana', 'Viale', '29565100', '01152346281', null, 1, 3, 1, 0);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`, `es_supervisor`) VALUES (4, 'Juan Maria', 'Traverso', '12546102', '01155574812', '2021-05-15', 1, 1, 2, 1);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`, `es_supervisor`) VALUES (5, 'Nicolás', 'Maduro', '92464712', '02996822301', '2022-09-05', 2, 2, 2, 0);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`, `es_supervisor`) VALUES (6, 'Arabela', 'Carreras', '20189758', '02995234144', null, 1, 3, 2, 0);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`, `es_supervisor`) VALUES (7, 'Pastor', 'Maldonado', '92556130', '+589212232054', '2023-05-15', 2, 1, 3, 1);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`, `es_supervisor`) VALUES (8, 'Cristobal', 'Lopez', '11547268', '02916822301', null, 3, 3, 3, 0);

--
-- Volcado de datos para la tabla `CIUDAD`

INSERT INTO `CIUDAD` (`id`, `nombre`, `provincia_id`) VALUES (1, 'Neuquén', 1);
INSERT INTO `CIUDAD` (`id`, `nombre`, `provincia_id`) VALUES (2, 'Cipolletti', 2);
INSERT INTO `CIUDAD` (`id`, `nombre`, `provincia_id`) VALUES (3, 'Comodoro Rivadavia', 3);

--
-- Volcado de datos para la tabla `PROVINCIA`

INSERT INTO `PROVINCIA` (`id`, `nombre`, `pais_id`) VALUES (1, 'Neuquén', 1);
INSERT INTO `PROVINCIA` (`id`, `nombre`, `pais_id`) VALUES (2, 'Río Negro', 1);
INSERT INTO `PROVINCIA` (`id`, `nombre`, `pais_id`) VALUES (3, 'Chubut', 1);

--
-- Volcado de datos para la tabla `PAIS`

INSERT INTO `PAIS` (`id`, `nombre`, `nacionalidad`) VALUES (1, 'Argentina', 'Argentina');
INSERT INTO `PAIS` (`id`, `nombre`, `nacionalidad`) VALUES (2, 'Venezuela', 'Venezolana');
INSERT INTO `PAIS` (`id`, `nombre`, `nacionalidad`) VALUES (3, 'Chile', 'Chilena');

--
-- Volcado de datos para la tabla `CARGO`

INSERT INTO `CARGO` (`id`, `nombre`) VALUES (1, 'Instructor experto');
INSERT INTO `CARGO` (`id`, `nombre`) VALUES (2, 'Instructor junior');
INSERT INTO `CARGO` (`id`, `nombre`) VALUES (3, 'Administrativo');

--
-- Volcado de datos para la tabla `CLIENTE`

INSERT INTO `CLIENTE` (`id`, `nombre`, `telefono`) VALUES (1, 'Gabriel', '02994687953');
INSERT INTO `CLIENTE` (`id`, `nombre`, `telefono`) VALUES (2, 'Maria', '02995512340');
INSERT INTO `CLIENTE` (`id`, `nombre`, `telefono`) VALUES (3, 'Ana', '02994968725');
INSERT INTO `CLIENTE` (`id`, `nombre`, `telefono`) VALUES (4, 'Pablo', '02996654123');
INSERT INTO `CLIENTE` (`id`, `nombre`, `telefono`) VALUES (5, 'Gastón', '02995236987');
INSERT INTO `CLIENTE` (`id`, `nombre`, `telefono`) VALUES (6, 'Lucía', '02995484632');

--
-- Volcado de datos para la tabla `SOLICITUD`

INSERT INTO `SOLICITUD` (`id`, `fecha`, `sucursal_id`, `cliente_id`, `curso_id`) VALUES (1, '2020-09-10', 1, 1, 1);
INSERT INTO `SOLICITUD` (`id`, `fecha`, `sucursal_id`, `cliente_id`, `curso_id`) VALUES (2, '2020-10-20', 1, 1, 2);
INSERT INTO `SOLICITUD` (`id`, `fecha`, `sucursal_id`, `cliente_id`, `curso_id`) VALUES (3, '2020-10-20', 1, 1, 3);
INSERT INTO `SOLICITUD` (`id`, `fecha`, `sucursal_id`, `cliente_id`, `curso_id`) VALUES (4, '2021-06-20', 1, 2, 4);
INSERT INTO `SOLICITUD` (`id`, `fecha`, `sucursal_id`, `cliente_id`, `curso_id`) VALUES (5, '2021-05-01', 2, 3, 5);
INSERT INTO `SOLICITUD` (`id`, `fecha`, `sucursal_id`, `cliente_id`, `curso_id`) VALUES (6, '2021-05-01', 2, 3, 6);
INSERT INTO `SOLICITUD` (`id`, `fecha`, `sucursal_id`, `cliente_id`, `curso_id`) VALUES (7, '2021-03-01', 2, 4, 7);

--
-- Volcado de datos para la tabla `CURSO`

INSERT INTO `CURSO` (`id`, `fecha_inicio`, `esta_pagado`, `esta_aprobado`, `empleado_id`, `tipo_curso_id`) VALUES (1, '2020-10-01', 1, 1, 1, 2);
INSERT INTO `CURSO` (`id`, `fecha_inicio`, `esta_pagado`, `esta_aprobado`, `empleado_id`, `tipo_curso_id`) VALUES (2, '2020-11-01', 1, null, 1, 1);
INSERT INTO `CURSO` (`id`, `fecha_inicio`, `esta_pagado`, `esta_aprobado`, `empleado_id`, `tipo_curso_id`) VALUES (3, '2020-11-03', 1, null, 1, 1);
INSERT INTO `CURSO` (`id`, `fecha_inicio`, `esta_pagado`, `esta_aprobado`, `empleado_id`, `tipo_curso_id`) VALUES (4, '2021-07-01', 0, null, 2, 3);
INSERT INTO `CURSO` (`id`, `fecha_inicio`, `esta_pagado`, `esta_aprobado`, `empleado_id`, `tipo_curso_id`) VALUES (5, '2021-05-26', 1, null, 4, 3);
INSERT INTO `CURSO` (`id`, `fecha_inicio`, `esta_pagado`, `esta_aprobado`, `empleado_id`, `tipo_curso_id`) VALUES (6, '2021-06-30', 0, null, 4, 1);
INSERT INTO `CURSO` (`id`, `fecha_inicio`, `esta_pagado`, `esta_aprobado`, `empleado_id`, `tipo_curso_id`) VALUES (7, '2021-03-15', 1, 0, 5, 2);

--
-- Volcado de datos para la tabla `TIPO_CURSO`

INSERT INTO `TIPO_CURSO` (`id`, `nombre`, `cantidad_clases`, `habilita_examen`, `cantidad_intentos_examen`, `costo`) VALUES (1, 'Clase práctica individual', 1, 0, 0, 2500.00);
INSERT INTO `TIPO_CURSO` (`id`, `nombre`, `cantidad_clases`, `habilita_examen`, `cantidad_intentos_examen`, `costo`) VALUES (2, 'Curso rápido', 4, 1, 2, 8000.00);
INSERT INTO `TIPO_CURSO` (`id`, `nombre`, `cantidad_clases`, `habilita_examen`, `cantidad_intentos_examen`, `costo`) VALUES (3, 'Curso estándar', 12, 1, 2, 20000.00);

--
-- Volcado de datos para la tabla `CLASE`

INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (1, '2020-10-01 10:00', '2020-10-01 11:00', 1, 1);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (2, '2020-10-03 10:00', '2020-10-03 11:00', 1, 1);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (3, '2020-10-05 10:00', '2020-10-05 11:00', 1, 1);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (4, '2020-10-08 10:00', '2020-10-08 11:00', 1, 1);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (5, '2020-11-01 16:00', '2020-11-01 17:00', 2, 1);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (6, '2020-11-03 12:00', '2020-11-03 13:00', 3, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (7, '2021-07-01 11:00', '2021-07-01 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (8, '2021-07-02 11:00', '2021-07-02 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (9, '2021-07-03 11:00', '2021-07-03 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (10, '2021-07-04 11:00', '2021-07-04 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (11, '2021-07-05 11:00', '2021-07-05 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (12, '2021-07-08 11:00', '2021-07-08 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (13, '2021-07-09 11:00', '2021-07-09 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (14, '2021-07-10 11:00', '2021-07-10 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (15, '2021-07-11 11:00', '2021-07-11 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (16, '2021-07-12 11:00', '2021-07-12 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (17, '2021-07-15 11:00', '2021-07-15 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (18, '2021-07-16 11:00', '2021-07-16 12:00', 4, 2);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (19, '2021-05-26 11:00', '2021-05-26 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (20, '2021-05-27 11:00', '2021-05-27 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (21, '2021-05-28 11:00', '2021-05-28 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (22, '2021-05-29 11:00', '2021-05-29 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (23, '2021-05-30 11:00', '2021-05-30 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (24, '2021-06-02 11:00', '2021-06-02 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (25, '2021-06-03 11:00', '2021-06-03 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (26, '2021-06-04 11:00', '2021-06-04 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (27, '2021-06-05 11:00', '2021-06-05 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (28, '2021-06-06 11:00', '2021-06-06 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (29, '2021-06-09 11:00', '2021-06-09 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (30, '2021-06-10 11:00', '2021-06-10 12:00', 5, 3);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (31, '2021-06-30 11:00', '2021-06-30 12:00', 6, 4);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (32, '2021-03-15 11:00', '2021-03-15 12:00', 7, 4);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (33, '2021-03-17 11:00', '2021-03-17 12:00', 7, 4);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (34, '2021-03-22 11:00', '2021-03-22 12:00', 7, 4);
INSERT INTO `CLASE` (`id`, `horario_inicio`, `horario_fin`, `curso_id`, `AUTO_id`) VALUES (35, '2021-03-24 11:00', '2021-03-24 12:00', 7, 4);

--
-- Volcado de datos para la tabla `AUTO`

INSERT INTO `AUTO` (`id`, `nombre`, `patente`, `titular`, `kilometraje`, `sucursal_id`) VALUES (1, 'CHANO001', 'AE501AA', 'Autoescuela El Chano', 35025, 1);
INSERT INTO `AUTO` (`id`, `nombre`, `patente`, `titular`, `kilometraje`, `sucursal_id`) VALUES (2, 'CHANO002', 'AE501AB', 'Autoescuela El Chano', 29687, 1);
INSERT INTO `AUTO` (`id`, `nombre`, `patente`, `titular`, `kilometraje`, `sucursal_id`) VALUES (3, 'CHANO003', 'AE515FC', 'Autoescuela El Chano', 24561, 2);
INSERT INTO `AUTO` (`id`, `nombre`, `patente`, `titular`, `kilometraje`, `sucursal_id`) VALUES (4, 'CHANO004', 'AE515FD', 'Autoescuela El Chano', 29687, 2);
INSERT INTO `AUTO` (`id`, `nombre`, `patente`, `titular`, `kilometraje`, `sucursal_id`) VALUES (5, 'CHANO005', 'AE521BA', 'Autoescuela El Chano', 21962, 3);
INSERT INTO `AUTO` (`id`, `nombre`, `patente`, `titular`, `kilometraje`, `sucursal_id`) VALUES (6, 'CHANO006', 'AE521BB', 'Autoescuela El Chano', 20358, 3);

--
-- Volcado de datos para la tabla `COMENTARIO`

INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (1, 4, null, 1);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (2, 4, null, 2);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (3, 5, null, 3);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (4, 5, 'muy buen instructor. recomendable', 4);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (5, 5, null, 5);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (6, 2, 'me puse muy nerviosa y el instructor no me ayudo a calmarme', 19);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (7, 4, 'hoy fue mas amable y paciente', 20);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (8, 4, null, 21);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (9, 5, null, 22);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (10, 5, null, 23);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (11, 4, null, 24);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (12, 5, null, 25);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (13, 5, null, 26);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (14, 5, null, 27);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (15, 4, null, 28);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (16, 5, null, 29);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (17, 5, 'muy bien en general', 30);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (18, 3, null, 32);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (19, 3, null, 33);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (20, 4, null, 34);
INSERT INTO `COMENTARIO` (`id`, `puntaje`, `comentario`, `clase_id`) VALUES (21, 3, 'no quede conforme', 35);

--
-- Volcado de datos para la tabla `EXAMEN`

INSERT INTO `EXAMEN` (`id`, `horario`, `nro_intento`, `esta_aprobado`, `motivo_desaprobado`, `puntaje`, `curso_id`) VALUES (1, '2020-11-10 11:00', 1, 1, null, 95, 1);
INSERT INTO `EXAMEN` (`id`, `horario`, `nro_intento`, `esta_aprobado`, `motivo_desaprobado`, `puntaje`, `curso_id`) VALUES (2, '2021-03-31 11:00', 1, 0, 'aun no adquiere las capacidades de manejo minimas', 40, 7);


# GENERATING OTHER CONSTRAINTS
ALTER TABLE `SUCURSAL` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `EMPLEADO` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
ALTER TABLE `CIUDAD` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `PROVINCIA` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `PAIS` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `CARGO` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `CLIENTE` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `SOLICITUD` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
ALTER TABLE `CURSO` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
ALTER TABLE `TIPO_CURSO` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `CLASE` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
ALTER TABLE `AUTO` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `COMENTARIO` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
ALTER TABLE `EXAMEN` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

# GENERATING RELATIONSHIPS
ALTER TABLE `SUCURSAL` ADD CONSTRAINT `sucursal_ciudad_ciudad_id` FOREIGN KEY (`CIUDAD_id`) REFERENCES `CIUDAD`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `EMPLEADO` ADD CONSTRAINT `empleado_pais_pais_id` FOREIGN KEY (`pais_id`) REFERENCES `PAIS`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `EMPLEADO` ADD CONSTRAINT `empleado_cargo_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `CARGO`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `EMPLEADO` ADD CONSTRAINT `empleado_sucursal_sucursal_id` FOREIGN KEY (`sucursal_id`) REFERENCES `SUCURSAL`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `CIUDAD` ADD CONSTRAINT `ciudad_provincia_provincia_id` FOREIGN KEY (`provincia_id`) REFERENCES `PROVINCIA`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `PROVINCIA` ADD CONSTRAINT `provincia_pais_pais_id` FOREIGN KEY (`pais_id`) REFERENCES `PAIS`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `SOLICITUD` ADD CONSTRAINT `solicitud_sucursal_sucursal_id` FOREIGN KEY (`sucursal_id`) REFERENCES `SUCURSAL`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `SOLICITUD` ADD CONSTRAINT `solicitud_cliente_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `CLIENTE`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `SOLICITUD` ADD CONSTRAINT `solicitud_curso_curso_id` FOREIGN KEY (`curso_id`) REFERENCES `CURSO`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `CURSO` ADD CONSTRAINT `curso_empleado_empleado_id` FOREIGN KEY (`empleado_id`) REFERENCES `EMPLEADO`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `CURSO` ADD CONSTRAINT `curso_tipo_curso_tipo_curso_id` FOREIGN KEY (`tipo_curso_id`) REFERENCES `TIPO_CURSO`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `CLASE` ADD CONSTRAINT `clase_curso_curso_id` FOREIGN KEY (`curso_id`) REFERENCES `CURSO`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `CLASE` ADD CONSTRAINT `clase_auto_auto_id` FOREIGN KEY (`AUTO_id`) REFERENCES `AUTO`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `COMENTARIO` ADD CONSTRAINT `comentario_clase_clase_id` FOREIGN KEY (`clase_id`) REFERENCES `CLASE`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `AUTO` ADD CONSTRAINT `auto_sucursal_sucursal_id` FOREIGN KEY (`sucursal_id`) REFERENCES `SUCURSAL`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE `EXAMEN` ADD CONSTRAINT `examen_curso_curso_id` FOREIGN KEY (`curso_id`) REFERENCES `CURSO`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE;