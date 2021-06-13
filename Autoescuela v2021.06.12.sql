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
	`domicilio` VARCHAR(500) NULL,
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
	`fecha_caducidad_carnet` DATE NULL,
	`pais_id` INTEGER NOT NULL,
	KEY(`pais_id`),
	`cargo_id` INTEGER NOT NULL,
	KEY(`cargo_id`),
	`sucursal_id` INTEGER NOT NULL,
	KEY(`sucursal_id`),
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
	`esta_aprobado` BIT NOT NULL,
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
	`motivo_desaprobado` VARCHAR(500) NULL,
	`puntaje` TINYINT NOT NULL,
	`curso_id` INTEGER NOT NULL,
	KEY(`curso_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

CREATE TABLE `COMENTARIO` (
	`id` INTEGER NOT NULL,
	`puntaje` TINYINT NOT NULL,
	`comentario` VARCHAR(500) NULL,
	`clase_id` INTEGER NOT NULL,
	KEY(`clase_id`),
	PRIMARY KEY(`id`)
) ENGINE=INNODB;

# POPULATING TABLES

--
-- Volcado de datos para la tabla `SUCURSAL`

INSERT INTO `SUCURSAL`(`id`, `nombre`, `domicilio`, `ciudad_id`) VALUES (1, 'Sucursal Neuquén', 'San Martín 434', 1);
INSERT INTO `SUCURSAL`(`id`, `nombre`, `domicilio`, `ciudad_id`) VALUES (1, 'Sucursal Cipolletti', 'Tres Arroyos 950', 2);
INSERT INTO `SUCURSAL`(`id`, `nombre`, `domicilio`, `ciudad_id`) VALUES (1, 'Sucursal Comodoro Rivadavia', 'Buenos Aires 335', 3);

--
-- Volcado de datos para la tabla `EMPLEADO`

INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`) VALUES (1, 'Chano', 'Carpentier', '28578425', '01147896524', '2023-10-15', 1, 1, 1);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`) VALUES (2, 'Manu', 'Urcera', '30578963', '02994854878', '2022-07-05', 1, 2, 1);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`) VALUES (3, 'Juana', 'Viale', '29565100', '01152346281', null, 1, 3, 1);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`) VALUES (4, 'Juan Maria', 'Traverso', '12546102', '01155574812', '2021-05-15', 1, 1, 2);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`) VALUES (5, 'Nicolás', 'Maduro', '92464712', '02996822301', '2022-09-05', 2, 2, 2);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`) VALUES (6, 'Arabela', 'Carreras', '20189758', '02995234144', null, 1, 3, 2);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`) VALUES (7, 'Pastor', 'Maldonado', '92556130', '+589212232054', '2023-05-15', 2, 1, 3);
INSERT INTO `EMPLEADO` (`id`, `nombre`, `apellido`, `dni`, `telefono`, `fecha_caducidad_carnet`, `pais_id`, `cargo_id`, `sucursal_id`) VALUES (8, 'Cristobal', 'Lopez', '11547268', '02916822301', 'null', 3, 3, 3);

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

# GENERATING OTHER CONSTRAINTS
ALTER TABLE `SUCURSAL` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `EMPLEADO` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
ALTER TABLE `CIUDAD` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `PROVINCIA` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `PAIS` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `CARGO` MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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