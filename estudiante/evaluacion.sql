-- phpMyAdmin SQL Dump
-- version 5.1.0-3.fc32
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 01-08-2023 a las 23:32:36
-- Versión del servidor: 10.4.19-MariaDB
-- Versión de PHP: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `evaluacion`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `select_documento_idportafolio` (IN `pidportafolio` INT)  BEGIN
	SELECT documento FROM tb_portafolio
    WHERE idportafolio = pidportafolio;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_administrativos_select_all` ()  BEGIN
	SELECT A.idadministrativo, CONCAT(A.apellidos, ' ', A.nombres) AS administrativo, C.cargo, A.estado
    FROM tb_administrativo A INNER JOIN tb_cargo C ON A.idcargo = C.idcargo;    
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_administrativos_valida_evaluacion` (IN `pidestudiante` INT, IN `pidadministrativo` INT)  BEGIN
	SELECT count(*) AS num FROM tb_heteroevaluacion_estudiante_administrativo
    WHERE idestudiante = pidestudiante
    AND idadministrativo = pidadministrativo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_administrativo_delete` (IN `pidadministrativo` INT)  BEGIN
	DELETE FROM tb_administrativo
    WHERE idadministrativo = pidadministrativo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_administrativo_insert` (IN `ptipoidentificacion` INT, IN `pidentificacion` VARCHAR(25), IN `pnombres` VARCHAR(100), IN `papellidos` VARCHAR(100), IN `pcorreo` VARCHAR(255), IN `pidarea` INT, IN `pcontrasena` VARCHAR(255))  BEGIN
	INSERT INTO tb_administrativo(tipoidentificacion, identificacion, nombres, apellidos, correo, idarea, contrasena)
    VALUES(ptipoidentificacion, pidentificacion, pnombres, papellidos, pcorreo, pidarea, pcontrasena);
    	
    SELECT @idadministrativo := idadministrativo FROM tb_administrativo WHERE identificacion = pidentificacion;
    
    INSERT INTO tb_autoevaluacion_administrativo(idadministrativo) VALUES(@idadministrativo);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_administrativo_select_all` ()  BEGIN
	SELECT * FROM tb_administrativo
	ORDER by apellidos, nombres;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_administrativo_select_correo` (IN `pidadministrativo` INT, IN `pcorreo` VARCHAR(255))  BEGIN
	IF pidadministrativo = 0 THEN
		SELECT * FROM tb_administrativo
    	WHERE correo = pcorreo;
    ELSE
    	SELECT * FROM tb_administrativo
    	WHERE correo = pcorreo
        AND idadministrativo <> pidadministrativo;
	END IF;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_administrativo_select_id` (IN `pidadministrativo` INT)  BEGIN
	SELECT * FROM tb_administrativo
    WHERE idadministrativo = pidadministrativo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_administrativo_select_identificacion` (IN `pidadministrativo` INT, IN `pidentificacion` VARCHAR(25))  BEGIN
    IF pidadministrativo=0 THEN
    	SELECT * FROM tb_administrativo
        WHERE identificacion = pidentificacion;
    ELSE
        SELECT * FROM tb_administrativo
        WHERE identificacion = pidentificacion
        AND idadministrativo <> pidadministrativo;
    END IF;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_administrativo_update` (IN `pidadministrativo` INT, IN `ptipoidentificacion` INT, IN `pidentificacion` VARCHAR(25), IN `pnombres` VARCHAR(100), IN `papellidos` VARCHAR(100), IN `pcorreo` VARCHAR(255), IN `pidarea` INT)  BEGIN
	UPDATE tb_administrativo SET tipoidentificacion = ptipoidentificacion,
    					  identificacion = pidentificacion,
                          nombres = pnombres,
                          apellidos = papellidos,
                          correo = pcorreo,
                          idarea = pidarea
	WHERE idadministrativo = pidadministrativo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_area_select_all` ()  BEGIN
	SELECT * FROM tb_area;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_area_select_idadministrativo` (IN `pidadministrativo` INT)  BEGIN
	SELECT R.idarea, R.area
    FROM tb_administrativo A INNER JOIN tb_area R on A.idarea = R.idarea
    WHERE A.idadministrativo = pidadministrativo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_area_select_idautoridad` (IN `pidautoridad` INT)  BEGIN
	SELECT R.idarea, R.area
    FROM tb_autoridad A INNER JOIN tb_area R on A.idarea = R.idarea
    WHERE A.idautoridad = pidautoridad;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_area_select_iddocente` (IN `piddocente` INT)  BEGIN
	SELECT R.idarea, R.area
    FROM tb_docente D INNER JOIN tb_area R on D.idarea = R.idarea
    WHERE D.iddocente = piddocente;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_area_select_idevaluador` (IN `pidevaluador` INT)  BEGIN
	SELECT R.idarea, R.area
    FROM tb_docente D INNER JOIN tb_area R on D.idarea = R.idarea
    WHERE D.iddocente = pidevaluador;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoevaluacion_administrativo` (IN `pidadministrativo` INT)  BEGIN
	SELECT A.idautoevaluacion, D.idadministrativo, D.apellidos, D.nombres, A.estado
    FROM tb_autoevaluacion_administrativo A 
    INNER JOIN tb_administrativo D ON A.idadministrativo = D.idadministrativo
    WHERE A.idadministrativo = pidadministrativo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoevaluacion_administrativo_select` (IN `pidautoevaluacion` INT)  BEGIN
	SELECT D.idadministrativo, D.apellidos, D.nombres
    FROM tb_autoevaluacion_administrativo A 
    INNER JOIN tb_administrativo D ON A.idadministrativo = D.idadministrativo
    WHERE A.idautoevaluacion = pidautoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoevaluacion_docente` (IN `piddocente` INT)  BEGIN
	SELECT A.idautoevaluacion, D.iddocente, D.apellidos, D.nombres, A.estado
    FROM tb_autoevaluacion A INNER JOIN tb_docente D ON A.iddocente = D.iddocente
    WHERE A.iddocente = piddocente;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoevaluacion_docente_select` (IN `pidautoevaluacion` INT)  BEGIN
	SELECT D.iddocente, D.apellidos, D.nombres
    FROM tb_autoevaluacion A INNER JOIN tb_docente D ON A.iddocente = D.iddocente
    WHERE A.idautoevaluacion = pidautoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoridades_delete` (IN `pidautoridad` INT)  BEGIN
	DELETE FROM tb_autoridad
    WHERE idautoridad = pidautoridad;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoridades_insert` (IN `ptipoidentificacion` INT, IN `pidentificacion` VARCHAR(25), IN `pnombres` VARCHAR(100), IN `papellidos` VARCHAR(100), IN `pcorreo` VARCHAR(255), IN `pidarea` INT, IN `pcontrasena` VARCHAR(255))  BEGIN
	INSERT INTO tb_autoridad(tipoidentificacion, identificacion, nombres, apellidos, correo, idarea, contrasena)
    VALUES(ptipoidentificacion, pidentificacion, pnombres, papellidos, pcorreo, pidarea, pcontrasena);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoridades_select_all` ()  BEGIN
	SELECT * FROM tb_autoridad;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoridades_select_correo` (IN `pidautoridad` INT, IN `pcorreo` VARCHAR(255))  BEGIN
	IF pidautoridad = 0 THEN
		SELECT * FROM tb_autoridad
    	WHERE correo = pcorreo;
    ELSE
    	SELECT * FROM tb_autoridad
    	WHERE correo = pcorreo
        AND idautoridad <> pidautoridad;
	END IF;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoridades_select_id` (IN `pidautoridad` INT)  BEGIN
	SELECT * FROM tb_autoridad
    WHERE idautoridad = pidautoridad;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoridades_select_identificacion` (IN `pidautoridad` INT, IN `pidentificacion` VARCHAR(25))  BEGIN
    IF pidautoridad=0 THEN
    	SELECT * FROM tb_autoridad
        WHERE identificacion = pidentificacion;
    ELSE
        SELECT * FROM tb_autoridad
        WHERE identificacion = pidentificacion
        AND idautoridad <> pidautoridad;
    END IF;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_autoridades_update` (IN `pidautoridad` INT, IN `ptipoidentificacion` INT, IN `pidentificacion` VARCHAR(25), IN `pnombres` VARCHAR(100), IN `papellidos` VARCHAR(100), IN `pcorreo` VARCHAR(255), IN `pidarea` INT)  BEGIN
	UPDATE tb_autoridad SET tipoidentificacion = ptipoidentificacion,
    					  identificacion = pidentificacion,
                          nombres = pnombres,
                          apellidos = papellidos,
                          correo = pcorreo,
                          idarea = pidarea
    WHERE idautoridad = pidautoridad;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_carrera_select_all` ()  BEGIN
	SELECT * FROM tb_carrera;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_coevaluacion_administrativo_delete` (IN `pidcoevaluacion` INT)  BEGIN
	DELETE FROM tb_coevaluacion_administrativo
    WHERE idcoevaluacion = pidcoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_coevaluacion_administrativo_insert` (IN `pidevaluador` INT, IN `pidadministrativo` INT)  BEGIN
	INSERT INTO tb_coevaluacion_administrativo(idevaluador, idadministrativo)
    VALUES(pidevaluador, pidadministrativo);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_coevaluacion_administrativo_select` (IN `pidcoevaluacion` INT)  BEGIN
	SELECT A.idadministrativo, A.apellidos, A.nombres
    FROM tb_coevaluacion_administrativo C INNER JOIN tb_administrativo A ON C.idadministrativo = A.idadministrativo
    WHERE C.idcoevaluacion = pidcoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_coevaluacion_delete` (IN `pidcoevaluacion` INT)  BEGIN
	DELETE FROM tb_coevaluacion
    WHERE idcoevaluacion = pidcoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_coevaluacion_docente_select` (IN `pidcoevaluacion` INT)  BEGIN
	SELECT D.iddocente, D.apellidos, D.nombres
    FROM tb_coevaluacion C INNER JOIN tb_docente D ON C.iddocente = D.iddocente
    WHERE C.idcoevaluacion = pidcoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_coevaluacion_evaluador_administrativo` (IN `pidevaluador` INT)  BEGIN
	SELECT C.idcoevaluacion, A.idadministrativo, A.apellidos, A.nombres, C.estado
    FROM tb_coevaluacion_administrativo C INNER JOIN tb_administrativo A ON C.idadministrativo = A.idadministrativo
    WHERE C.idevaluador = pidevaluador;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_coevaluacion_evaluador_docente` (IN `pidevaluador` INT)  BEGIN
	SELECT C.idcoevaluacion, D.iddocente, D.apellidos, D.nombres, C.estado
    FROM tb_coevaluacion C INNER JOIN tb_docente D ON C.iddocente = D.iddocente
    WHERE C.idevaluador = pidevaluador;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_coevaluacion_insert` (IN `pidevaluador` INT, IN `piddocente` INT)  BEGIN
	INSERT INTO tb_coevaluacion(idevaluador, iddocente)
    VALUES(pidevaluador, piddocente);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_criterios_select_all` ()  BEGIN
	SELECT * FROM tb_criterio;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_detalle_autoevaluacion_administrativo_insert` (IN `pidautoevaluacion` INT, IN `pindicador1` INT, IN `pindicador2` INT, IN `pindicador3` INT, IN `pindicador4` INT, IN `pindicador5` INT, IN `pindicador6` INT, IN `pindicador7` INT, IN `pindicador8` INT, IN `pindicador9` INT, IN `pindicador10` INT, IN `ptotal` DECIMAL(10,2))  BEGIN
	INSERT INTO tb_detalle_autoevaluacion_administrativo(idautoevaluacion, indicador1, indicador2, indicador3, indicador4, indicador5, indicador6, indicador7, indicador8, indicador9, indicador10, total)
    VALUES(pidautoevaluacion, pindicador1, pindicador2, pindicador3, pindicador4, pindicador5, pindicador6, pindicador7, pindicador8, pindicador9, pindicador10, ptotal);
    UPDATE tb_autoevaluacion_administrativo SET estado = 1
    WHERE idautoevaluacion = pidautoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_detalle_autoevaluacion_insert` (IN `pidautoevaluacion` INT, IN `pindicador1` INT, IN `pindicador2` INT, IN `pindicador3` INT, IN `pindicador4` INT, IN `pindicador5` INT, IN `ptotal` INT)  BEGIN
	INSERT INTO tb_detalle_autoevaluacion(idautoevaluacion, indicador1, indicador2, indicador3, indicador4, indicador5, total)
    VALUES(pidautoevaluacion, pindicador1, pindicador2, pindicador3, pindicador4, pindicador5, ptotal);
    UPDATE tb_autoevaluacion SET estado = 1
    WHERE idautoevaluacion = pidautoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_detalle_coevaluacion_administrativo_insert` (IN `pidcoevaluacion` INT, IN `pindicador1` INT, IN `pindicador2` INT, IN `pindicador3` INT, IN `pindicador4` INT, IN `pindicador5` INT, IN `pindicador6` INT, IN `pindicador7` INT, IN `pindicador8` INT, IN `pindicador9` INT, IN `pindicador10` INT, IN `ptotal` DECIMAL(10,2))  BEGIN
	INSERT INTO tb_detalle_coevaluacion_administrativo(idcoevaluacion, indicador1, indicador2, indicador3, indicador4, indicador5, indicador6, indicador7, indicador8, indicador9, indicador10, total)
    VALUES(pidcoevaluacion, pindicador1, pindicador2, pindicador3, pindicador4, pindicador5, pindicador6, pindicador7, pindicador8, pindicador9, pindicador10, ptotal);
    UPDATE tb_coevaluacion_administrativo SET estado = 1
    WHERE idcoevaluacion = pidcoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_detalle_coevaluacion_insert` (IN `pidcoevaluacion` INT, IN `pindicador1` INT, IN `pindicador2` INT, IN `pindicador3` INT, IN `pindicador4` INT, IN `pindicador5` INT, IN `ptotal` INT)  BEGIN
	INSERT INTO tb_detalle_coevaluacion(idcoevaluacion, indicador1, indicador2, indicador3, indicador4, indicador5, total)
    VALUES(pidcoevaluacion, pindicador1, pindicador2, pindicador3, pindicador4, pindicador5, ptotal);
    UPDATE tb_coevaluacion SET estado = 1
    WHERE idcoevaluacion = pidcoevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_detalle_heteroevaluacion_administrativos_insert` (IN `pidheteroevaluacion` INT, IN `pindicador1` INT, IN `pindicador2` INT, IN `pindicador3` INT, IN `pindicador4` INT, IN `pindicador5` INT, IN `pindicador6` INT, IN `pindicador7` INT, IN `pindicador8` INT, IN `pindicador9` INT, IN `pindicador10` INT, IN `ptotal` DECIMAL(10,2))  BEGIN
	INSERT INTO tb_detalle_heteroevaluacion_administrativo(idheteroevaluacion, indicador1, indicador2, indicador3, indicador4, indicador5, indicador6, indicador7, indicador8, indicador9, indicador10, total)
    VALUES(pidheteroevaluacion, pindicador1, pindicador2, pindicador3, pindicador4, pindicador5, pindicador6, pindicador7, pindicador8, pindicador9, pindicador10, ptotal);
    UPDATE tb_heteroevaluacion_administrativo SET estado = 1
    WHERE idheteroevaluacion = pidheteroevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_detalle_heteroevaluacion_estudiante_docente_insert` (IN `pidevaluacion` INT, IN `pindicador1` INT, IN `pindicador2` INT, IN `pindicador3` INT, IN `pindicador4` INT, IN `pindicador5` INT, IN `ptotal` INT)  BEGIN
	INSERT INTO tb_detalle_evaluacion_estudiante(idevaluacion, indicador1, indicador2, indicador3, indicador4, indicador5, total)
    VALUES(pidevaluacion, pindicador1, pindicador2, pindicador3, pindicador4, pindicador5, ptotal);
    UPDATE tb_evaluacion_estudiante SET estado = 1
    WHERE idevaluacion = pidevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_detalle_heteroevaluacion_insert` (IN `pidheteroevaluacion` INT, IN `pindicador1` INT, IN `pindicador2` INT, IN `pindicador3` INT, IN `pindicador4` INT, IN `pindicador5` INT, IN `ptotal` INT)  BEGIN
	INSERT INTO tb_detalle_heteroevaluacion(idheteroevaluacion, indicador1, indicador2, indicador3, indicador4, indicador5, total)
    VALUES(pidheteroevaluacion, pindicador1, pindicador2, pindicador3, pindicador4, pindicador5, ptotal);
    UPDATE tb_heteroevaluacion SET estado = 1
    WHERE idheteroevaluacion = pidheteroevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_docente_delete` (IN `piddocente` INT)  BEGIN
	DELETE FROM tb_docente
    WHERE iddocente = piddocente;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_docente_insert` (IN `ptipoidentificacion` INT, IN `pidentificacion` VARCHAR(25), IN `pnombres` VARCHAR(100), IN `papellidos` VARCHAR(100), IN `pcorreo` VARCHAR(255), IN `pidarea` INT, IN `pcontrasena` VARCHAR(255))  BEGIN
	INSERT INTO tb_docente(tipoidentificacion, identificacion, nombres, apellidos, correo, idarea, contrasena)
    VALUES(ptipoidentificacion, pidentificacion, pnombres, papellidos, pcorreo, pidarea, pcontrasena);
    	
    SELECT @iddocente := iddocente FROM tb_docente WHERE identificacion = pidentificacion;
    
    INSERT INTO tb_autoevaluacion(iddocente) VALUES(@iddocente);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_docente_materia_select_all` ()  BEGIN
	SELECT S.idsilabo, D.identificacion, D.apellidos, D.nombres, S.idsemestre, M.materia, S.jornada FROM tb_silabos S 
    INNER JOIN tb_docente D ON S.iddocente = D.iddocente INNER JOIN tb_materia M ON S.idmateria = M.idmateria;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_docente_select_all` ()  BEGIN
	SELECT * FROM tb_docente
	ORDER by apellidos, nombres;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_docente_select_correo` (IN `piddocente` INT, IN `pcorreo` VARCHAR(255))  BEGIN
	IF piddocente = 0 THEN
		SELECT * FROM tb_docente
    	WHERE correo = pcorreo;
    ELSE
    	SELECT * FROM tb_docente
    	WHERE correo = pcorreo
        AND iddocente <> piddocente;
	END IF;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_docente_select_id` (IN `piddocente` INT)  BEGIN
	SELECT * FROM tb_docente
    WHERE iddocente = piddocente;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_docente_select_identificacion` (IN `piddocente` INT, IN `pidentificacion` VARCHAR(25))  BEGIN
    IF piddocente=0 THEN
    	SELECT * FROM tb_docente
        WHERE identificacion = pidentificacion;
    ELSE
        SELECT * FROM tb_docente
        WHERE identificacion = pidentificacion
        AND iddocente <> piddocente;
    END IF;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_docente_update` (IN `piddocente` INT, IN `ptipoidentificacion` INT, IN `pidentificacion` VARCHAR(25), IN `pnombres` VARCHAR(100), IN `papellidos` VARCHAR(100), IN `pcorreo` VARCHAR(255), IN `pidarea` INT)  BEGIN
	UPDATE tb_docente SET tipoidentificacion = ptipoidentificacion,
    					  identificacion = pidentificacion,
                          nombres = pnombres,
                          apellidos = papellidos,
                          correo = pcorreo,
                          idarea = pidarea
	WHERE iddocente = piddocente;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_estudiante_select_all` ()  BEGIN
	SELECT idestudiante, cedula, nombres, contrasena 
    FROM tb_estudiante
    ORDER BY idcarrera;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_estudiante_select_carrera` (IN `pidcarrera` INT, IN `psemestre` INT, IN `pjornada` VARCHAR(25))  BEGIN
	SELECT idestudiante, cedula, nombres, contrasena FROM tb_estudiante
    WHERE idcarrera = pidcarrera
    AND semestre = psemestre
    AND jornada = pjornada;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_estudiante_valida_estado` (IN `pidestudiante` INT)  BEGIN
	SELECT COUNT(*)as n 
    FROM tb_evaluacion_estudiante
    WHERE idestudiante = pidestudiante
    AND estado = 0;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_evaluacionestudiante_insert` (IN `pidestudiante` INT, IN `pidsilabo` INT)  BEGIN
	INSERT INTO tb_evaluacion_estudiante(idestudiante, idsilabo)
    VALUES(pidestudiante, pidsilabo);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_evaluacionestudiante_select_all` ()  BEGIN
	SELECT E.idevaluacion, D.identificacion, D.apellidos, D.nombres, M.materia, S.idsemestre, S.jornada, M.materia
    FROM tb_evaluacion_estudiante E 
    	INNER JOIN tb_silabos S ON E.idsilabo = S.idsilabo
    	INNER JOIN tb_docente D ON S.iddocente = D.iddocente
        INNER JOIN tb_materia M ON S.idmateria = M.idmateria
   GROUP BY D.apellidos, D.nombres, M.materia;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_administrativo_delete` (IN `pidheteroevaluacion` INT)  BEGIN
	DELETE FROM tb_heteroevaluacion_administrativo
    WHERE idheteroevaluacion = pidheteroevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_administrativo_insert` (IN `pidautoridad` INT, IN `pidadministrativo` INT)  BEGIN
	INSERT INTO tb_heteroevaluacion_administrativo(idautoridad, idadministrativo)
    VALUES(pidautoridad, pidadministrativo);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_administrativo_select` (IN `pidheteroevaluacion` INT)  BEGIN
	SELECT D.idadministrativo, D.apellidos, D.nombres
    FROM tb_heteroevaluacion_administrativo H INNER JOIN tb_administrativo D ON H.idadministrativo = D.idadministrativo
    WHERE H.idheteroevaluacion = pidheteroevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_autoridad_administrativo` (IN `pidautoridad` INT)  BEGIN
	SELECT H.idheteroevaluacion, A.idadministrativo, A.apellidos, A.nombres, H.estado
    FROM tb_heteroevaluacion_administrativo H INNER JOIN tb_administrativo A ON H.idadministrativo = A.idadministrativo
    WHERE H.idautoridad = pidautoridad;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_autoridad_docente` (IN `pidautoridad` INT)  BEGIN
	SELECT H.idheteroevaluacion, D.iddocente, D.apellidos, D.nombres, H.estado
    FROM tb_heteroevaluacion H INNER JOIN tb_docente D ON H.iddocente = D.iddocente
    WHERE H.idautoridad = pidautoridad;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_delete` (IN `pidheteroevaluacion` INT)  BEGIN
	DELETE FROM tb_heteroevaluacion
    WHERE idheteroevaluacion = pidheteroevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_docente_select` (IN `pidheteroevaluacion` INT)  BEGIN
	SELECT D.iddocente, D.apellidos, D.nombres
    FROM tb_heteroevaluacion H INNER JOIN tb_docente D ON H.iddocente = D.iddocente
    WHERE H.idheteroevaluacion = pidheteroevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_estudiante_administrativo_insert` (IN `pidestudiante` INT, IN `pidadministrativo` INT, IN `ptotal` INT)  BEGIN
	INSERT INTO tb_heteroevaluacion_estudiante_administrativo(idestudiante, idadministrativo, total, estado)
    VALUES(pidestudiante, pidadministrativo, ptotal, 1);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_estudiante_docente` (IN `pidestudiante` INT)  BEGIN
	SELECT E.idevaluacion, D.iddocente, D.apellidos, D.nombres, E.estado
    FROM tb_evaluacion_estudiante E 
    	INNER JOIN tb_silabos S ON E.idsilabo = S.idsilabo
        INNER JOIN tb_docente D ON S.iddocente = D.iddocente
        WHERE E.idestudiante = pidestudiante;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_estudiante_docente_select_id` (IN `pidevaluacion` INT)  BEGIN
	SELECT D.iddocente, D.apellidos, D.nombres
    FROM tb_evaluacion_estudiante E 
    INNER JOIN tb_silabos S ON E.idsilabo = S.idsilabo
   	INNER JOIN tb_docente D ON S.iddocente = D.iddocente
    WHERE E.idevaluacion = pidevaluacion;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_heteroevaluacion_insert` (IN `pidautoridad` INT, IN `piddocente` INT)  BEGIN
	INSERT INTO tb_heteroevaluacion(idautoridad, iddocente)
    VALUES(pidautoridad, piddocente);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_login_administrativos_validate` (IN `pusuario` VARCHAR(25), IN `pcontrasena` VARCHAR(255))  BEGIN
	SELECT * FROM tb_administrativo
    WHERE identificacion = pusuario
    AND contrasena = pcontrasena
    AND estado = 1;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_login_admin_validate` (IN `pusuario` VARCHAR(25), IN `pcontrasena` VARCHAR(255))  BEGIN
	SELECT * FROM tb_usuario
    WHERE usuario = pusuario
    AND contrasena = pcontrasena;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_login_autoridad_validate` (IN `pidentificacion` VARCHAR(25), IN `pcontrasena` VARCHAR(255))  BEGIN
	SELECT * FROM tb_autoridad
    WHERE identificacion = pidentificacion
    AND contrasena = pcontrasena
    AND estado = 1;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_login_estudiante_validate` (IN `pusuario` VARCHAR(25), IN `pcontrasena` VARCHAR(25))  BEGIN
	SELECT * FROM tb_estudiante
    WHERE cedula = pusuario
    AND cedula = pcontrasena;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_login_validate` (IN `pusuario` VARCHAR(25), IN `pcontrasena` VARCHAR(255))  BEGIN
	SELECT * FROM tb_docente
    WHERE identificacion = pusuario
    AND contrasena = pcontrasena
    AND estado = 1;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_materia_select_all` ()  BEGIN
	SELECT * FROM tb_materia
    ORDER BY materia;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_portafolio_delete` (IN `pidportafolio` INT)  BEGIN
	DELETE FROM tb_portafolio
    WHERE idportafolio = pidportafolio;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_portafolio_insert` (IN `piddocente` INT, IN `pidcriterio` INT, IN `pdocumento` VARCHAR(25))  BEGIN
	INSERT INTO tb_portafolio(iddocente, idcriterio, documento)
    VALUES(piddocente, pidcriterio, pdocumento);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_portafolio_select_idcriterio` (IN `piddocente` INT, IN `pidcriterio` INT)  BEGIN
	SELECT * FROM tb_portafolio
    WHERE iddocente = piddocente
    AND idcriterio = pidcriterio;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_portafolio_select_iddocente` (IN `piddocente` INT)  BEGIN
	SELECT P.idportafolio, P.idcriterio, C.criterio, P.documento, P.estado
    FROM tb_portafolio P INNER JOIN tb_criterio C ON P.idcriterio = C.idcriterio
    WHERE P.iddocente = piddocente
    ORDER BY C.idcriterio;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_preguntas_select_area` (IN `pidarea` INT)  BEGIN
	SELECT * FROM tb_preguntas 
    WHERE idarea = pidarea;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_preguntas_select_area_autoevaluacion` (IN `pidarea` INT, IN `ptipo` VARCHAR(1))  BEGIN
	SELECT * FROM tb_preguntas_administrativo
    WHERE idarea = pidarea
    AND tipo = ptipo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_preguntas_select_area_coevaluacion` (IN `pidarea` INT, IN `ptipo` VARCHAR(1))  BEGIN
	SELECT * FROM tb_preguntas_administrativo
    WHERE idarea = pidarea
    AND tipo = ptipo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_preguntas_select_area_heteroevaluacion` (IN `pidarea` INT, IN `ptipo` VARCHAR(1))  BEGIN
	SELECT * FROM tb_preguntas_administrativo
    WHERE idarea = pidarea
    AND tipo = ptipo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_satisfaccion_insert` (IN `pidestudiante` INT, IN `pparametro` VARCHAR(2), IN `pcalificacion` INT)  BEGIN
    INSERT INTO tb_satisfaccion(idestudiante, parametro, calificacion)
	VALUES(pidestudiante, pparametro, pcalificacion);  
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_silabos_delete` (IN `pidsilabo` INT)  BEGIN
	DELETE FROM tb_silabos
    WHERE idsilabo = pidsilabo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_silabos_insert` (IN `piddocente` INT, IN `pidsemestre` INT, IN `pparalelo` VARCHAR(1), IN `pjornada` VARCHAR(25), IN `pidmateria` INT)  BEGIN
	INSERT INTO tb_silabos(iddocente, idsemestre, paralelo, jornada, idmateria)
    VALUES(piddocente, pidsemestre, pparalelo, pjornada, pidmateria);
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_silabos_select_iddocente` (IN `piddocente` INT)  BEGIN
	SELECT S.idsilabo, S.idsemestre, S.paralelo, S.jornada, M.idmateria, M.materia, S.silabo, S.estado
    FROM tb_silabos S INNER JOIN tb_materia M ON S.idmateria = M.idmateria
    WHERE S.iddocente = piddocente;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_silabos_select_iddocente_materia` (IN `piddocente` INT, IN `pidsemestre` INT, IN `pparalelo` VARCHAR(1), IN `pjornada` VARCHAR(25), IN `pidmateria` INT)  BEGIN
	SELECT * FROM tb_silabos
    WHERE iddocente = piddocente
    AND idsemestre = pidsemestre
    AND paralelo = pparalelo
    AND jornada = pjornada
    AND idmateria = pidmateria;
 END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_silabos_upload` (IN `pidsilabo` INT, IN `psilabo` VARCHAR(25))  BEGIN
	UPDATE tb_silabos SET silabo = psilabo, estado = 1
    WHERE idsilabo = pidsilabo;
END$$

CREATE DEFINER=`evaluacion`@`localhost` PROCEDURE `sp_silabo_select_iddocente` (IN `piddocente` INT)  BEGIN
	SELECT S.idsilabo, S.idsemestre, S.paralelo, S.jornada, M.materia
	FROM tb_silabos S INNER JOIN tb_materia M ON S.idmateria = M.idmateria
	WHERE S.iddocente = piddocente;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_administrativo`
--

CREATE TABLE `tb_administrativo` (
  `idadministrativo` int(11) NOT NULL,
  `tipoidentificacion` int(11) NOT NULL,
  `identificacion` varchar(25) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `idarea` int(11) NOT NULL,
  `idcargo` int(11) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_administrativo`
--

INSERT INTO `tb_administrativo` (`idadministrativo`, `tipoidentificacion`, `identificacion`, `nombres`, `apellidos`, `correo`, `idarea`, `idcargo`, `contrasena`, `estado`) VALUES
(4, 1, '1350501779', 'EDISON', 'CASTRO', 'Castroedisson80@gmail.com', 6, 8, 'RjJlWmlwZTlvTFdZQzdZYjVBS2ZBZz09', 1),
(5, 1, '1314796028', 'MAURO', 'LOOR ROMERO', 'x.melr@hotmail.com', 6, 6, 'TERGMkxUNndRQ1dDZm44NjM0TGNqQT09', 1),
(6, 1, '1312834920', 'ANDREA', 'VINCES MEZA', 'kandre271089@outlook.es', 6, 1, 'NXVJUTVibWZ4T3NmaVRyeTZzMlJrZz09', 1),
(7, 1, '1312294745', 'JORGE', 'MENDOZA', 'jorgmendozambrano01@gmail.com', 6, 7, 'RGNvaGIwbThHR0NyRzhNMW4zWGFSdz09', 1),
(8, 1, '1309690327', 'RONALD', 'ARIAS MERCHÁN', 'ronaldpublicidad1982@gmail.com', 6, 6, 'V1YxWjdjc2J3MFd0TjZGY0VWUmVwZz09', 1),
(9, 1, '1304547910', 'MIRNA', 'BERMUDEZ LUCAS', 'mimabelu@hotmail.com', 6, 2, 'bzc0SVBPVXZMQ1dMb2lxanZINFdWdz09', 1),
(10, 1, '0963549753', 'DARIO', 'VENTURA GALARDY', 'darioventuragalardy@gmail.com', 6, 10, 'LzZhKzNCZmFhMVBZV3JjWEN1dXRQUT09', 1),
(11, 1, '1313121921', 'JOSÉ', 'NAUM REYES', 'Naulrys12@gmail.com', 6, 8, 'ZmtzaUVnTkJRWmdYM25ZbDhpNW1Zdz09', 1),
(12, 1, '0963549779', 'Dayron', 'Ventura Galardy', 'venturadairon@gmail.com', 6, 8, 'R0NNam9ueExPZnM4enh3czBDeWlCZz09', 1),
(13, 1, '1401401342', 'Ismael', 'Tukup W', 'Wapafrank@outlook.com', 6, 8, 'N0R2VFhzS05OTU9VMEVkMDRmb0VlZz09', 1),
(14, 1, '1305720466', 'NELSON', 'MONTALVO CUENCA', 'nelson_2613@hotmail.com', 6, 5, 'V0JNOXFzMzVob2piVTFWYkVEeldKdz09', 1),
(15, 1, '1311477036', 'MIGUEL', 'BRAVO CASTRO', 'Migoangel1708@gmail.com', 6, 11, 'Mm1QcSs0T0hYSE1iQTluSm00aSs0QT09', 1),
(16, 1, '1306783950', 'JOSÉ', 'MENDOZA GARCÍA', 'mendozafilms2009@hotmail.com', 6, 3, 'S1JGa3AreE5UK2NYVWVZLzl0QXVOdz09', 1),
(17, 1, '0706387784', 'ADRIANA', 'ALVAREZ', 'adry-alvarez18@hotmail.com', 6, 2, 'MUhkVVo1T1d2TGlGdk5wejJKbngxdz09', 1),
(18, 1, '1312898868', 'CRISTOPHER', 'ZAMBRANO', 'cazo.2706@gmail.com', 6, 9, 'eGZyVDBzNHVEY3B0WnhzRUU2TTVmZz09', 1),
(19, 1, '1310687114', 'LUIS', 'PINCAY TOALA', 'ldpincay@itsup.edu.ec', 6, 4, 'NTJDdElFTE5kZzVzbmVzdWFxczkwUT09', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_area`
--

CREATE TABLE `tb_area` (
  `idarea` int(11) NOT NULL,
  `area` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_area`
--

INSERT INTO `tb_area` (`idarea`, `area`) VALUES
(1, 'Vinculación'),
(2, 'Investigación'),
(3, 'Gestión'),
(4, 'Docencia y Tutoría de Acompañamiento'),
(5, 'Aula Virtual'),
(6, 'Administrativo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_autoevaluacion`
--

CREATE TABLE `tb_autoevaluacion` (
  `idautoevaluacion` int(11) NOT NULL,
  `iddocente` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_autoevaluacion`
--

INSERT INTO `tb_autoevaluacion` (`idautoevaluacion`, `iddocente`, `estado`) VALUES
(3, 1, 1),
(4, 6, 1),
(5, 7, 1),
(6, 14, 1),
(7, 15, 1),
(8, 16, 1),
(9, 17, 1),
(10, 18, 1),
(11, 19, 1),
(12, 20, 1),
(13, 21, 1),
(14, 22, 1),
(15, 23, 1),
(16, 24, 1),
(18, 26, 1),
(19, 27, 1),
(20, 28, 1),
(21, 29, 1),
(22, 30, 1),
(23, 31, 1),
(24, 32, 1),
(25, 33, 1),
(26, 34, 1),
(27, 35, 1),
(28, 36, 1),
(29, 37, 1),
(30, 38, 1),
(31, 39, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_autoevaluacion_administrativo`
--

CREATE TABLE `tb_autoevaluacion_administrativo` (
  `idautoevaluacion` int(11) NOT NULL,
  `idadministrativo` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_autoevaluacion_administrativo`
--

INSERT INTO `tb_autoevaluacion_administrativo` (`idautoevaluacion`, `idadministrativo`, `estado`) VALUES
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1),
(16, 16, 1),
(17, 17, 1),
(18, 18, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_autoridad`
--

CREATE TABLE `tb_autoridad` (
  `idautoridad` int(11) NOT NULL,
  `tipoidentificacion` int(11) NOT NULL,
  `identificacion` varchar(25) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `idarea` int(11) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_autoridad`
--

INSERT INTO `tb_autoridad` (`idautoridad`, `tipoidentificacion`, `identificacion`, `nombres`, `apellidos`, `correo`, `idarea`, `contrasena`, `estado`) VALUES
(2, 1, '1305922088', 'ZAMBRANO SANTOS', 'ROBERTH OLMEDO', 'rzambranosantos@yahoo.es', 2, 'U0Q0R0drT2VZcGxDQTJnNVprZmJWUT09', 1),
(3, 1, '1312295130', 'SILVIA PATRICIA', 'PICO BAZURTO', 'picosilvia@hotmail.com.ar', 1, 'ckpkUEs2L3oyUURvSStacGQ3R2xjQT09', 1),
(4, 1, '1307202547', 'DEXSY MABEL', 'MÁRQUEZ TEJENA', 'mabel_marquez18@yahoo.com', 3, 'NEdIZVNyb2VCVDYySzJpbFhscE9nQT09', 1),
(5, 1, '1310786577', 'ROBERTH WILLIAM', 'ZAMBRANO DE LA TORRE', 'zroberthwilliam@hotmail.com', 4, 'bWJEQkowYkRBZDFnYzZCNDhBdFpsQT09', 1),
(6, 1, '1312400185', 'R. PATRICIO', 'ZAMBRANO UBILLÚS', 'roberthzamubi@hotmail.com', 6, 'dXVqZHRQK3JRVll6Ryt2eDFwc1I3dz09', 1),
(7, 1, '1305954529', 'SONIA', 'UBILLÚS SALTOS', 'soniaubi@live.com', 6, 'TnRrTi85bnRrR1RCVk8yVjFCUHJhQT09', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_cargo`
--

CREATE TABLE `tb_cargo` (
  `idcargo` int(11) NOT NULL,
  `cargo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_cargo`
--

INSERT INTO `tb_cargo` (`idcargo`, `cargo`) VALUES
(1, 'Secretaria'),
(2, 'Financiero'),
(3, 'Entorno Virtual de Aprendizaje'),
(4, 'Sistemas'),
(5, 'Proyectos'),
(6, 'Comunicaciones'),
(7, 'Guardia'),
(8, 'Mantenimiento'),
(9, 'Instructor de Gimnasio'),
(10, 'Asistente de Vicerrectorado'),
(11, 'Administrador del Centro de Salud');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_carrera`
--

CREATE TABLE `tb_carrera` (
  `idcarrera` int(11) NOT NULL,
  `carrera` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_carrera`
--

INSERT INTO `tb_carrera` (`idcarrera`, `carrera`) VALUES
(1, 'Técnico Superior en Enfermería'),
(2, 'Tecnología Superior en Secretariado Ejecutivo'),
(3, 'Tecnología Superior en Turismo'),
(4, 'Tecnología Superior en Desarrollo de Software'),
(5, 'Tecnología Superior en Electrónica'),
(6, 'Tecnología Superior en Asistencia en Farmacia'),
(7, 'Tecnología Superior en Emergencias Médicas (Ajuste Curricular)'),
(8, 'Tecnología Superior Universitaria en Rehabilitación Física (Nuevo Ajuste)'),
(9, 'Tecnología Superior en Emergencias Médicas (Malla 2019)'),
(10, 'Tecnología Superior en Rehabilitación Física (Malla 2020)'),
(11, 'Tecnología Superior Universitaria en Educación Inclusiva');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_coevaluacion`
--

CREATE TABLE `tb_coevaluacion` (
  `idcoevaluacion` int(11) NOT NULL,
  `idevaluador` int(11) NOT NULL,
  `iddocente` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_coevaluacion`
--

INSERT INTO `tb_coevaluacion` (`idcoevaluacion`, `idevaluador`, `iddocente`, `estado`) VALUES
(1, 1, 7, 1),
(2, 23, 36, 1),
(3, 21, 33, 1),
(4, 18, 29, 1),
(5, 30, 22, 1),
(6, 14, 17, 1),
(7, 35, 6, 1),
(8, 22, 15, 1),
(9, 20, 19, 1),
(10, 38, 39, 1),
(11, 32, 28, 1),
(12, 36, 14, 1),
(13, 27, 26, 1),
(14, 6, 24, 1),
(15, 33, 16, 1),
(17, 37, 38, 1),
(18, 28, 34, 1),
(19, 29, 1, 1),
(20, 17, 20, 1),
(22, 26, 32, 1),
(23, 39, 37, 1),
(24, 19, 21, 1),
(26, 15, 31, 1),
(27, 7, 18, 1),
(28, 24, 23, 0),
(29, 34, 30, 1),
(30, 31, 27, 1),
(31, 16, 35, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_coevaluacion_administrativo`
--

CREATE TABLE `tb_coevaluacion_administrativo` (
  `idcoevaluacion` int(11) NOT NULL,
  `idevaluador` int(11) NOT NULL,
  `idadministrativo` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_coevaluacion_administrativo`
--

INSERT INTO `tb_coevaluacion_administrativo` (`idcoevaluacion`, `idevaluador`, `idadministrativo`, `estado`) VALUES
(3, 8, 14, 1),
(4, 15, 16, 1),
(5, 4, 11, 1),
(6, 5, 8, 1),
(7, 16, 7, 1),
(8, 7, 4, 1),
(9, 14, 5, 1),
(10, 11, 13, 1),
(11, 10, 6, 1),
(12, 6, 9, 1),
(13, 17, 10, 1),
(14, 18, 12, 1),
(15, 9, 17, 1),
(16, 13, 18, 1),
(17, 12, 15, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_criterio`
--

CREATE TABLE `tb_criterio` (
  `idcriterio` int(11) NOT NULL,
  `criterio` varchar(255) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_criterio`
--

INSERT INTO `tb_criterio` (`idcriterio`, `criterio`, `estado`) VALUES
(1, 'Cédula de Identidad', 1),
(2, 'Currículum actualizado en formato ITSUP', 1),
(3, 'Título de 3er nivel', 1),
(4, 'Título(s) de 4to nivel', 1),
(5, 'Registro de títulos del Senescyt', 1),
(6, 'Mecanizado de IESS', 1),
(7, 'Certificación laboral en el área profesional específica', 1),
(8, 'Certificados de capacitación en área específica', 1),
(9, 'Sílabos actualizados y fimados', 1),
(10, 'Distribución del periodo de evaluación', 1),
(11, ' Informes y evidencias de tutorías del periodo evaluado', 1),
(12, ' Infomes y evidencias de prácticas (en escenario de simulación y reales) del periodo evaluado', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_autoevaluacion`
--

CREATE TABLE `tb_detalle_autoevaluacion` (
  `iddetalle` int(11) NOT NULL,
  `idautoevaluacion` int(11) NOT NULL,
  `indicador1` int(11) NOT NULL,
  `indicador2` int(11) NOT NULL,
  `indicador3` int(11) NOT NULL,
  `indicador4` int(11) NOT NULL,
  `indicador5` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_detalle_autoevaluacion`
--

INSERT INTO `tb_detalle_autoevaluacion` (`iddetalle`, `idautoevaluacion`, `indicador1`, `indicador2`, `indicador3`, `indicador4`, `indicador5`, `total`) VALUES
(3, 4, 20, 20, 20, 20, 20, 100),
(4, 27, 20, 20, 20, 20, 20, 100),
(5, 9, 20, 20, 20, 20, 20, 100),
(6, 25, 20, 20, 20, 20, 20, 100),
(7, 20, 20, 20, 20, 20, 20, 100),
(8, 28, 20, 20, 20, 20, 20, 100),
(9, 11, 20, 20, 20, 20, 20, 100),
(10, 14, 20, 20, 20, 20, 20, 95),
(11, 6, 20, 20, 20, 20, 20, 100),
(12, 18, 20, 20, 20, 20, 20, 100),
(13, 16, 20, 20, 20, 20, 20, 100),
(14, 23, 20, 20, 20, 20, 20, 100),
(15, 19, 20, 20, 20, 20, 20, 100),
(16, 13, 20, 20, 20, 20, 20, 100),
(17, 15, 20, 20, 20, 20, 20, 100),
(18, 21, 20, 20, 20, 20, 20, 100),
(19, 24, 20, 20, 20, 20, 20, 100),
(20, 8, 20, 20, 20, 20, 20, 100),
(21, 12, 20, 20, 20, 20, 20, 100),
(22, 22, 20, 20, 20, 20, 20, 95),
(23, 10, 20, 20, 20, 20, 20, 100),
(24, 5, 20, 20, 20, 20, 20, 100),
(25, 3, 20, 20, 20, 20, 20, 100),
(26, 26, 20, 20, 20, 20, 20, 100),
(27, 7, 20, 20, 20, 20, 20, 100),
(28, 29, 20, 20, 20, 20, 20, 100),
(29, 31, 20, 20, 20, 20, 20, 90),
(30, 30, 20, 20, 20, 20, 20, 90);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_autoevaluacion_administrativo`
--

CREATE TABLE `tb_detalle_autoevaluacion_administrativo` (
  `iddetalle` int(11) NOT NULL,
  `idautoevaluacion` int(11) NOT NULL,
  `indicador1` int(11) NOT NULL,
  `indicador2` int(11) NOT NULL,
  `indicador3` int(11) NOT NULL,
  `indicador4` int(11) NOT NULL,
  `indicador5` int(11) NOT NULL,
  `indicador6` int(11) NOT NULL,
  `indicador7` int(11) NOT NULL,
  `indicador8` int(11) NOT NULL,
  `indicador9` int(11) NOT NULL,
  `indicador10` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_detalle_autoevaluacion_administrativo`
--

INSERT INTO `tb_detalle_autoevaluacion_administrativo` (`iddetalle`, `idautoevaluacion`, `indicador1`, `indicador2`, `indicador3`, `indicador4`, `indicador5`, `indicador6`, `indicador7`, `indicador8`, `indicador9`, `indicador10`, `total`) VALUES
(5, 14, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(6, 5, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(7, 7, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '97.50'),
(8, 15, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '87.50'),
(9, 4, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '95.00'),
(10, 17, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '85.00'),
(11, 11, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '85.00'),
(12, 6, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(13, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '87.50'),
(14, 10, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '60.00'),
(15, 9, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(16, 12, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '85.00'),
(17, 13, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '85.00'),
(18, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(19, 8, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_coevaluacion`
--

CREATE TABLE `tb_detalle_coevaluacion` (
  `iddetalle` int(11) NOT NULL,
  `idcoevaluacion` int(11) NOT NULL,
  `indicador1` int(11) NOT NULL,
  `indicador2` int(11) NOT NULL,
  `indicador3` int(11) NOT NULL,
  `indicador4` int(11) NOT NULL,
  `indicador5` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_detalle_coevaluacion`
--

INSERT INTO `tb_detalle_coevaluacion` (`iddetalle`, `idcoevaluacion`, `indicador1`, `indicador2`, `indicador3`, `indicador4`, `indicador5`, `total`) VALUES
(2, 14, 20, 20, 20, 20, 20, 100),
(3, 15, 20, 20, 20, 20, 20, 100),
(4, 7, 20, 20, 20, 20, 20, 100),
(5, 12, 20, 20, 20, 20, 20, 100),
(6, 31, 20, 20, 20, 20, 20, 100),
(7, 18, 20, 20, 20, 20, 20, 100),
(8, 8, 20, 20, 20, 20, 20, 95),
(9, 20, 20, 20, 20, 20, 20, 100),
(10, 13, 20, 20, 20, 20, 20, 95),
(11, 24, 20, 20, 20, 20, 20, 80),
(12, 1, 20, 20, 20, 20, 20, 100),
(13, 29, 20, 20, 20, 20, 20, 100),
(14, 27, 20, 20, 20, 20, 20, 100),
(15, 30, 20, 20, 20, 20, 20, 100),
(16, 6, 20, 20, 20, 20, 20, 100),
(17, 26, 20, 20, 20, 20, 20, 100),
(18, 3, 20, 20, 20, 20, 20, 95),
(19, 5, 20, 20, 20, 20, 20, 100),
(20, 17, 20, 20, 20, 20, 20, 100),
(21, 9, 20, 20, 20, 20, 20, 100),
(22, 19, 20, 20, 20, 20, 20, 100),
(23, 2, 20, 20, 20, 20, 20, 100),
(24, 4, 20, 20, 20, 20, 20, 100),
(25, 23, 20, 20, 20, 20, 20, 95),
(26, 10, 20, 20, 20, 20, 20, 95),
(27, 11, 20, 20, 20, 20, 20, 100),
(28, 22, 20, 20, 20, 20, 20, 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_coevaluacion_administrativo`
--

CREATE TABLE `tb_detalle_coevaluacion_administrativo` (
  `iddetalle` int(11) NOT NULL,
  `idcoevaluacion` int(11) NOT NULL,
  `indicador1` int(11) NOT NULL,
  `indicador2` int(11) NOT NULL,
  `indicador3` int(11) NOT NULL,
  `indicador4` int(11) NOT NULL,
  `indicador5` int(11) NOT NULL,
  `indicador6` int(11) NOT NULL,
  `indicador7` int(11) NOT NULL,
  `indicador8` int(11) NOT NULL,
  `indicador9` int(11) NOT NULL,
  `indicador10` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_detalle_coevaluacion_administrativo`
--

INSERT INTO `tb_detalle_coevaluacion_administrativo` (`iddetalle`, `idcoevaluacion`, `indicador1`, `indicador2`, `indicador3`, `indicador4`, `indicador5`, `indicador6`, `indicador7`, `indicador8`, `indicador9`, `indicador10`, `total`) VALUES
(3, 5, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(4, 10, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '77.50'),
(5, 7, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '77.50'),
(6, 11, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '72.50'),
(7, 12, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(8, 13, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(9, 15, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(10, 4, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '75.00'),
(11, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '52.50'),
(12, 9, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(13, 8, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(14, 14, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '90.00'),
(15, 6, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00'),
(16, 17, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '95.00'),
(17, 3, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '100.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_evaluacion_estudiante`
--

CREATE TABLE `tb_detalle_evaluacion_estudiante` (
  `iddetalle` int(11) NOT NULL,
  `idevaluacion` int(11) NOT NULL,
  `indicador1` int(11) NOT NULL,
  `indicador2` int(11) NOT NULL,
  `indicador3` int(11) NOT NULL,
  `indicador4` int(11) NOT NULL,
  `indicador5` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_detalle_evaluacion_estudiante`
--

INSERT INTO `tb_detalle_evaluacion_estudiante` (`iddetalle`, `idevaluacion`, `indicador1`, `indicador2`, `indicador3`, `indicador4`, `indicador5`, `total`) VALUES
(3, 167, 20, 20, 20, 20, 20, 100),
(4, 139, 20, 20, 20, 20, 20, 100),
(5, 91, 20, 20, 20, 20, 20, 100),
(6, 153, 20, 20, 20, 20, 20, 100),
(7, 181, 20, 20, 20, 20, 20, 100),
(8, 106, 20, 20, 20, 20, 20, 80),
(9, 134, 20, 20, 20, 20, 20, 100),
(10, 148, 20, 20, 20, 20, 20, 100),
(11, 162, 20, 20, 20, 20, 20, 100),
(12, 334, 20, 20, 20, 20, 20, 100),
(13, 360, 20, 20, 20, 20, 20, 100),
(14, 176, 20, 20, 20, 20, 20, 80),
(15, 308, 20, 20, 20, 20, 20, 100),
(16, 282, 20, 20, 20, 20, 20, 100),
(17, 256, 20, 20, 20, 20, 20, 75),
(18, 953, 20, 20, 20, 20, 20, 90),
(19, 957, 20, 20, 20, 20, 20, 100),
(20, 240, 20, 20, 20, 20, 20, 75),
(21, 135, 20, 20, 20, 20, 20, 100),
(22, 266, 20, 20, 20, 20, 20, 95),
(23, 961, 20, 20, 20, 20, 20, 100),
(24, 635, 20, 20, 20, 20, 20, 100),
(25, 190, 20, 20, 20, 20, 20, 100),
(26, 202, 20, 20, 20, 20, 20, 100),
(27, 292, 20, 20, 20, 20, 20, 85),
(28, 214, 20, 20, 20, 20, 20, 100),
(29, 965, 20, 20, 20, 20, 20, 100),
(30, 226, 20, 20, 20, 20, 20, 100),
(31, 519, 20, 20, 20, 20, 20, 75),
(32, 318, 20, 20, 20, 20, 20, 80),
(33, 344, 20, 20, 20, 20, 20, 100),
(34, 623, 20, 20, 20, 20, 20, 100),
(35, 597, 20, 20, 20, 20, 20, 75),
(36, 149, 20, 20, 20, 20, 20, 100),
(37, 545, 20, 20, 20, 20, 20, 100),
(38, 571, 20, 20, 20, 20, 20, 75),
(39, 138, 20, 20, 20, 20, 20, 100),
(40, 525, 20, 20, 20, 20, 20, 75),
(41, 152, 20, 20, 20, 20, 20, 100),
(42, 551, 20, 20, 20, 20, 20, 100),
(43, 577, 20, 20, 20, 20, 20, 75),
(44, 518, 20, 20, 20, 20, 20, 75),
(45, 166, 20, 20, 20, 20, 20, 100),
(46, 628, 20, 20, 20, 20, 20, 100),
(47, 180, 20, 20, 20, 20, 20, 75),
(48, 163, 20, 20, 20, 20, 20, 100),
(49, 602, 20, 20, 20, 20, 20, 100),
(50, 576, 20, 20, 20, 20, 20, 100),
(51, 544, 20, 20, 20, 20, 20, 100),
(52, 177, 20, 20, 20, 20, 20, 100),
(53, 603, 20, 20, 20, 20, 20, 75),
(54, 550, 20, 20, 20, 20, 20, 100),
(55, 136, 20, 20, 20, 20, 20, 5),
(56, 629, 20, 20, 20, 20, 20, 95),
(57, 524, 20, 20, 20, 20, 20, 100),
(58, 150, 20, 20, 20, 20, 20, 20),
(59, 570, 20, 20, 20, 20, 20, 80),
(60, 119, 20, 20, 20, 20, 20, 100),
(61, 123, 20, 20, 20, 20, 20, 25),
(62, 596, 20, 20, 20, 20, 20, 90),
(63, 164, 20, 20, 20, 20, 20, 25),
(64, 622, 20, 20, 20, 20, 20, 100),
(65, 504, 20, 20, 20, 20, 20, 100),
(66, 178, 20, 20, 20, 20, 20, 25),
(67, 120, 20, 20, 20, 20, 20, 100),
(68, 530, 20, 20, 20, 20, 20, 100),
(69, 124, 20, 20, 20, 20, 20, 50),
(70, 556, 20, 20, 20, 20, 20, 100),
(71, 582, 20, 20, 20, 20, 20, 100),
(72, 608, 20, 20, 20, 20, 20, 100),
(73, 121, 20, 20, 20, 20, 20, 100),
(74, 125, 20, 20, 20, 20, 20, 25),
(75, 845, 20, 20, 20, 20, 20, 100),
(76, 873, 20, 20, 20, 20, 20, 100),
(77, 122, 20, 20, 20, 20, 20, 100),
(78, 794, 20, 20, 20, 20, 20, 80),
(79, 510, 20, 20, 20, 20, 20, 95),
(80, 822, 20, 20, 20, 20, 20, 100),
(81, 526, 20, 20, 20, 20, 20, 100),
(82, 536, 20, 20, 20, 20, 20, 100),
(83, 126, 20, 20, 20, 20, 20, 0),
(84, 234, 20, 20, 20, 20, 20, 100),
(85, 850, 20, 20, 20, 20, 20, 100),
(86, 260, 20, 20, 20, 20, 20, 100),
(87, 552, 20, 20, 20, 20, 20, 100),
(88, 562, 20, 20, 20, 20, 20, 100),
(89, 878, 20, 20, 20, 20, 20, 100),
(90, 817, 20, 20, 20, 20, 20, 100),
(91, 286, 20, 20, 20, 20, 20, 100),
(92, 578, 20, 20, 20, 20, 20, 100),
(93, 588, 20, 20, 20, 20, 20, 100),
(94, 604, 20, 20, 20, 20, 20, 100),
(95, 312, 20, 20, 20, 20, 20, 100),
(96, 614, 20, 20, 20, 20, 20, 100),
(97, 338, 20, 20, 20, 20, 20, 100),
(98, 630, 20, 20, 20, 20, 20, 100),
(99, 906, 20, 20, 20, 20, 20, 85),
(100, 901, 20, 20, 20, 20, 20, 75),
(101, 934, 20, 20, 20, 20, 20, 75),
(102, 131, 20, 20, 20, 20, 20, 100),
(103, 145, 20, 20, 20, 20, 20, 100),
(104, 929, 20, 20, 20, 20, 20, 100),
(105, 506, 20, 20, 20, 20, 20, 65),
(106, 790, 20, 20, 20, 20, 20, 100),
(107, 789, 20, 20, 20, 20, 20, 90),
(108, 532, 20, 20, 20, 20, 20, 100),
(109, 818, 20, 20, 20, 20, 20, 100),
(110, 159, 20, 20, 20, 20, 20, 25),
(111, 846, 20, 20, 20, 20, 20, 100),
(112, 811, 20, 20, 20, 20, 20, 30),
(113, 558, 20, 20, 20, 20, 20, 90),
(114, 874, 20, 20, 20, 20, 20, 100),
(115, 173, 20, 20, 20, 20, 20, 25),
(116, 584, 20, 20, 20, 20, 20, 100),
(117, 246, 20, 20, 20, 20, 20, 95),
(118, 902, 20, 20, 20, 20, 20, 100),
(119, 272, 20, 20, 20, 20, 20, 75),
(120, 610, 20, 20, 20, 20, 20, 95),
(121, 930, 20, 20, 20, 20, 20, 100),
(122, 298, 20, 20, 20, 20, 20, 100),
(123, 839, 20, 20, 20, 20, 20, 100),
(124, 324, 20, 20, 20, 20, 20, 100),
(125, 127, 20, 20, 20, 20, 20, 100),
(126, 867, 20, 20, 20, 20, 20, 100),
(127, 141, 20, 20, 20, 20, 20, 100),
(128, 895, 20, 20, 20, 20, 20, 100),
(129, 155, 20, 20, 20, 20, 20, 75),
(130, 350, 20, 20, 20, 20, 20, 100),
(131, 923, 20, 20, 20, 20, 20, 100),
(132, 169, 20, 20, 20, 20, 20, 100),
(133, 951, 20, 20, 20, 20, 20, 100),
(134, 793, 20, 20, 20, 20, 20, 25),
(135, 821, 20, 20, 20, 20, 20, 100),
(136, 522, 20, 20, 20, 20, 20, 90),
(137, 522, 20, 20, 20, 20, 20, 90),
(138, 849, 20, 20, 20, 20, 20, 100),
(139, 877, 20, 20, 20, 20, 20, 100),
(140, 802, 20, 20, 20, 20, 20, 100),
(141, 905, 20, 20, 20, 20, 20, 100),
(142, 933, 20, 20, 20, 20, 20, 100),
(143, 830, 20, 20, 20, 20, 20, 100),
(144, 130, 20, 20, 20, 20, 20, 100),
(145, 144, 20, 20, 20, 20, 20, 100),
(146, 158, 20, 20, 20, 20, 20, 100),
(147, 172, 20, 20, 20, 20, 20, 100),
(148, 858, 20, 20, 20, 20, 20, 100),
(149, 886, 20, 20, 20, 20, 20, 100),
(150, 914, 20, 20, 20, 20, 20, 100),
(151, 942, 20, 20, 20, 20, 20, 100),
(152, 842, 20, 20, 20, 20, 20, 100),
(153, 786, 20, 20, 20, 20, 20, 100),
(154, 814, 20, 20, 20, 20, 20, 100),
(155, 870, 20, 20, 20, 20, 20, 100),
(156, 898, 20, 20, 20, 20, 20, 100),
(157, 926, 20, 20, 20, 20, 20, 100),
(158, 791, 20, 20, 20, 20, 20, 50),
(159, 819, 20, 20, 20, 20, 20, 50),
(160, 847, 20, 20, 20, 20, 20, 100),
(161, 875, 20, 20, 20, 20, 20, 100),
(162, 903, 20, 20, 20, 20, 20, 100),
(163, 931, 20, 20, 20, 20, 20, 100),
(164, 232, 20, 20, 20, 20, 20, 100),
(165, 133, 20, 20, 20, 20, 20, 100),
(166, 147, 20, 20, 20, 20, 20, 100),
(167, 258, 20, 20, 20, 20, 20, 100),
(168, 788, 20, 20, 20, 20, 20, 100),
(169, 161, 20, 20, 20, 20, 20, 100),
(170, 284, 20, 20, 20, 20, 20, 100),
(171, 803, 20, 20, 20, 20, 20, 75),
(172, 175, 20, 20, 20, 20, 20, 100),
(173, 816, 20, 20, 20, 20, 20, 100),
(174, 310, 20, 20, 20, 20, 20, 100),
(175, 831, 20, 20, 20, 20, 20, 100),
(176, 787, 20, 20, 20, 20, 20, 100),
(177, 336, 20, 20, 20, 20, 20, 100),
(178, 859, 20, 20, 20, 20, 20, 100),
(179, 844, 20, 20, 20, 20, 20, 100),
(180, 887, 20, 20, 20, 20, 20, 100),
(181, 872, 20, 20, 20, 20, 20, 100),
(182, 815, 20, 20, 20, 20, 20, 100),
(183, 915, 20, 20, 20, 20, 20, 100),
(184, 943, 20, 20, 20, 20, 20, 100),
(185, 843, 20, 20, 20, 20, 20, 100),
(186, 900, 20, 20, 20, 20, 20, 100),
(187, 871, 20, 20, 20, 20, 20, 100),
(188, 928, 20, 20, 20, 20, 20, 100),
(189, 899, 20, 20, 20, 20, 20, 100),
(190, 927, 20, 20, 20, 20, 20, 100),
(191, 129, 20, 20, 20, 20, 20, 100),
(192, 143, 20, 20, 20, 20, 20, 100),
(193, 157, 20, 20, 20, 20, 20, 100),
(194, 171, 20, 20, 20, 20, 20, 100),
(195, 233, 20, 20, 20, 20, 20, 25),
(196, 259, 20, 20, 20, 20, 20, 100),
(197, 285, 20, 20, 20, 20, 20, 60),
(198, 311, 20, 20, 20, 20, 20, 100),
(199, 810, 20, 20, 20, 20, 20, 100),
(200, 337, 20, 20, 20, 20, 20, 100),
(201, 838, 20, 20, 20, 20, 20, 100),
(202, 866, 20, 20, 20, 20, 20, 100),
(203, 894, 20, 20, 20, 20, 20, 100),
(204, 922, 20, 20, 20, 20, 20, 100),
(205, 950, 20, 20, 20, 20, 20, 100),
(206, 242, 20, 20, 20, 20, 20, 100),
(207, 268, 20, 20, 20, 20, 20, 100),
(208, 294, 20, 20, 20, 20, 20, 100),
(209, 320, 20, 20, 20, 20, 20, 100),
(210, 346, 20, 20, 20, 20, 20, 100),
(211, 244, 20, 20, 20, 20, 20, 95),
(212, 270, 20, 20, 20, 20, 20, 100),
(213, 296, 20, 20, 20, 20, 20, 95),
(214, 322, 20, 20, 20, 20, 20, 100),
(215, 348, 20, 20, 20, 20, 20, 100),
(216, 808, 20, 20, 20, 20, 20, 75),
(217, 836, 20, 20, 20, 20, 20, 75),
(218, 509, 20, 20, 20, 20, 20, 100),
(219, 864, 20, 20, 20, 20, 20, 100),
(220, 535, 20, 20, 20, 20, 20, 100),
(221, 561, 20, 20, 20, 20, 20, 100),
(222, 587, 20, 20, 20, 20, 20, 65),
(223, 613, 20, 20, 20, 20, 20, 100),
(224, 243, 20, 20, 20, 20, 20, 95),
(225, 892, 20, 20, 20, 20, 20, 100),
(226, 335, 20, 20, 20, 20, 20, 100),
(227, 283, 20, 20, 20, 20, 20, 100),
(228, 269, 20, 20, 20, 20, 20, 100),
(229, 295, 20, 20, 20, 20, 20, 100),
(230, 231, 20, 20, 20, 20, 20, 90),
(231, 257, 20, 20, 20, 20, 20, 100),
(232, 321, 20, 20, 20, 20, 20, 100),
(233, 309, 20, 20, 20, 20, 20, 100),
(234, 920, 20, 20, 20, 20, 20, 50),
(235, 250, 20, 20, 20, 20, 20, 100),
(236, 347, 20, 20, 20, 20, 20, 100),
(237, 948, 20, 20, 20, 20, 20, 75),
(238, 276, 20, 20, 20, 20, 20, 100),
(239, 236, 20, 20, 20, 20, 20, 40),
(240, 302, 20, 20, 20, 20, 20, 100),
(241, 262, 20, 20, 20, 20, 20, 45),
(242, 354, 20, 20, 20, 20, 20, 100),
(243, 288, 20, 20, 20, 20, 20, 45),
(244, 328, 20, 20, 20, 20, 20, 100),
(245, 314, 20, 20, 20, 20, 20, 50),
(246, 340, 20, 20, 20, 20, 20, 100),
(247, 248, 20, 20, 20, 20, 20, 25),
(248, 274, 20, 20, 20, 20, 20, 100),
(249, 300, 20, 20, 20, 20, 20, 50),
(250, 326, 20, 20, 20, 20, 20, 100),
(251, 352, 20, 20, 20, 20, 20, 100),
(252, 239, 20, 20, 20, 20, 20, 95),
(253, 265, 20, 20, 20, 20, 20, 95),
(254, 291, 20, 20, 20, 20, 20, 100),
(255, 317, 20, 20, 20, 20, 20, 95),
(256, 343, 20, 20, 20, 20, 20, 100),
(257, 520, 20, 20, 20, 20, 20, 100),
(258, 546, 20, 20, 20, 20, 20, 100),
(259, 572, 20, 20, 20, 20, 20, 100),
(260, 598, 20, 20, 20, 20, 20, 100),
(261, 624, 20, 20, 20, 20, 20, 100),
(262, 255, 20, 20, 20, 20, 20, 100),
(263, 281, 20, 20, 20, 20, 20, 100),
(264, 523, 20, 20, 20, 20, 20, 100),
(265, 529, 20, 20, 20, 20, 20, 100),
(266, 307, 20, 20, 20, 20, 20, 100),
(267, 555, 20, 20, 20, 20, 20, 100),
(268, 333, 20, 20, 20, 20, 20, 100),
(269, 359, 20, 20, 20, 20, 20, 100),
(270, 508, 20, 20, 20, 20, 20, 100),
(271, 581, 20, 20, 20, 20, 20, 100),
(272, 534, 20, 20, 20, 20, 20, 100),
(273, 607, 20, 20, 20, 20, 20, 100),
(274, 560, 20, 20, 20, 20, 20, 100),
(275, 633, 20, 20, 20, 20, 20, 100),
(276, 586, 20, 20, 20, 20, 20, 100),
(277, 549, 20, 20, 20, 20, 20, 70),
(278, 612, 20, 20, 20, 20, 20, 100),
(279, 575, 20, 20, 20, 20, 20, 100),
(280, 601, 20, 20, 20, 20, 20, 95),
(281, 627, 20, 20, 20, 20, 20, 75),
(282, 503, 20, 20, 20, 20, 20, 100),
(283, 499, 20, 20, 20, 20, 20, 100),
(284, 985, 20, 20, 20, 20, 20, 75),
(285, 500, 20, 20, 20, 20, 20, 70),
(286, 995, 20, 20, 20, 20, 20, 100),
(287, 501, 20, 20, 20, 20, 20, 95),
(288, 1005, 20, 20, 20, 20, 20, 100),
(289, 502, 20, 20, 20, 20, 20, 90),
(290, 1015, 20, 20, 20, 20, 20, 100),
(291, 983, 20, 20, 20, 20, 20, 95),
(292, 531, 20, 20, 20, 20, 20, 30),
(293, 993, 20, 20, 20, 20, 20, 95),
(294, 1025, 20, 20, 20, 20, 20, 100),
(295, 505, 20, 20, 20, 20, 20, 100),
(296, 1003, 20, 20, 20, 20, 20, 95),
(297, 1013, 20, 20, 20, 20, 20, 95),
(298, 557, 20, 20, 20, 20, 20, 100),
(299, 1023, 20, 20, 20, 20, 20, 90),
(300, 583, 20, 20, 20, 20, 20, 75),
(301, 1035, 20, 20, 20, 20, 20, 80),
(302, 609, 20, 20, 20, 20, 20, 45),
(303, 1045, 20, 20, 20, 20, 20, 90),
(304, 1033, 20, 20, 20, 20, 20, 85),
(305, 1043, 20, 20, 20, 20, 20, 95),
(306, 646, 20, 20, 20, 20, 20, 100),
(307, 657, 20, 20, 20, 20, 20, 100),
(308, 668, 20, 20, 20, 20, 20, 100),
(309, 679, 20, 20, 20, 20, 20, 100),
(310, 690, 20, 20, 20, 20, 20, 100),
(311, 271, 20, 20, 20, 20, 20, 100),
(312, 245, 20, 20, 20, 20, 20, 100),
(313, 297, 20, 20, 20, 20, 20, 100),
(314, 323, 20, 20, 20, 20, 20, 100),
(315, 349, 20, 20, 20, 20, 20, 100),
(316, 988, 20, 20, 20, 20, 20, 100),
(317, 785, 20, 20, 20, 20, 20, 100),
(318, 813, 20, 20, 20, 20, 20, 100),
(319, 841, 20, 20, 20, 20, 20, 75),
(320, 869, 20, 20, 20, 20, 20, 75),
(321, 998, 20, 20, 20, 20, 20, 100),
(322, 897, 20, 20, 20, 20, 20, 80),
(323, 925, 20, 20, 20, 20, 20, 100),
(324, 516, 20, 20, 20, 20, 20, 80),
(325, 542, 20, 20, 20, 20, 20, 100),
(326, 568, 20, 20, 20, 20, 20, 75),
(327, 594, 20, 20, 20, 20, 20, 100),
(328, 620, 20, 20, 20, 20, 20, 100),
(329, 1018, 20, 20, 20, 20, 20, 100),
(330, 1008, 20, 20, 20, 20, 20, 100),
(331, 1038, 20, 20, 20, 20, 20, 100),
(332, 1028, 20, 20, 20, 20, 20, 100),
(333, 1048, 20, 20, 20, 20, 20, 100),
(334, 363, 20, 20, 20, 20, 20, 100),
(335, 432, 20, 20, 20, 20, 20, 100),
(336, 455, 20, 20, 20, 20, 20, 100),
(337, 478, 20, 20, 20, 20, 20, 100),
(338, 386, 20, 20, 20, 20, 20, 100),
(339, 75, 20, 20, 20, 20, 20, 100),
(340, 80, 20, 20, 20, 20, 20, 100),
(341, 85, 20, 20, 20, 20, 20, 100),
(342, 211, 20, 20, 20, 20, 20, 100),
(343, 223, 20, 20, 20, 20, 20, 100),
(344, 199, 20, 20, 20, 20, 20, 100),
(345, 187, 20, 20, 20, 20, 20, 100),
(346, 433, 20, 20, 20, 20, 20, 100),
(347, 410, 20, 20, 20, 20, 20, 80),
(348, 805, 20, 20, 20, 20, 20, 100),
(349, 833, 20, 20, 20, 20, 20, 100),
(350, 861, 20, 20, 20, 20, 20, 100),
(351, 889, 20, 20, 20, 20, 20, 100),
(352, 917, 20, 20, 20, 20, 20, 100),
(353, 945, 20, 20, 20, 20, 20, 100),
(354, 507, 20, 20, 20, 20, 20, 45),
(355, 533, 20, 20, 20, 20, 20, 100),
(356, 559, 20, 20, 20, 20, 20, 40),
(357, 585, 20, 20, 20, 20, 20, 40),
(358, 611, 20, 20, 20, 20, 20, 65),
(359, 515, 20, 20, 20, 20, 20, 95),
(360, 541, 20, 20, 20, 20, 20, 95),
(361, 593, 20, 20, 20, 20, 20, 85),
(362, 567, 20, 20, 20, 20, 20, 95),
(363, 619, 20, 20, 20, 20, 20, 90),
(364, 987, 20, 20, 20, 20, 20, 100),
(365, 1007, 20, 20, 20, 20, 20, 95),
(366, 1017, 20, 20, 20, 20, 20, 100),
(367, 1027, 20, 20, 20, 20, 20, 90),
(368, 1037, 20, 20, 20, 20, 20, 85),
(369, 807, 20, 20, 20, 20, 20, 100),
(370, 835, 20, 20, 20, 20, 20, 100),
(371, 863, 20, 20, 20, 20, 20, 100),
(372, 891, 20, 20, 20, 20, 20, 100),
(373, 919, 20, 20, 20, 20, 20, 100),
(374, 947, 20, 20, 20, 20, 20, 100),
(375, 984, 20, 20, 20, 20, 20, 100),
(376, 994, 20, 20, 20, 20, 20, 100),
(377, 1004, 20, 20, 20, 20, 20, 100),
(378, 1014, 20, 20, 20, 20, 20, 100),
(379, 1024, 20, 20, 20, 20, 20, 100),
(380, 1034, 20, 20, 20, 20, 20, 100),
(381, 1044, 20, 20, 20, 20, 20, 100),
(382, 643, 20, 20, 20, 20, 20, 75),
(383, 654, 20, 20, 20, 20, 20, 100),
(384, 665, 20, 20, 20, 20, 20, 100),
(385, 676, 20, 20, 20, 20, 20, 50),
(386, 687, 20, 20, 20, 20, 20, 50),
(387, 698, 20, 20, 20, 20, 20, 25),
(388, 637, 20, 20, 20, 20, 20, 50),
(389, 648, 20, 20, 20, 20, 20, 100),
(390, 659, 20, 20, 20, 20, 20, 100),
(391, 670, 20, 20, 20, 20, 20, 0),
(392, 681, 20, 20, 20, 20, 20, 25),
(393, 692, 20, 20, 20, 20, 20, 25),
(394, 644, 20, 20, 20, 20, 20, 50),
(395, 655, 20, 20, 20, 20, 20, 100),
(396, 666, 20, 20, 20, 20, 20, 100),
(397, 677, 20, 20, 20, 20, 20, 25),
(398, 688, 20, 20, 20, 20, 20, 25),
(399, 699, 20, 20, 20, 20, 20, 25),
(400, 640, 20, 20, 20, 20, 20, 75),
(401, 651, 20, 20, 20, 20, 20, 100),
(402, 662, 20, 20, 20, 20, 20, 100),
(403, 673, 20, 20, 20, 20, 20, 25),
(404, 684, 20, 20, 20, 20, 20, 25),
(405, 695, 20, 20, 20, 20, 20, 25),
(406, 636, 20, 20, 20, 20, 20, 75),
(407, 647, 20, 20, 20, 20, 20, 100),
(408, 658, 20, 20, 20, 20, 20, 100),
(409, 669, 20, 20, 20, 20, 20, 25),
(410, 680, 20, 20, 20, 20, 20, 25),
(411, 691, 20, 20, 20, 20, 20, 25),
(412, 639, 20, 20, 20, 20, 20, 75),
(413, 650, 20, 20, 20, 20, 20, 100),
(414, 661, 20, 20, 20, 20, 20, 100),
(415, 672, 20, 20, 20, 20, 20, 25),
(416, 683, 20, 20, 20, 20, 20, 25),
(417, 694, 20, 20, 20, 20, 20, 25),
(418, 642, 20, 20, 20, 20, 20, 75),
(419, 653, 20, 20, 20, 20, 20, 100),
(420, 664, 20, 20, 20, 20, 20, 100),
(421, 675, 20, 20, 20, 20, 20, 25),
(422, 686, 20, 20, 20, 20, 20, 25),
(423, 697, 20, 20, 20, 20, 20, 25),
(424, 641, 20, 20, 20, 20, 20, 100),
(425, 652, 20, 20, 20, 20, 20, 100),
(426, 663, 20, 20, 20, 20, 20, 100),
(427, 674, 20, 20, 20, 20, 20, 50),
(428, 685, 20, 20, 20, 20, 20, 50),
(429, 696, 20, 20, 20, 20, 20, 50),
(430, 90, 20, 20, 20, 20, 20, 100),
(431, 105, 20, 20, 20, 20, 20, 100),
(432, 860, 20, 20, 20, 20, 20, 100),
(433, 888, 20, 20, 20, 20, 20, 100),
(434, 916, 20, 20, 20, 20, 20, 100),
(435, 916, 20, 20, 20, 20, 20, 100),
(436, 944, 20, 20, 20, 20, 20, 50),
(437, 832, 20, 20, 20, 20, 20, 100),
(438, 804, 20, 20, 20, 20, 20, 100),
(439, 92, 20, 20, 20, 20, 20, 100),
(440, 100, 20, 20, 20, 20, 20, 100),
(441, 115, 20, 20, 20, 20, 20, 75),
(442, 107, 20, 20, 20, 20, 20, 65),
(443, 98, 20, 20, 20, 20, 20, 100),
(444, 113, 20, 20, 20, 20, 20, 75),
(445, 97, 20, 20, 20, 20, 20, 100),
(446, 112, 20, 20, 20, 20, 20, 100),
(447, 436, 20, 20, 20, 20, 20, 100),
(448, 96, 20, 20, 20, 20, 20, 100),
(449, 111, 20, 20, 20, 20, 20, 100),
(450, 463, 20, 20, 20, 20, 20, 100),
(451, 440, 20, 20, 20, 20, 20, 100),
(452, 486, 20, 20, 20, 20, 20, 100),
(453, 371, 20, 20, 20, 20, 20, 100),
(454, 394, 20, 20, 20, 20, 20, 100),
(455, 99, 20, 20, 20, 20, 20, 100),
(456, 114, 20, 20, 20, 20, 20, 75),
(457, 365, 20, 20, 20, 20, 20, 100),
(458, 388, 20, 20, 20, 20, 20, 100),
(459, 411, 20, 20, 20, 20, 20, 100),
(460, 434, 20, 20, 20, 20, 20, 100),
(461, 368, 20, 20, 20, 20, 20, 100),
(462, 457, 20, 20, 20, 20, 20, 100),
(463, 480, 20, 20, 20, 20, 20, 100),
(464, 391, 20, 20, 20, 20, 20, 100),
(465, 437, 20, 20, 20, 20, 20, 100),
(466, 460, 20, 20, 20, 20, 20, 100),
(467, 483, 20, 20, 20, 20, 20, 100),
(468, 382, 20, 20, 20, 20, 20, 25),
(469, 405, 20, 20, 20, 20, 20, 25),
(470, 414, 20, 20, 20, 20, 20, 60),
(471, 428, 20, 20, 20, 20, 20, 25),
(472, 451, 20, 20, 20, 20, 20, 100),
(473, 474, 20, 20, 20, 20, 20, 100),
(474, 379, 20, 20, 20, 20, 20, 100),
(475, 497, 20, 20, 20, 20, 20, 100),
(476, 402, 20, 20, 20, 20, 20, 100),
(477, 418, 20, 20, 20, 20, 20, 25),
(478, 441, 20, 20, 20, 20, 20, 100),
(479, 464, 20, 20, 20, 20, 20, 100),
(480, 487, 20, 20, 20, 20, 20, 95),
(481, 425, 20, 20, 20, 20, 20, 100),
(482, 372, 20, 20, 20, 20, 20, 80),
(483, 448, 20, 20, 20, 20, 20, 100),
(484, 395, 20, 20, 20, 20, 20, 90),
(485, 471, 20, 20, 20, 20, 20, 100),
(486, 494, 20, 20, 20, 20, 20, 100),
(487, 374, 20, 20, 20, 20, 20, 100),
(488, 397, 20, 20, 20, 20, 20, 75),
(489, 420, 20, 20, 20, 20, 20, 50),
(490, 443, 20, 20, 20, 20, 20, 100),
(491, 466, 20, 20, 20, 20, 20, 100),
(492, 489, 20, 20, 20, 20, 20, 75),
(493, 370, 20, 20, 20, 20, 20, 100),
(494, 393, 20, 20, 20, 20, 20, 100),
(495, 416, 20, 20, 20, 20, 20, 95),
(496, 439, 20, 20, 20, 20, 20, 100),
(497, 462, 20, 20, 20, 20, 20, 100),
(498, 485, 20, 20, 20, 20, 20, 100),
(499, 377, 20, 20, 20, 20, 20, 100),
(500, 422, 20, 20, 20, 20, 20, 100),
(501, 445, 20, 20, 20, 20, 20, 100),
(502, 400, 20, 20, 20, 20, 20, 100),
(503, 491, 20, 20, 20, 20, 20, 100),
(504, 376, 20, 20, 20, 20, 20, 100),
(505, 423, 20, 20, 20, 20, 20, 85),
(506, 446, 20, 20, 20, 20, 20, 100),
(507, 469, 20, 20, 20, 20, 20, 100),
(508, 492, 20, 20, 20, 20, 20, 100),
(509, 380, 20, 20, 20, 20, 20, 100),
(510, 403, 20, 20, 20, 20, 20, 100),
(511, 426, 20, 20, 20, 20, 20, 100),
(512, 449, 20, 20, 20, 20, 20, 100),
(513, 472, 20, 20, 20, 20, 20, 100),
(514, 495, 20, 20, 20, 20, 20, 100),
(515, 479, 20, 20, 20, 20, 20, 100),
(516, 387, 20, 20, 20, 20, 20, 100),
(517, 364, 20, 20, 20, 20, 20, 100),
(518, 456, 20, 20, 20, 20, 20, 100),
(519, 378, 20, 20, 20, 20, 20, 100),
(520, 401, 20, 20, 20, 20, 20, 100),
(521, 424, 20, 20, 20, 20, 20, 85),
(522, 447, 20, 20, 20, 20, 20, 100),
(523, 470, 20, 20, 20, 20, 20, 100),
(524, 383, 20, 20, 20, 20, 20, 50),
(525, 493, 20, 20, 20, 20, 20, 100),
(526, 406, 20, 20, 20, 20, 20, 50),
(527, 429, 20, 20, 20, 20, 20, 50),
(528, 452, 20, 20, 20, 20, 20, 50),
(529, 475, 20, 20, 20, 20, 20, 50),
(530, 498, 20, 20, 20, 20, 20, 75),
(531, 435, 20, 20, 20, 20, 20, 100),
(532, 366, 20, 20, 20, 20, 20, 100),
(533, 417, 20, 20, 20, 20, 20, 0),
(534, 95, 20, 20, 20, 20, 20, 75),
(535, 110, 20, 20, 20, 20, 20, 75),
(536, 210, 20, 20, 20, 20, 20, 100),
(537, 222, 20, 20, 20, 20, 20, 100),
(538, 184, 20, 20, 20, 20, 20, 85),
(539, 196, 20, 20, 20, 20, 20, 90),
(540, 208, 20, 20, 20, 20, 20, 95),
(541, 220, 20, 20, 20, 20, 20, 95),
(542, 702, 20, 20, 20, 20, 20, 65),
(543, 742, 20, 20, 20, 20, 20, 100),
(544, 705, 20, 20, 20, 20, 20, 75),
(545, 711, 20, 20, 20, 20, 20, 100),
(546, 728, 20, 20, 20, 20, 20, 100),
(547, 719, 20, 20, 20, 20, 20, 100),
(548, 722, 20, 20, 20, 20, 20, 100),
(549, 736, 20, 20, 20, 20, 20, 100),
(550, 759, 20, 20, 20, 20, 20, 100),
(551, 739, 20, 20, 20, 20, 20, 100),
(552, 745, 20, 20, 20, 20, 20, 100),
(553, 753, 20, 20, 20, 20, 20, 100),
(554, 700, 20, 20, 20, 20, 20, 100),
(555, 774, 20, 20, 20, 20, 20, 100),
(556, 776, 20, 20, 20, 20, 20, 100),
(557, 756, 20, 20, 20, 20, 20, 100),
(558, 770, 20, 20, 20, 20, 20, 100),
(559, 762, 20, 20, 20, 20, 20, 100),
(560, 733, 20, 20, 20, 20, 20, 100),
(561, 757, 20, 20, 20, 20, 20, 100),
(562, 717, 20, 20, 20, 20, 20, 100),
(563, 707, 20, 20, 20, 20, 20, 100),
(564, 779, 20, 20, 20, 20, 20, 100),
(565, 740, 20, 20, 20, 20, 20, 100),
(566, 773, 20, 20, 20, 20, 20, 100),
(567, 767, 20, 20, 20, 20, 20, 100),
(568, 723, 20, 20, 20, 20, 20, 100),
(569, 704, 20, 20, 20, 20, 20, 95),
(570, 724, 20, 20, 20, 20, 20, 100),
(571, 725, 20, 20, 20, 20, 20, 100),
(572, 716, 20, 20, 20, 20, 20, 100),
(573, 734, 20, 20, 20, 20, 20, 100),
(574, 741, 20, 20, 20, 20, 20, 100),
(575, 709, 20, 20, 20, 20, 20, 100),
(576, 721, 20, 20, 20, 20, 20, 100),
(577, 708, 20, 20, 20, 20, 20, 100),
(578, 706, 20, 20, 20, 20, 20, 100),
(579, 738, 20, 20, 20, 20, 20, 100),
(580, 751, 20, 20, 20, 20, 20, 100),
(581, 758, 20, 20, 20, 20, 20, 100),
(582, 755, 20, 20, 20, 20, 20, 100),
(583, 768, 20, 20, 20, 20, 20, 100),
(584, 772, 20, 20, 20, 20, 20, 100),
(585, 775, 20, 20, 20, 20, 20, 100),
(586, 726, 20, 20, 20, 20, 20, 100),
(587, 743, 20, 20, 20, 20, 20, 100),
(588, 760, 20, 20, 20, 20, 20, 100),
(589, 777, 20, 20, 20, 20, 20, 100),
(590, 712, 20, 20, 20, 20, 20, 100),
(591, 729, 20, 20, 20, 20, 20, 100),
(592, 746, 20, 20, 20, 20, 20, 100),
(593, 763, 20, 20, 20, 20, 20, 100),
(594, 780, 20, 20, 20, 20, 20, 100),
(595, 183, 20, 20, 20, 20, 20, 100),
(596, 195, 20, 20, 20, 20, 20, 100),
(597, 207, 20, 20, 20, 20, 20, 100),
(598, 219, 20, 20, 20, 20, 20, 100),
(599, 198, 20, 20, 20, 20, 20, 100),
(600, 186, 20, 20, 20, 20, 20, 100),
(601, 442, 20, 20, 20, 20, 20, 100),
(602, 465, 20, 20, 20, 20, 20, 100),
(603, 517, 20, 20, 20, 20, 20, 70),
(604, 512, 20, 20, 20, 20, 20, 100),
(605, 543, 20, 20, 20, 20, 20, 100),
(606, 538, 20, 20, 20, 20, 20, 100),
(607, 569, 20, 20, 20, 20, 20, 70),
(608, 595, 20, 20, 20, 20, 20, 100),
(609, 621, 20, 20, 20, 20, 20, 100),
(610, 564, 20, 20, 20, 20, 20, 100),
(611, 514, 20, 20, 20, 20, 20, 100),
(612, 616, 20, 20, 20, 20, 20, 100),
(613, 590, 20, 20, 20, 20, 20, 100),
(614, 540, 20, 20, 20, 20, 20, 100),
(615, 188, 20, 20, 20, 20, 20, 100),
(616, 200, 20, 20, 20, 20, 20, 100),
(617, 212, 20, 20, 20, 20, 20, 100),
(618, 224, 20, 20, 20, 20, 20, 100),
(619, 566, 20, 20, 20, 20, 20, 100),
(620, 528, 20, 20, 20, 20, 20, 75),
(621, 592, 20, 20, 20, 20, 20, 100),
(622, 618, 20, 20, 20, 20, 20, 100),
(623, 554, 20, 20, 20, 20, 20, 70),
(624, 834, 20, 20, 20, 20, 20, 95),
(625, 580, 20, 20, 20, 20, 20, 100),
(626, 606, 20, 20, 20, 20, 20, 70),
(627, 862, 20, 20, 20, 20, 20, 95),
(628, 946, 20, 20, 20, 20, 20, 95),
(629, 632, 20, 20, 20, 20, 20, 90),
(630, 918, 20, 20, 20, 20, 20, 95),
(631, 949, 20, 20, 20, 20, 20, 75),
(632, 921, 20, 20, 20, 20, 20, 75),
(633, 890, 20, 20, 20, 20, 20, 95),
(634, 893, 20, 20, 20, 20, 20, 75),
(635, 865, 20, 20, 20, 20, 20, 75),
(636, 837, 20, 20, 20, 20, 20, 75),
(637, 795, 20, 20, 20, 20, 20, 75),
(638, 823, 20, 20, 20, 20, 20, 75),
(639, 851, 20, 20, 20, 20, 20, 100),
(640, 879, 20, 20, 20, 20, 20, 100),
(641, 907, 20, 20, 20, 20, 20, 75),
(642, 935, 20, 20, 20, 20, 20, 100),
(643, 812, 20, 20, 20, 20, 20, 100),
(644, 840, 20, 20, 20, 20, 20, 100),
(645, 868, 20, 20, 20, 20, 20, 100),
(646, 896, 20, 20, 20, 20, 20, 100),
(647, 924, 20, 20, 20, 20, 20, 100),
(648, 952, 20, 20, 20, 20, 20, 100),
(649, 800, 20, 20, 20, 20, 20, 50),
(650, 828, 20, 20, 20, 20, 20, 100),
(651, 856, 20, 20, 20, 20, 20, 100),
(652, 884, 20, 20, 20, 20, 20, 100),
(653, 912, 20, 20, 20, 20, 20, 100),
(654, 940, 20, 20, 20, 20, 20, 100),
(655, 547, 20, 20, 20, 20, 20, 100),
(656, 521, 20, 20, 20, 20, 20, 100),
(657, 573, 20, 20, 20, 20, 20, 100),
(658, 599, 20, 20, 20, 20, 20, 100),
(659, 625, 20, 20, 20, 20, 20, 100),
(660, 703, 20, 20, 20, 20, 20, 100),
(661, 720, 20, 20, 20, 20, 20, 100),
(662, 737, 20, 20, 20, 20, 20, 100),
(663, 754, 20, 20, 20, 20, 20, 100),
(664, 771, 20, 20, 20, 20, 20, 100),
(665, 132, 20, 20, 20, 20, 20, 100),
(666, 146, 20, 20, 20, 20, 20, 100),
(667, 160, 20, 20, 20, 20, 20, 100),
(668, 174, 20, 20, 20, 20, 20, 100),
(669, 563, 20, 20, 20, 20, 20, 100),
(670, 615, 20, 20, 20, 20, 20, 100),
(671, 537, 20, 20, 20, 20, 20, 100),
(672, 511, 20, 20, 20, 20, 20, 100),
(673, 589, 20, 20, 20, 20, 20, 100),
(674, 548, 20, 20, 20, 20, 20, 50),
(675, 574, 20, 20, 20, 20, 20, 75),
(676, 600, 20, 20, 20, 20, 20, 65),
(677, 626, 20, 20, 20, 20, 20, 60),
(678, 409, 20, 20, 20, 20, 20, 100),
(679, 617, 20, 20, 20, 20, 20, 95),
(680, 591, 20, 20, 20, 20, 20, 95),
(681, 565, 20, 20, 20, 20, 20, 100),
(682, 539, 20, 20, 20, 20, 20, 95),
(683, 513, 20, 20, 20, 20, 20, 100),
(684, 527, 20, 20, 20, 20, 20, 100),
(685, 579, 20, 20, 20, 20, 20, 100),
(686, 553, 20, 20, 20, 20, 20, 100),
(687, 631, 20, 20, 20, 20, 20, 100),
(688, 605, 20, 20, 20, 20, 20, 50),
(689, 185, 20, 20, 20, 20, 20, 100),
(690, 197, 20, 20, 20, 20, 20, 100),
(691, 209, 20, 20, 20, 20, 20, 100),
(692, 221, 20, 20, 20, 20, 20, 100),
(693, 74, 20, 20, 20, 20, 20, 100),
(694, 79, 20, 20, 20, 20, 20, 100),
(695, 84, 20, 20, 20, 20, 20, 100),
(696, 375, 20, 20, 20, 20, 20, 95),
(697, 398, 20, 20, 20, 20, 20, 100),
(698, 444, 20, 20, 20, 20, 20, 100),
(699, 467, 20, 20, 20, 20, 20, 100),
(700, 490, 20, 20, 20, 20, 20, 100),
(701, 421, 20, 20, 20, 20, 20, 95),
(702, 1054, 20, 20, 20, 20, 20, 100),
(703, 1067, 20, 20, 20, 20, 20, 100),
(704, 1059, 20, 20, 20, 20, 20, 60),
(705, 1107, 20, 20, 20, 20, 20, 70),
(706, 1080, 20, 20, 20, 20, 20, 100),
(707, 1093, 20, 20, 20, 20, 20, 100),
(708, 1094, 20, 20, 20, 20, 20, 100),
(709, 1106, 20, 20, 20, 20, 20, 100),
(710, 1072, 20, 20, 20, 20, 20, 100),
(711, 1081, 20, 20, 20, 20, 20, 90),
(712, 1068, 20, 20, 20, 20, 20, 100),
(713, 1055, 20, 20, 20, 20, 20, 100),
(714, 1112, 20, 20, 20, 20, 20, 90),
(715, 1085, 20, 20, 20, 20, 20, 100),
(716, 1099, 20, 20, 20, 20, 20, 95),
(717, 1060, 20, 20, 20, 20, 20, 100),
(718, 1058, 20, 20, 20, 20, 20, 100),
(719, 1071, 20, 20, 20, 20, 20, 100),
(720, 1084, 20, 20, 20, 20, 20, 100),
(721, 1097, 20, 20, 20, 20, 20, 100),
(722, 1110, 20, 20, 20, 20, 20, 100),
(723, 1073, 20, 20, 20, 20, 20, 100),
(724, 1098, 20, 20, 20, 20, 20, 55),
(725, 1086, 20, 20, 20, 20, 20, 100),
(726, 1111, 20, 20, 20, 20, 20, 100),
(727, 969, 20, 20, 20, 20, 20, 100),
(728, 973, 20, 20, 20, 20, 20, 100),
(729, 1053, 20, 20, 20, 20, 20, 100),
(730, 1066, 20, 20, 20, 20, 20, 100),
(731, 1079, 20, 20, 20, 20, 20, 100),
(732, 1092, 20, 20, 20, 20, 20, 100),
(733, 1105, 20, 20, 20, 20, 20, 75),
(734, 189, 20, 20, 20, 20, 20, 100),
(735, 213, 20, 20, 20, 20, 20, 100),
(736, 201, 20, 20, 20, 20, 20, 100),
(737, 225, 20, 20, 20, 20, 20, 100),
(738, 192, 20, 20, 20, 20, 20, 100),
(739, 204, 20, 20, 20, 20, 20, 100),
(740, 216, 20, 20, 20, 20, 20, 100),
(741, 228, 20, 20, 20, 20, 20, 100),
(742, 1062, 20, 20, 20, 20, 20, 100),
(743, 1075, 20, 20, 20, 20, 20, 100),
(744, 1088, 20, 20, 20, 20, 20, 100),
(745, 1101, 20, 20, 20, 20, 20, 75),
(746, 975, 20, 20, 20, 20, 20, 90),
(747, 1114, 20, 20, 20, 20, 20, 80),
(748, 971, 20, 20, 20, 20, 20, 90),
(749, 967, 20, 20, 20, 20, 20, 90),
(750, 963, 20, 20, 20, 20, 20, 90),
(751, 959, 20, 20, 20, 20, 20, 90),
(752, 955, 20, 20, 20, 20, 20, 90),
(753, 956, 20, 20, 20, 20, 20, 100),
(754, 960, 20, 20, 20, 20, 20, 100),
(755, 964, 20, 20, 20, 20, 20, 100),
(756, 968, 20, 20, 20, 20, 20, 100),
(757, 972, 20, 20, 20, 20, 20, 100),
(758, 976, 20, 20, 20, 20, 20, 100),
(759, 1064, 20, 20, 20, 20, 20, 100),
(760, 1077, 20, 20, 20, 20, 20, 100),
(761, 1090, 20, 20, 20, 20, 20, 100),
(762, 1103, 20, 20, 20, 20, 20, 100),
(763, 1116, 20, 20, 20, 20, 20, 100),
(764, 792, 20, 20, 20, 20, 20, 100),
(765, 820, 20, 20, 20, 20, 20, 100),
(766, 848, 20, 20, 20, 20, 20, 100),
(767, 876, 20, 20, 20, 20, 20, 100),
(768, 904, 20, 20, 20, 20, 20, 100),
(769, 932, 20, 20, 20, 20, 20, 100),
(770, 796, 20, 20, 20, 20, 20, 100),
(771, 824, 20, 20, 20, 20, 20, 70),
(772, 852, 20, 20, 20, 20, 20, 100),
(773, 880, 20, 20, 20, 20, 20, 85),
(774, 908, 20, 20, 20, 20, 20, 80),
(775, 936, 20, 20, 20, 20, 20, 80),
(776, 1063, 20, 20, 20, 20, 20, 100),
(777, 1076, 20, 20, 20, 20, 20, 100),
(778, 1089, 20, 20, 20, 20, 20, 100),
(779, 1102, 20, 20, 20, 20, 20, 100),
(780, 1115, 20, 20, 20, 20, 20, 100),
(781, 990, 20, 20, 20, 20, 20, 100),
(782, 1000, 20, 20, 20, 20, 20, 100),
(783, 1010, 20, 20, 20, 20, 20, 100),
(784, 1020, 20, 20, 20, 20, 20, 100),
(785, 1030, 20, 20, 20, 20, 20, 100),
(786, 1040, 20, 20, 20, 20, 20, 75),
(787, 1050, 20, 20, 20, 20, 20, 85),
(788, 986, 20, 20, 20, 20, 20, 100),
(789, 996, 20, 20, 20, 20, 20, 100),
(790, 1006, 20, 20, 20, 20, 20, 100),
(791, 1016, 20, 20, 20, 20, 20, 100),
(792, 1026, 20, 20, 20, 20, 20, 100),
(793, 1036, 20, 20, 20, 20, 20, 100),
(794, 1046, 20, 20, 20, 20, 20, 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_heteroevaluacion`
--

CREATE TABLE `tb_detalle_heteroevaluacion` (
  `iddetalle` int(11) NOT NULL,
  `idheteroevaluacion` int(11) NOT NULL,
  `indicador1` int(11) NOT NULL,
  `indicador2` int(11) NOT NULL,
  `indicador3` int(11) NOT NULL,
  `indicador4` int(11) NOT NULL,
  `indicador5` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_detalle_heteroevaluacion`
--

INSERT INTO `tb_detalle_heteroevaluacion` (`iddetalle`, `idheteroevaluacion`, `indicador1`, `indicador2`, `indicador3`, `indicador4`, `indicador5`, `total`) VALUES
(1, 36, 20, 20, 20, 20, 20, 100),
(2, 37, 20, 20, 20, 20, 20, 100),
(3, 39, 20, 20, 20, 20, 20, 100),
(4, 40, 20, 20, 20, 20, 20, 100),
(5, 42, 20, 20, 20, 20, 20, 85),
(6, 44, 20, 20, 20, 20, 20, 95),
(7, 45, 20, 20, 20, 20, 20, 95),
(8, 46, 20, 20, 20, 20, 20, 95),
(9, 38, 20, 20, 20, 20, 20, 90),
(10, 41, 20, 20, 20, 20, 20, 95),
(11, 43, 20, 20, 20, 20, 20, 100),
(12, 47, 20, 20, 20, 20, 20, 90),
(13, 51, 20, 20, 20, 20, 20, 95),
(14, 1, 20, 20, 20, 20, 20, 90),
(15, 2, 20, 20, 20, 20, 20, 100),
(16, 3, 20, 20, 20, 20, 20, 90),
(17, 4, 20, 20, 20, 20, 20, 100),
(18, 5, 20, 20, 20, 20, 20, 100),
(19, 6, 20, 20, 20, 20, 20, 100),
(20, 7, 20, 20, 20, 20, 20, 100),
(21, 8, 20, 20, 20, 20, 20, 100),
(22, 9, 20, 20, 20, 20, 20, 95),
(23, 10, 20, 20, 20, 20, 20, 100),
(24, 11, 20, 20, 20, 20, 20, 100),
(25, 12, 20, 20, 20, 20, 20, 100),
(26, 13, 20, 20, 20, 20, 20, 100),
(27, 14, 20, 20, 20, 20, 20, 95),
(28, 15, 20, 20, 20, 20, 20, 100),
(29, 16, 20, 20, 20, 20, 20, 100),
(30, 17, 20, 20, 20, 20, 20, 100),
(31, 18, 20, 20, 20, 20, 20, 100),
(32, 19, 20, 20, 20, 20, 20, 95),
(33, 20, 20, 20, 20, 20, 20, 100),
(34, 21, 20, 20, 20, 20, 20, 80),
(35, 22, 20, 20, 20, 20, 20, 100),
(36, 24, 20, 20, 20, 20, 20, 100),
(37, 25, 20, 20, 20, 20, 20, 100),
(38, 27, 20, 20, 20, 20, 20, 100),
(39, 28, 20, 20, 20, 20, 20, 100),
(40, 29, 20, 20, 20, 20, 20, 100),
(41, 48, 20, 20, 20, 20, 20, 80),
(42, 49, 20, 20, 20, 20, 20, 100),
(43, 50, 20, 20, 20, 20, 20, 90),
(44, 30, 20, 20, 20, 20, 20, 95),
(45, 31, 20, 20, 20, 20, 20, 100),
(46, 32, 20, 20, 20, 20, 20, 90),
(47, 33, 20, 20, 20, 20, 20, 95),
(48, 34, 20, 20, 20, 20, 20, 100),
(49, 35, 20, 20, 20, 20, 20, 75),
(50, 52, 20, 20, 20, 20, 20, 85),
(51, 53, 20, 20, 20, 20, 20, 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_heteroevaluacion_administrativo`
--

CREATE TABLE `tb_detalle_heteroevaluacion_administrativo` (
  `iddetalle` int(11) NOT NULL,
  `idheteroevaluacion` int(11) NOT NULL,
  `indicador1` int(11) NOT NULL,
  `indicador2` int(11) NOT NULL,
  `indicador3` int(11) NOT NULL,
  `indicador4` int(11) NOT NULL,
  `indicador5` int(11) NOT NULL,
  `indicador6` int(11) NOT NULL,
  `indicador7` int(11) NOT NULL,
  `indicador8` int(11) NOT NULL,
  `indicador9` int(11) NOT NULL,
  `indicador10` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_detalle_heteroevaluacion_administrativo`
--

INSERT INTO `tb_detalle_heteroevaluacion_administrativo` (`iddetalle`, `idheteroevaluacion`, `indicador1`, `indicador2`, `indicador3`, `indicador4`, `indicador5`, `indicador6`, `indicador7`, `indicador8`, `indicador9`, `indicador10`, `total`) VALUES
(3, 11, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '85.00'),
(4, 12, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '85.00'),
(5, 9, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '97.50'),
(6, 10, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '80.00'),
(7, 13, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '95.00'),
(8, 14, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '90.00'),
(9, 15, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '90.00'),
(10, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '82.50'),
(11, 17, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '75.00'),
(12, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '80.00'),
(13, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '72.50'),
(14, 21, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '82.50'),
(15, 6, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '67.50'),
(16, 7, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '67.50'),
(17, 8, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, '70.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_docente`
--

CREATE TABLE `tb_docente` (
  `iddocente` int(11) NOT NULL,
  `tipoidentificacion` int(11) NOT NULL,
  `identificacion` varchar(25) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `idarea` int(11) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_docente`
--

INSERT INTO `tb_docente` (`iddocente`, `tipoidentificacion`, `identificacion`, `nombres`, `apellidos`, `correo`, `idarea`, `contrasena`, `estado`) VALUES
(1, 1, '1310687114', 'Luis Daniel', 'Pincay Toala', 'ldpincay@itsup.edu.ec', 4, 'NTJDdElFTE5kZzVzbmVzdWFxczkwUT09', 1),
(6, 1, '1310197973', 'Olga Susana', 'Párraga Obregón', 'susana123parraga@hotmail.com', 4, 'aE1QeWFwaW8wblpnaU9mUkRqUUJsUT09', 1),
(7, 1, '1310091069', 'Kenny Orlando', 'Suasti Alcívar', 'orlandokoka1980@outlook.com', 4, 'UUhVWHRCNjllVXZydUR4d2VRaE1HQT09', 1),
(14, 1, '1314070283', 'Gema Stefany', 'Barreiro Mendoza', 'stefanybarreiro@gmail.com', 4, 'NjlZZmExOFVDdFZWbW1KTW1ROVQyUT09', 1),
(15, 1, '1314810118', 'Carlos Alexander', 'Zambrano Rosado', 'carlosalexanderzambranorosado@gmail.com', 4, 'Njg2NGc2L3NqZ2NiRXhQOWIvYUJiZz09', 1),
(16, 1, '1314989383', 'Eberth Javier', 'Zambrano Valencia', 'javierzam1909@gmail.com', 4, 'ejVVNjRwZDhnU29qNXlKMit5Z0M1UT09', 1),
(17, 1, '1315699619', 'Kathiuska Monserrate', 'Santana Intriago', 'kathiuska1279@gmail.com', 4, 'TGdsak5LYTI0eEdNTGlweUx0VkQwQT09', 1),
(18, 1, '1310347719', 'Lenin Mauricio', 'Andaluz Granda', 'mandaluz1987@hotmail.com', 4, 'TnJhWXluMW1SeGFwY29Bd1FHaXhGUT09', 1),
(19, 1, '0705003101', 'Carlos Andrés', 'Vélez García', 'carlosandres1310@hotmail.com', 4, 'S3FiUGZhT0lWbGtCcjh6aE9kSnh5QT09', 1),
(20, 1, '0962308094', 'Yelennis', 'Galardy Domínguez', 'gyelennis@yahoo.com', 4, 'U29FWS9xanlVZWdWYytIdm1YU0V4UT09', 1),
(21, 1, '0963204961', 'Humberto Segundo', 'Alvarado Medina', 'humbertoalvar@gmail.com', 4, 'QzU1bmFldXY5QVExUngzSkJFcHZ5UT09', 1),
(22, 1, '1304133455', 'Monserrate Lourdes', 'Burgos Briones', 'burgos.lourdes@hotmail.com', 4, 'c3pBSzY0L0JKeC83K2hLL1Ric2VtQT09', 1),
(23, 1, '1305495754', 'Geoconda Lorena', 'Adrian Loor', 'ladrian68@hotmail.com', 4, 'ZFZVd051cEhJWG9mZnNNL1RMbHF5QT09', 1),
(24, 1, '1305922088', 'Roberth Olmedo', 'Zambrano Santos', 'rzambranosantos@yahoo.es', 4, 'cGFtL21QOFoxQzB5SnAzNndnSkJnQT09', 1),
(26, 1, '1305954529', 'Sonia Patricia', 'Ubillús Saltos', 'soniaubi@live.com', 4, 'RUxoZFhDLzl1Z2VGWWlNaVFMemFoUT09', 1),
(27, 1, '1307202547', 'Dexsy Mabel', 'Marquez Tejena', 'mabel_marquez18@yahoo.com', 4, 'cHVJK1gwb09JZXR3QUZsbHUxa2pMdz09', 1),
(28, 1, '1309167441', 'Gema Elizabeth', 'Saltos Bazurto', 'sb_gemae@outlook.es', 4, 'MEhnaEJzTmhsYXV6dlR4MU5ZU2taQT09', 1),
(29, 1, '1309405718', 'Ligia Vanessa', 'Sánchez Parrales', 'ligia1980@live.com', 4, 'MDY2bkpJcTFBei9EM3hINDBTOURRdz09', 1),
(30, 1, '1310509425', 'Lilian Paola', 'Andrade Farfán', 'miflorpao@gmail.com', 4, 'VERVR29YNHhXN0VzZHRLVFJ3Vk95dz09', 1),
(31, 1, '1310786577', 'Roberth William', 'Zambrano De La Torre', 'zroberthwilliam@hotmail.com', 4, 'SGdBaXlGak9JWlFOOGNiRjM1SlRCQT09', 1),
(32, 1, '1312294604', 'Vanessa Leticia', 'García Zambrano', 'heartlove_vlgz@hotmail.com', 4, 'eXZ0Qno0Zk03QUI1aTdYZkVZNXlZdz09', 1),
(33, 1, '1312295130', 'Silvia Patricia', 'Pico Bazurto', 'picosilvia@hotmail.com.ar', 4, 'OUg0ZE5pTmxiR2ROS0FqQ0ozNE0yZz09', 1),
(34, 1, '1312400185', 'Roberth Patricio', 'Zambrano Ubillús', 'roberthzamubi@hotmail.com', 4, 'dEorWmo5eW1uNlZlR2tQOGdmM0JuUT09', 1),
(35, 1, '1313036954', 'Irina Patricia', 'Bravo Cedeño', 'irinaandres12@hotmail.com', 4, 'SWpKdC9aemFsK2RRVUdZVXhReUk5dz09', 1),
(36, 1, '1314617026', 'Wendy Tatiana', 'Intriago Lucas', 'Tati_intri@hotmail.com', 4, 'UHJYdHVjdms3T2hadEltSVFseXU4dz09', 1),
(37, 1, '0998283880', 'Juan Carlos', 'Saltos', 'jcsaltosg1978@hotmail.com', 4, 'SlVEWW81OHVITTFXZEhuZWd4NnhLUT09', 1),
(38, 1, '1311984627', 'Virginia', 'Cedeño Párraga', 'mavicepa@hotmail.com', 4, 'NDJwQUZaTG91cSt2L0I5amRDdm9rUT09', 1),
(39, 1, '1311503930', 'Juan', 'Vaca Moreira', 'ayuki007@hotmail.com', 4, 'WnZjU2hMaHRYVXM0VFM0N05HWjFDUT09', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_estudiante`
--

CREATE TABLE `tb_estudiante` (
  `idestudiante` int(11) NOT NULL,
  `cedula` varchar(25) NOT NULL,
  `nombres` varchar(225) NOT NULL,
  `idcarrera` int(11) NOT NULL,
  `semestre` varchar(100) NOT NULL,
  `jornada` varchar(25) NOT NULL,
  `contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_estudiante`
--

INSERT INTO `tb_estudiante` (`idestudiante`, `cedula`, `nombres`, `idcarrera`, `semestre`, `jornada`, `contrasena`) VALUES
(1, '1315636702', 'CHOEZ MENDOZA ROSAURA JAMILETH', 1, '1', 'Matutino', '114bb597'),
(2, '1317717476', 'CEDEÑO CHAVEZ MELANIE JUDITH', 1, '1', 'Matutino', '114bb5bb'),
(3, '1317279626', 'COBOS GARCIA SCARLET LOREIDY', 1, '1', 'Matutino', '114bb5d0'),
(4, '1316476900', 'ROMERO MACIAS STEVEN JOHAN', 1, '1', 'Matutino', '114bb5e5'),
(5, '1316015245', 'PINARGOTE MALDONADO NICOLE JESUS', 1, '1', 'Matutino', '114bb5f9'),
(6, '1350233266', 'GARCIA MARQUEZ MIRKA VALENTINA', 1, '1', 'Matutino', '114bb61e'),
(7, '0803950328', 'REASCO VALDEZ CAMILA MARILYN', 1, '1', 'Matutino', '114bb630'),
(8, '1313450601', 'AUQUILLA BAILON CRISLY ROMINA', 1, '1', 'Matutino', '114bb646'),
(9, '1312264524', 'GAÓN MOREIRA MATTHEW HAFFIT', 1, '1', 'Matutino', '114bb678'),
(10, '0604004788', 'OROZCO SUAREZ HEIDY MICHELL', 1, '1', 'Matutino', '114bb689'),
(11, '1312031683', 'COBEÑA CHÁVEZ CRISTHIAN ANDRÉS', 1, '2', 'Vespertino', '114bb709'),
(12, '1313256123', 'ARTEAGA TAIPE VALERIA ELIZABETH', 1, '3', 'Vespertino', '114bb721'),
(13, '1314932508', 'POSLIGUA VELÁSQUEZ MARÍA LISBETH', 1, '2', 'Vespertino', '114bb736'),
(14, '1311308074', 'JARA PONCE JORDY IGNACIO', 1, '2', 'Vespertino', '114bb747'),
(15, '1351370422', 'VINCES VINCES KENNEDY MIGUEL', 1, '2', 'Vespertino', '114bb757'),
(16, '1350295802', 'CEDEÑO ANDRADE ANAMILETH DAYANA', 1, '2', 'Vespertino', '114bb768'),
(17, '1723286611', 'BAZURTO DEMERA JHON EMILIO', 1, '4', 'Vespertino', '114bb77f'),
(18, '1313236018', 'GUADAMUD ALCIVAR GALO ORLANDO', 1, '2', 'Vespertino', '114bb7cd'),
(19, '1317880381', 'BONILLA ECHEVERRIA MARIA EMILIA', 1, '2', 'Vespertino', '114bb7de'),
(20, '1351623010', 'VINCES SILVA HOLGER JOEL', 1, '2', 'Vespertino', '114bb7f2'),
(21, '1314387836', 'CEDEÑO CELLAN KATHERINE LIZBETH', 1, '2', 'Vespertino', '114bb805'),
(22, '1314873744', 'PARRAGA MUÑOZ JULEXY ANDREINA', 1, '2', 'Vespertino', '114bb815'),
(23, '1313131649', 'GILER MERA ANTHONY JESUS', 1, '2', 'Vespertino', '114bb826'),
(24, '1314616994', 'CATAGUA PARRAGA ANGIE MELINA', 1, '2', 'Vespertino', '114bb836'),
(25, '1314394691', 'MOREIRA GARCIA LUIGGY ARIEL', 1, '3', 'Vespertino', '114bb84c'),
(26, '1317296166', 'MORA ALMEIDA MELANY NICOLLE', 1, '3', 'Vespertino', '114bb85c'),
(27, '1350601447', 'SANTOS ALARCON CHRISTOPHER ARIEL', 1, '2', 'Vespertino', '114bb8cd'),
(28, '1350173025', 'MALDONADO PALMA ARIANNA MICHELLE', 1, '3', 'Vespertino', '114bb930'),
(29, '1311834004', 'VELEZ GARCIA MARIA EUGENIA', 1, '2', 'Vespertino', '114bb94e'),
(30, '1316083599', 'GUTIERREZ ARTEAGA MARISSA NICOLE', 1, '3', 'Vespertino', '114bb963'),
(31, '0927839969', 'VELOZ LEON NADIA SORAYA', 1, '2', 'Vespertino', '114bb977'),
(32, '1314016088', 'RENGIFO MOREIRA SELENA KAINA', 1, '2', 'Vespertino', '114bb988'),
(33, '1309450938', 'LOZANO SOLORZANO DANIEL RAMON', 1, '4', 'Vespertino', '114bb99d'),
(34, '1316442050', 'MOREIRA CASTRO JOHAN GREGORIO', 1, '2', 'Vespertino', '114bb9b2'),
(35, '1350047252', 'SANTANA ROJAS ALISSON PIERINA', 1, '3', 'Vespertino', '114bba1f'),
(36, '2200148688', 'GARCIA BRAVO DIANA MERCEDES', 1, '4', 'Vespertino', '114bba34'),
(37, '1351470065', 'REZABALA MOREIRA LADY JAMILEX', 1, '3', 'Vespertino', '114bba48'),
(38, '1313903542', 'ALCIVAR LOOR KEVIN ALEXANDER', 1, '4', 'Vespertino', '114bba5c'),
(39, '1313044750', 'MUÑOZ VINCES JOSE ANTONIO', 1, '3', 'Vespertino', '114bba71'),
(40, '1716917644', 'LOOR SAAVEDRA CARLOS EDUARDO', 1, '2', 'Vespertino', '114bbaca'),
(41, '1350786750', 'VELEZ MACIAS JOSE LUIS', 1, '3', 'Vespertino', '114bbaed'),
(42, '1311088932', 'GARCIA MERO ANGEL EUGENIO', 1, '2', 'Vespertino', '114bbb0b'),
(43, '1315424109', 'ALCIVAR ARTEAGA JUAN MANUEL', 1, '3', 'Vespertino', '114bbb1f'),
(44, '1313852145', 'RIVAS HOYOS KRUPSKAJA KENIA', 1, '3', 'Vespertino', '114bbb75'),
(45, '1313983783', 'FRANCO CARVAJAL KAROLIN YOSENKA', 1, '2', 'Vespertino', '114bbb8a'),
(46, '0928611300', 'SOLORZANO SANTANA ANGIEE NICOLL', 1, '2', 'Vespertino', '114bbbae'),
(47, '1309293767', 'MOLINA LOOR EDGAR OSWALDO', 1, '4', 'Vespertino', '114bbbfd'),
(48, '1351889272', 'ANDRADE BASURTO BRYAN JOSE', 1, '4', 'Vespertino', '114bbc10'),
(49, '1315962918', 'NAVARRO MERO NALLELY DAYANARA', 1, '3', 'Vespertino', '114bbc24'),
(50, '1350293120', 'MOSCOSO MOREIRA MILENA MADELAINE', 1, '3', 'Vespertino', '114bbc36'),
(51, '1350260772', 'ZAMBRANO MACIAS EMILY MARIA', 1, '2', 'Vespertino', '114bbc4a'),
(52, '1311970147', 'ZAMBRANO MOREIRA VIVIANA LISSETTE', 1, '2', 'Vespertino', '114bbc65'),
(53, '1350229355', 'MOREIRA ZAMBRANO EMILY KAINA', 1, '2', 'Vespertino', '114bbc75'),
(54, '1350239149', 'CEDEÑO PONCE JOSSELYN ELIZABETH', 1, '3', 'Vespertino', '114bbc89'),
(55, '1351268402', 'MENDOZA ROMERO JULISSA ANAHI', 1, '4', 'Vespertino', '114bbcd4'),
(56, '1316322799', 'ZAMBRANO RODRIGUEZ VIELKA ANALLELY', 1, '4', 'Vespertino', '114bbce4'),
(57, '0925142457', 'ARTIEDA MENDOZA KATHERINE MABEL', 1, '4', 'Vespertino', '114bbcff'),
(58, '1315963858', 'ANCHUNDIA LUCAS SILVIA VANESSA', 1, '4', 'Vespertino', '114bbd0f'),
(59, '1311396772', 'SORNOZA PONCE JULIO ANTONIO', 1, '2', 'Vespertino', '114bbd35'),
(60, '0850306051', 'BONE MINA ANA LISSETH', 1, '3', 'Vespertino', '114bbd8e'),
(61, '1350250187', 'OLMEDO PARRALES DEISY MONSERRATE', 1, '4', 'Vespertino', '114bbda2'),
(62, '1316263068', 'PARRALES ALVAREZ SHEYLA VALENTINA', 1, '4', 'Vespertino', '114bbdb2'),
(63, '1205754078', 'RUBIO CEDEÑO MAITE ZULEMA', 1, '4', 'Vespertino', '114bbdc2'),
(64, '1313808204', 'ARTEAGA ALAVA DAYANA CAROLINA', 1, '4', 'Vespertino', '114bbdd2'),
(65, '1308717238', 'MOREIRA FARIAS EDITA CONCEPCION', 1, '4', 'Vespertino', '114bbde5'),
(66, '1351466923', 'ORTEGA COVEÑA GIVELY DAYANNA', 1, '2', 'Vespertino', '114bbdf9'),
(67, '1315220119', 'GILER ROMERO JEAN PIERRE', 1, '2', 'Vespertino', '114bbe09'),
(68, '1726007550', 'RAMIREZ AVILA EVA MARIA', 1, '4', 'Vespertino', '114bbe64'),
(69, '1314246933', 'AVILA SANCHEZ GEMA DENISSE', 1, '3', 'Vespertino', '114bbe79'),
(70, '1725189029', 'VELEZ MOREIRA NEPTALY DIOSDADO', 1, '3', 'Vespertino', '114bbe88'),
(71, '1315843480', 'MERO GUERRERO RODDY STEEVEN', 1, '3', 'Vespertino', '114bbe98'),
(72, '1314366996', 'MACIAS MACIAS MARIA ELENA', 1, '4', 'Vespertino', '114bbeab'),
(73, '1350812788', 'MACIAS LOOR NEREXI LEONELA', 1, '4', 'Vespertino', '114bbec5'),
(74, '1313729335', 'MENÉNDEZ VERA GIANELLA GEOMARA', 1, '2', 'Vespertino', '114bbffb'),
(75, '1315420768', 'LOPEZ ZAMBRANO DANIELA NINOSKA', 1, '4', 'Vespertino', '114bc021'),
(76, '1720497567', 'OLIVIERI GARCÍA NEAL XXX', 1, '4', 'Vespertino', '114bc032'),
(77, '1316640158', 'DELGADO QUIJANO MICHELL VIVIANA', 1, '4', 'Vespertino', '114bc043'),
(78, '1313724815', 'VEGA BRIONES MARIA FERNANDA', 1, '4', 'Vespertino', '114bc054'),
(79, '1316500162', 'MORÁN NAVIA GALO FABRICIO', 1, '3', 'Vespertino', '114bc069'),
(80, '1315954246', 'MONGE PINARGOTE SULDI SELENA', 1, '3', 'Vespertino', '114bc07c'),
(81, '1315462521', 'MENDOZA QUIROZ ROSA KASSANDRA', 1, '3', 'Vespertino', '114bc0cf'),
(82, '2350861981', 'ZAMBRANO VERA HELEN NICOLE', 1, '3', 'Vespertino', '114bc0de'),
(83, '1315713741', 'ALVAREZ MOLINA DARLIN MARIBEL', 1, '3', 'Vespertino', '114bc0ed'),
(84, '1350340251', 'PINARGOTE RIVAS XAVIER CALIXTO', 1, '3', 'Vespertino', '114bc108'),
(85, '1351095292', 'CHILAN LAZ MARIA NAYELI TU', 1, '3', 'Vespertino', '114bc119'),
(86, '1316655479', 'CEVALLOS CANTOS JEAN PIERRE', 1, '4', 'Vespertino', '114bc137'),
(87, '1316859170', 'ESPINOZA PAZMIÑO CINTHYA KATHERINE', 1, '4', 'Vespertino', '114bc147'),
(88, '1317520896', 'MENDOZA DELGADO KAREN STEFANIA', 1, '3', 'Vespertino', '114bc196'),
(89, '1310821200', 'HERNANDEZ LOPEZ MONICA YAJAIRA', 1, '4', 'Vespertino', '114bc1bf'),
(90, '1311838484', 'AVILA POSLIGUA HUGO GERARDO', 1, '4', 'Vespertino', '114bc1cf'),
(91, '1726452921', 'GOMEZ GODOY MELANIE DAYANA', 1, '1', 'Vespertino', '114bc20b'),
(92, '1309848438', 'MOREIRA MEJÍA LINDA XIMENA', 2, '1', 'En Línea', '8eb66e98'),
(93, '0920385630', 'ROBLES GRANDA LADY DIANA', 2, '5', 'En Línea', '8eb66f1b'),
(94, '1316500121', 'AREVALO MACIAS ANDREA ISABEL', 3, '5', 'En Línea', 'e2401c3d'),
(95, '1313699165', 'MERA PONCE MAYRA ALEJANDRA', 3, '2', 'En Línea', 'e2401cd3'),
(96, '2100551627', 'ORTIZ REASCO ROSY ROXINA', 3, '1', 'En Línea', 'e2401d49'),
(97, '1350515241', 'QUIMIS VÈLEZ ANDREA NICOLE', 3, '5', 'En Línea', 'e2401d5c'),
(98, '0962146437', 'PILLASAGUA OVALLES GINGER MILEIDY', 3, '2', 'En Línea', 'e2402321'),
(99, '1312867037', 'GUERRERO GARCIA ERICK PATRICIO', 4, '3', 'Nocturno', '5d50acaa'),
(100, '1314673904', 'BUENO ORTIZ MILTON MARCELO', 4, '6', 'Nocturno', '5d50af13'),
(101, '1314713775', 'UGALDE ESPINOZA GIANLUCA VICENTE', 4, '1', 'En Línea', '5d50b313'),
(102, '1312828054', 'CORDERO MOREIRA JOSÉ MIGUEL', 4, '3', 'En Línea', '5d50b32c'),
(103, '1315231512', 'MERO ALVARADO KENETH DARIO', 4, '1', 'En Línea', '5d50b341'),
(104, '1306474113', 'BORRERO CEVALLOS ROBINSON ESTALIN', 4, '4', 'En Línea', '5d50b36c'),
(105, '1315663268', 'CEDEÑO BRAVO WELLINGTON MIGUEL', 4, '4', 'En Línea', '5d50b37e'),
(106, '1309682985', 'Mendoza Borrero Eduardo Alejandro', 4, '1', 'En Línea', '5d50b394'),
(107, '1312358912', 'VALDIVIESO CHUNG DANIEL JAFET', 4, '1', 'En Línea', '5d50b3a6'),
(108, '1312298993', 'CONSTANTE SUAREZ GABRIEL ENRIQUE', 4, '4', 'En Línea', '5d50b3ed'),
(109, '1311308538', 'ALVARADO ZAMBRANO JORGE NAPOLEÓN', 4, '4', 'En Línea', '5d50b3fe'),
(110, '1311333965', 'CEVALLOS GARCIA CARLOS JULIO', 4, '5', 'En Línea', '5d50b417'),
(111, '1309692919', 'CAICEDO VEGA LUIS ALFREDO', 4, '5', 'En Línea', '5d50b42a'),
(112, '0952574549', 'MENDOZA HIDALGO BRYAN ALBERTO', 4, '3', 'En Línea', '5d50b440'),
(113, '1310832306', 'MENDOZA PONCE BRAULIO GEOVANNY', 4, '5', 'En Línea', '5d50b464'),
(114, '167547158', 'CARRUYO CANO JEAN LEVI', 5, '2', 'Nocturno', '146aaa73'),
(115, '1315851335', 'CASTRO VELEZ JEFFREY RENAN', 5, '2', 'Nocturno', '146aab0a'),
(116, '1313189134', 'CRUZATTY DEMERA ROBERTO MATIAS', 5, '2', 'Nocturno', '146aabab'),
(117, '0104893318', 'CEDEÑO CARRILLO MARLON JAVIER', 5, '2', 'Nocturno', '146aac18'),
(118, '1312773078', 'VELEZ GARCIA VICTOR MANUEL', 5, '2', 'Nocturno', '146aac3d'),
(119, '1350206023', 'HEREDIA PARRALES JOAN ANTHONY', 5, '2', 'Nocturno', '146aad19'),
(120, '1315821817', 'CHAVEZ MORWIRA FREYA DALESKA', 5, '2', 'Nocturno', '146aad55'),
(121, '1351637499', 'LUCAS ARTEAGA JHON ALBERTO', 5, '6', 'Nocturno', '146aae81'),
(122, '1314049592', 'VELIZ GARCIA FELIX HUMBERTO', 5, '2', 'Nocturno', '146aaea7'),
(123, '1316469012', 'VERA MOREIRA STEEVEN ALEJANDRO', 5, '1', 'Nocturno', '146aaed3'),
(124, '1350760490', 'VINCES SUAREZ PABLO GABRIEL', 5, '1', 'Nocturno', '146aaef5'),
(125, '1723595177', 'MEDINA RAMIREZ PABLO EDUARDO', 5, '6', 'Nocturno', '146aafdb'),
(126, '1804352951', 'TUSTON URRUTIA FREDDY GERMAN', 5, '6', 'Nocturno', '146aafef'),
(127, '1312320342', 'VELASQUEZ VELASQUEZ JANDRY JAVIER', 5, '6', 'Nocturno', '146ab005'),
(128, '1350315428', 'DELGADO ZAMBRANO JHAROL HUMBERTO', 5, '1', 'Nocturno', '146ab14c'),
(129, '1350228266', 'ARTEAGA PICO GABRIEL ANTONIO', 5, '1', 'Nocturno', '146ab164'),
(130, '1316576261', 'TAPIA PICO LUIS ALONSO', 5, '2', 'Nocturno', '146ab1e1'),
(131, '1316574779', 'CAJILEMA MENDOZA JONATHAN DAVID', 5, '2', 'Nocturno', '146ab1f6'),
(132, '1313502567', 'CHÁVEZ COBEÑA JOSE FABIÁN', 5, '2', 'Nocturno', '146ab293'),
(133, '1312946286', 'TRIVIÑO ORTEGA JOSSELYN GABRIELA', 6, '6', 'Vespertino', 'b333737e'),
(134, '1316518164', 'BARRAGÁN MEJÍA VIVIAN DAYANA', 6, '6', 'Vespertino', 'b333746f'),
(135, '0928914159', 'CHILUISA CASACILIA MATILDE CAROLINA', 6, '6', 'Vespertino', 'b33375dd'),
(136, '1350125652', 'ALAVA LOOR IVANNA SOPHIA', 6, '6', 'Vespertino', 'b33376e4'),
(137, '1314014976', 'CEVALLOS ZAMORA SANDRA MONSERRATE', 6, '6', 'Vespertino', 'b3337754'),
(138, '1311985954', 'MACIAS VELASQUEZ NAYELI TOPACIO', 7, '2', 'Nocturno', '1ab4db70'),
(139, '1317769238', 'YOZA BAQUE CRISTHIAN JORDAN', 7, '1', 'Nocturno', '1ab4dba1'),
(140, '1313882266', 'SUAREZ SALTOS MIGUEL NARCISO', 7, '1', 'Nocturno', '1ab4dbb5'),
(141, '1316696192', 'SALTOS PALACIOS ANA JUDITH', 7, '2', 'Nocturno', '1ab4dbdc'),
(142, '0401771621', 'ARELLANO CHUGA HAROL MARINO', 7, '3', 'Nocturno', '1ab4dbf2'),
(143, '1350031355', 'ROLDAN INTRIAGO ANGIE GISSELY', 7, '1', 'Nocturno', '1ab4dc5a'),
(144, '1317043279', 'VERA CALERO GENESIS PATRICIA', 7, '3', 'Nocturno', '1ab4dc79'),
(145, '1313258996', 'LOPEZ MOREIRA FELIX FERNANDO', 7, '2', 'Nocturno', '1ab4dd32'),
(146, '1312366345', 'VEGA BRAVO JHONNY JAVIER', 7, '1', 'Nocturno', '1ab4dd49'),
(147, '1310812738', 'HERRERA MENDOZA JOSE TELMO', 7, '1', 'Nocturno', '1ab4ddb6'),
(148, '1804657698', 'PÉREZ AGUILAR DIEGO XAVIER', 7, '1', 'Nocturno', '1ab4ddd4'),
(149, '0927564153', 'MERO SUÁREZ JORGE MICHELL', 7, '2', 'Nocturno', '1ab4ddfb'),
(150, '1314712298', 'MATAMOROS CARRANZA SHADEN EWDREY', 7, '1', 'Nocturno', '1ab4de44'),
(151, '1315603280', 'RIOS ARMAS LEONARDO RAUL', 7, '1', 'Nocturno', '1ab4de58'),
(152, '1312061144', 'IBARRA FARFAN HÉCTOR ENRIQUE', 7, '2', 'Nocturno', '1ab4de7e'),
(153, '1311428179', 'SOLORZANO CASTILLO JEAN CARLOS', 7, '2', 'Nocturno', '1ab4dea0'),
(154, '1313095190', 'ALAVA MEJIA JOEL ANTONIO', 7, '1', 'Nocturno', '1ab4def7'),
(155, '1315050003', 'TEJENA FERNÁNDEZ LUIS DAVID', 7, '3', 'Nocturno', '1ab4dfc4'),
(156, '1751886795', 'YANEZ MOREIRA CRISTOPHER JAVIER', 7, '2', 'Nocturno', '1ab4e0a7'),
(157, '1315951010', 'ZAMBRANO ZAMBRANO SHELLEY DELLALETH', 7, '2', 'Nocturno', '1ab4e0c3'),
(158, '1314581735', 'SAAVEDRA INTRIAGO JENNIFER GABRIELA', 7, '2', 'Nocturno', '1ab4e0d7'),
(159, '1315086882', 'QUIJIJE CHILAN ELIO GABRIEL', 7, '2', 'Nocturno', '1ab4e0e9'),
(160, '1313184895', 'CASTRO LUCAS EBERTH XAVIER', 7, '2', 'Nocturno', '1ab4e174'),
(161, '1350151740', 'LOOR BALDERRAMO JOHANNA CRISTINA', 7, '2', 'Nocturno', '1ab4e187'),
(162, '1315851905', 'MERO VALLEJO CARLOS JOSUE', 7, '2', 'Nocturno', '1ab4e199'),
(163, '1312591769', 'VELEZ MOLINA JULIO CESAR', 7, '1', 'Nocturno', '1ab4e219'),
(164, '1312490574', 'PARRAGA BASURTO CARLOS ALFREDO', 7, '2', 'Nocturno', '1ab4e350'),
(165, '1313399683', 'MOREIRA MACIAS MELISSA ALEJANDRA', 7, '3', 'Nocturno', '1ab4e44d'),
(166, '1310154859', 'BRIONES CEDEÑO CRISTOBAL PATRICIO', 7, '3', 'Nocturno', '1ab4e460'),
(167, '1314075274', 'MENDOZA BARRETO JIPSON ANDRES', 7, '3', 'Nocturno', '1ab4e481'),
(168, '1725038630', 'MEJIA GARCIA MAYRA YANETH', 7, '1', 'Nocturno', '1ab4e497'),
(169, '1316790144', 'PARRAGA QUIROZ RITA GABRIELA', 7, '2', 'Nocturno', '1ab4e588'),
(170, '1314411016', 'ROBLES CONFORME ADRIAN ALEXANDER', 7, '3', 'Nocturno', '1ab4e68c'),
(171, '1315779577', 'CRUZATTY ALCIVAR MOISES ABRAHAN', 7, '3', 'Nocturno', '1ab4e6a0'),
(172, '1312450545', 'OROZCO SUAREZ MONICA MADELAYNE', 7, '3', 'Nocturno', '1ab4e6b7'),
(173, '1314763630', 'MENDOZA CEDEÑO JHON PABLO', 7, '1', 'Nocturno', '1ab4e7ab'),
(174, '1314397280', 'SABANDO ROMERO JEAN RAFAEL', 7, '3', 'Nocturno', '1ab4e966'),
(175, '1316348323', 'RIVAS GARCIA JOSE PATRICIO', 7, '2', 'Nocturno', '1ab4e998'),
(176, '1351247562', 'CORTEZ COLOMA MARVIN JHOSEFAJA', 7, '2', 'Nocturno', '1ab4e9ec'),
(177, '1315084101', 'IBARRA QUIJIJE JHON LUIS', 7, '3', 'Nocturno', '1ab4ea0f'),
(178, '1350485387', 'VELEZ PONCE JOSE ABRAHAN', 7, '1', 'Nocturno', '1ab4eb00'),
(179, '1312184532', 'DÍAZ BURGOS KEVIN ADRIÁN', 8, '3', 'Vespertino', 'a509db58'),
(180, '1315524544', 'SAN ANDRÉS ESPINOZA LUIS DAVID', 8, '3', 'Vespertino', 'a509db7c'),
(181, '1315773349', 'VINCES PONCE TATIANA SALOME', 8, '3', 'Vespertino', 'a509dcc0'),
(182, '0705026805', 'TORRES MURILLO JEFFERSON ARTURO', 8, '3', 'Vespertino', 'a509dd7c'),
(183, '1314410182', 'HEREDIA MENDOZA JOSÉ ANDRES', 8, '3', 'Vespertino', 'a509de39'),
(184, '1314072727', 'MENDOZA BERMUDEZ MICHAEL ALEJANDRO', 8, '3', 'Vespertino', 'a509deb5'),
(185, '1316203312', 'ZAMBRANO MARCILLO NICKY STEVEN', 8, '3', 'Vespertino', 'a509ded7'),
(186, '1315557411', 'ESPINOSA MOREIRA ADRÍAN ALEJANDRO', 8, '3', 'Vespertino', 'a509defe'),
(187, '0704854694', 'GARCIA CACERES CARLOS MARVIN', 8, '3', 'Vespertino', 'a509df5d'),
(188, '1350756977', 'AGUIRRE MENENDEZ VICTORIA MICHELL', 8, '3', 'Vespertino', 'a509df70'),
(189, '1310680994', 'JOZA MENDOZA CRISTHOFER MICHAEL', 8, '3', 'Vespertino', 'a509df85'),
(190, '1350206031', 'DE LA CRUZ MEDRANDA TITO FERNANDO', 8, '3', 'Vespertino', 'a509df9d'),
(191, '1315917607', 'PERALTA ZAMBRANO AUDREY NICOLE', 8, '3', 'Vespertino', 'a509dfcb'),
(192, '1315348159', 'DIAZ ALAVA JOSTIN ALEXANDER', 8, '3', 'Vespertino', 'a509e096'),
(193, '1315420644', 'GILCES SALAZAR PATRICK SEBASTIAN', 8, '3', 'Vespertino', 'a509e0b5'),
(194, '1313875161', 'MACIAS ESPINOZA ANA MONSERRATE', 8, '3', 'Vespertino', 'a509e185'),
(195, '1313530899', 'REZABALA FARFAN VICKY MARIA', 8, '3', 'Vespertino', 'a509e1e7'),
(196, '1314789684', 'HIDALGO BURGOS LETICIA NOHELIA', 8, '3', 'Vespertino', 'a509e214'),
(197, '1312192907', 'LÓPEZ LOOR SAMANTHA NICOLE', 8, '3', 'Vespertino', 'a509e43b'),
(198, '1311471682', 'CEVALLOS GILCES JHON ANDRES', 8, '3', 'Vespertino', 'a509e465'),
(199, '1314685965', 'MENDOZA MEZA ANA GABRIELA', 8, '1', 'Nocturno', 'a509e594'),
(200, '1316202165', 'SALTOS CEVALLOS VERONICA NATHALIA', 8, '1', 'Nocturno', 'a509e687'),
(201, '1316345840', 'GARCIA CEVALLOS GEMA DAYANA', 8, '2', 'Nocturno', 'a509e6af'),
(202, '1350178388', 'CELORIO CENTENO KAREN DENISSE', 8, '2', 'Nocturno', 'a509e6c2'),
(203, '1350078802', 'SALTOS MACIAS SAMIR ALESSANDRO', 8, '2', 'Nocturno', 'a509e6d4'),
(204, '0956774848', 'BORJA INTRIAGO LADY STEPHANY', 8, '2', 'Nocturno', 'a509e7b3'),
(205, '1316482304', 'INTRIAGO GARCIA ANGELA MARIA', 8, '2', 'Nocturno', 'a509e961'),
(206, '1315230555', 'INTRIAGO PALMA ALHAN MATTEO', 8, '2', 'Nocturno', 'a509e9fc'),
(207, '1350826846', 'VALDIVIESO MERA FABRICIO SEBASTIAN', 8, '2', 'Nocturno', 'a509ea1b'),
(208, '0953815305', 'NAZARENO BRAVO BYRON RICHARD', 8, '1', 'Nocturno', 'a509ea33'),
(209, '1311864456', 'GOMEZ DELGADO GIANNA ANNABELL', 8, '2', 'Nocturno', 'a509ebbd'),
(210, '1350278279', 'MENDOZA MARTINEZ ISAAC MATHEO', 8, '1', 'Nocturno', 'a509ebd7'),
(211, '1351228851', 'VILLAFUERTE MOREIRA NIURKA NICOLE', 8, '2', 'Nocturno', 'a509ec01'),
(212, '1317122503', 'CANO MENDOZA LEISNERTH NOBEL', 8, '2', 'Nocturno', 'a509ec68'),
(213, '1313523134', 'ZAMBRANO MUÑOZ EVERSON XAVIER', 8, '2', 'Nocturno', 'a509ec7a'),
(214, '1350817746', 'MENDOZA POSLIGUA JEAN PIERRE', 8, '2', 'Nocturno', 'a509ec8d'),
(215, '1350882427', 'PONCE VERA DENISSE MONSERRAT', 8, '1', 'Nocturno', 'a509ecfa'),
(216, '1729708014', 'GARCÍA REVELO VÍCTOR MANUEL', 8, '2', 'Nocturno', 'a509ed1a'),
(217, '1350060180', 'SALMON BAREN SHEKINARA VALENTINA', 8, '1', 'Nocturno', 'a509ed93'),
(218, '1401401342', 'Tukup Wampash Franklin Ismael', 8, '2', 'Nocturno', 'a509edbd'),
(219, '1311507428', 'CORDOVA REYES STALIN ENRIQUE', 8, '2', 'Nocturno', 'a509ee29'),
(220, '1312875923', 'BRIONES VINCES MIRELLY MARIBEL', 8, '1', 'Nocturno', 'a509ef27'),
(221, '1311095671', 'ORTIZ LOPEZ MARIANA ROCIO', 8, '1', 'Nocturno', 'a509ef45'),
(222, '1313853796', 'BRIONES MERA KAREN MARIA', 8, '1', 'Nocturno', 'a509efaf'),
(223, '1310067291', 'MENDOZA MEJIA JHON KENY', 8, '2', 'Nocturno', 'a509efc6'),
(224, '1316058880', 'MOREIRA CEVALLOS MARIA MERCEDES', 8, '1', 'Nocturno', 'a509f05d'),
(225, '1350055412', 'MOREIRA CEDEÑO GEOVANNA ISABELA', 8, '1', 'Nocturno', 'a509f07e'),
(226, '1311504151', 'GAVILANES RODRIGUEZ VICTOR FABRICIO', 8, '1', 'Nocturno', 'a509f09f'),
(227, '1350317770', 'NAVIA VERGARA PABLO FABIAN', 8, '1', 'Nocturno', 'a509f0b3'),
(228, '1315164648', 'QUIROZ GILCES EDDY ALFONSO', 8, '1', 'Nocturno', 'a509f116'),
(229, '1313714584', 'HOLGUIN PACHECO JENIFFER KATHERINE', 8, '2', 'Nocturno', 'a509f142'),
(230, '1314842129', 'MACIAS BERMUDEZ DIEGO ISRAEL', 8, '2', 'Nocturno', 'a509f20f'),
(231, '1350482905', 'ACOSTA ZAMBRANO JEAN CARLOS', 8, '2', 'Nocturno', 'a509f2da'),
(232, '0925228397', 'DELGADO JARRIN CARLOS DAVID', 8, '2', 'Nocturno', 'a509f3f9'),
(233, '1312600792', 'CASTRO MENÉNDEZ RICARDO ALEJANDRO', 9, '6', 'Nocturno', '82c970d4'),
(234, '1313596486', 'PINARGOTE VELASQUEZ HEINZ HERIBERTO', 9, '4', 'Nocturno', '82c97150'),
(235, '1316488574', 'SORNOZA BEANVIDES LENIN ORLANDO', 9, '4', 'Nocturno', '82c9716e'),
(236, '1314074871', 'PALMA PONCE JEAN CARLOS', 9, '6', 'Nocturno', '82c97186'),
(237, '1312463969', 'ZAMBRANO SÁNCHEZ KELVIN KLEIN', 9, '6', 'Nocturno', '82c97199'),
(238, '1311396350', 'MURILLO BRAVO JANDRY PAUL', 9, '6', 'Nocturno', '82c9723e'),
(239, '1758487696', 'VILLAZON OSPINO KAREN LORENA', 9, '4', 'Nocturno', '82c97374'),
(240, '1718943200', 'TUMBACO MACIAS IVONNE PATRICIA', 9, '4', 'Nocturno', '82c97392'),
(241, '1312832247', 'ARIAS MACIAS WILSON ANTHONNY', 9, '6', 'Nocturno', '82c973dc'),
(242, '1305411397', 'BARAHONA CEDEÑO JULIO VICENTE', 9, '6', 'Nocturno', '82c973ef'),
(243, '1308501319', 'BAILÓN ZAMBRANO MARÍA JOSÉ', 9, '4', 'Nocturno', '82c97420'),
(244, '0922553177', 'MOYON URETA JOSSELYN STEPHANIE', 9, '4', 'Nocturno', '82c9747e'),
(245, '1313455394', 'DELGADO CANTOS SAMARA MICKAELA', 9, '4', 'Nocturno', '82c97490'),
(246, '1316305430', 'ULLOA SUÁREZ MELANIE SAMIRA', 9, '6', 'Nocturno', '82c97531'),
(247, '1314731439', 'AVILA RUIZ RAUL EDUARDO', 9, '6', 'Nocturno', '82c97544'),
(248, '1350097562', 'ZAMBRANO CHAVARRIA INGRID MERCEDES', 9, '4', 'Nocturno', '82c9758f'),
(249, '1315224103', 'CUSME CALDERON JONATHAN JAVIER', 9, '6', 'Nocturno', '82c975b0'),
(250, '1729751766', 'ALCIVAR PINARGOTE KEVIN ELIAN', 9, '4', 'Nocturno', '82c975cd'),
(251, '1316446283', 'GARCIA ROMERO LUIS STEEVEN', 9, '4', 'Nocturno', '82c975e9'),
(252, '1312868829', 'SOLORZANO MENDOZA ANDREA FERNANDA', 9, '4', 'Nocturno', '82c975fb'),
(253, '1350237713', 'BERMELLO ZAMBRANO JEAN PIERRE', 9, '6', 'Nocturno', '82c97611'),
(254, '1310716384', 'IBARRA GUILLEN CARMEN CECILIA', 9, '4', 'Nocturno', '82c97664'),
(255, '1727096719', 'PALMA FLORES SHAINA RACHELLE', 9, '6', 'Nocturno', '82c9767e'),
(256, '1312241266', 'MARCILLO BARREIRO JEISY YANINA', 9, '6', 'Nocturno', '82c97690'),
(257, '1311853152', 'CEDEÑO ESPINOZA ZULY MARILYN', 9, '6', 'Nocturno', '82c976ba'),
(258, '1350336150', 'LOPEZ MUÑOZ JUNIOR JAVIER', 9, '6', 'Nocturno', '82c97701'),
(259, '1314401611', 'SABANDO VELEZ JOHAN GASPAR', 9, '4', 'Nocturno', '82c97719'),
(260, '1315639029', 'MARIDUEÑA JARAMILLO WENDY MISHELLE', 9, '4', 'Nocturno', '82c97737'),
(261, '1312560582', 'MENDOZA SORNOZA JOAQUIN ADRIAN', 9, '4', 'Nocturno', '82c9775f'),
(262, '1315364222', 'LOOR CASTRO GEORGE JOEL', 9, '4', 'Nocturno', '82c977f7'),
(263, '1311987315', 'SANTANDER CEVALLOS BRYAN ALEXANDER', 9, '4', 'Nocturno', '82c97808'),
(264, '1350068639', 'MACIAS RUPERTTY CELIA MARIA', 9, '6', 'Nocturno', '82c97826'),
(265, '1317872313', 'PEREZ MEJIA LUIS ENRRIQUE', 9, '4', 'Nocturno', '82c9783b'),
(266, '1314611680', 'VERA BERMELLO JHONNY BIENVENIDO', 9, '4', 'Nocturno', '82c9788c'),
(267, '1312218140', 'ZAMBRANO GOMEZ JOSE AUGUSTO', 9, '4', 'Nocturno', '82c978a8'),
(268, '1311357766', 'ALMEIDA VILLAVICENCIO CARMEN YISELA', 9, '4', 'Nocturno', '82c978b8'),
(269, '1727545517', 'CHAVEZ ANAS GABRIEL MOISES', 9, '4', 'Nocturno', '82c978d3'),
(270, '1315355717', 'SALAZAR ZAMBRANO BRIGITTE CAROLINA', 9, '4', 'Nocturno', '82c978e4'),
(271, '0803070143', 'AGUILAR CEDEÑO ISAAC MIJAIL', 10, '1', 'Matutino', 'fb149d0b'),
(272, '1207211192', 'REA ALMEIDA BRIGGITTE ANNABELL', 10, '5', 'Vespertino', 'fb149eb9'),
(273, '2100497557', 'PALACIOS SOLORZANO YANDRY ANDRES', 10, '6', 'Vespertino', 'fb149edd'),
(274, '1310636632', 'GARCIA FAUBLA BRYAN XAVIER', 10, '6', 'Vespertino', 'fb149efa'),
(275, '1350256515', 'ANTÒN GOROZABEL JUAN ALEJANDRO', 10, '6', 'Vespertino', 'fb149f0e'),
(276, '1310024250', 'ZAMBRANO MACIAS ANDREA BELEN', 10, '6', 'Vespertino', 'fb149f2a'),
(277, '1314750447', 'CEDEÑO PINARGOTE ANA DANIELA', 10, '6', 'Vespertino', 'fb149f7f'),
(278, '1306045145', 'UBILLUS SALTOS MIRIAN GEOCONDA', 10, '6', 'Vespertino', 'fb149fa2'),
(279, '1314049253', 'RODRÍGUEZ SOLORZANO GERMÁN LEONARDO', 10, '6', 'Vespertino', 'fb149ff8'),
(280, '1316440963', 'CHÓEZ PEÑAFIEL ANDREA TERESITA', 10, '5', 'Vespertino', 'fb14a012'),
(281, '1311324063', 'DEMERA CEDEÑO GABRIELA ALEJANDRA', 10, '6', 'Vespertino', 'fb14a071'),
(282, '1316899317', 'ALCÍVAR PARRALES JOHÁM MOISÉS', 10, '6', 'Vespertino', 'fb14a097'),
(283, '1313122804', 'AVENDAÑO PINARGOTE KATHERINE LISSETTE', 10, '6', 'Vespertino', 'fb14a10a'),
(284, '1314753631', 'VELIZ ARAY TITO JOSHUE', 10, '5', 'Vespertino', 'fb14a16f'),
(285, '1314935774', 'LOPEZ MOREIRA JORGE ALEJANDRO', 10, '5', 'Vespertino', 'fb14a1c9'),
(286, '1315583334', 'ALAVA CEDEÑO HUGO ANTONIO', 10, '5', 'Vespertino', 'fb14a28f'),
(287, '1313380535', 'MACIAS DELGADO HUGO RICARDO', 10, '6', 'Vespertino', 'fb14a2ea'),
(288, '1308536067', 'SABANDO CASTRO VIRGILIO ARMANDO', 10, '6', 'Vespertino', 'fb14a357'),
(289, '1314309582', 'MURILLO CEDEÑO ALEXI LEONEL', 10, '3', 'Vespertino', 'fb14a3bd'),
(290, '1314586734', 'RIVADENEIRA CHANCAY MARCOS ANTONIO', 10, '5', 'Vespertino', 'fb14a3d5'),
(291, '1314872480', 'RIVADENEIRA CHANCAY HEIDI NATHALY', 10, '6', 'Vespertino', 'fb14a3f4'),
(292, '1311674012', 'BENDACK CUADROS CARLOS RENE', 10, '6', 'Vespertino', 'fb14a412'),
(293, '1314768621', 'NAVARRETE CANTOS EDWIN ANTONIO', 10, '5', 'Vespertino', 'fb14a44e'),
(294, '1310509037', 'ZAPATA CHILAN LUIS EDUARDO', 10, '5', 'Vespertino', 'fb14a460'),
(295, '1727523886', 'RODRÍGUEZ ALVARADO RAÚL ANTONIO', 10, '4', 'Nocturno', 'fb14a4ea'),
(296, '1315344208', 'NAVIA ALVARADO GERMAN ELIECER', 10, '4', 'Nocturno', 'fb14a59f'),
(297, '1314714484', 'CEVALLOS REYES MICHAEL ALFREDO', 10, '4', 'Nocturno', 'fb14a618'),
(298, '1315274033', 'martinez intriago ARIEL STEEVEN', 10, '1', 'Nocturno', 'fb14a62c'),
(299, '1313762260', 'ZAVALA VERA RAISA VALERIA', 10, '4', 'Nocturno', 'fb14a688'),
(300, '2450035296', 'ZAMBRANO DUEÑAS JORDAN RICARDO', 10, '4', 'Nocturno', 'fb14a69a'),
(301, '1310230899', 'MENDOZA ROMERO MAGALY KATHERINE', 10, '4', 'Nocturno', 'fb14a6bf'),
(302, '1315885879', 'VELIZ MALDONADO ROBERTH ALBERTO', 10, '4', 'Nocturno', 'fb14a841'),
(303, '1316382207', 'ARREGUI PONCE NAOMY ESTEFANIA', 10, '4', 'Nocturno', 'fb14a852'),
(304, '1350037725', 'ESPINOSA CEDEÑO PABLO ANDRES', 10, '4', 'Nocturno', 'fb14a8af'),
(305, '1351847254', 'ARIAS MACIAS CHRISTOFFER GABRIEL', 10, '3', 'Nocturno', 'fb14a983'),
(306, '1312793324', 'MEZA PAZMIÑO INGRID ELIZABETH', 10, '4', 'Nocturno', 'fb14a9dc'),
(307, '1317864195', 'VILLARREAL ELINAN STEFANY LAURA', 10, '4', 'Nocturno', 'fb14aa9d'),
(308, '1313874453', 'PONCE MACIAS LUIS ANDRES', 10, '4', 'Nocturno', 'fb14ab60');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_evaluacion_estudiante`
--

CREATE TABLE `tb_evaluacion_estudiante` (
  `idevaluacion` int(11) NOT NULL,
  `idestudiante` int(11) NOT NULL,
  `idsilabo` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_evaluacion_estudiante`
--

INSERT INTO `tb_evaluacion_estudiante` (`idevaluacion`, `idestudiante`, `idsilabo`, `estado`) VALUES
(74, 133, 16, 1),
(75, 134, 16, 1),
(76, 135, 16, 0),
(77, 136, 16, 0),
(78, 137, 16, 0),
(79, 133, 104, 1),
(80, 134, 104, 1),
(81, 135, 104, 0),
(82, 136, 104, 0),
(83, 137, 104, 0),
(84, 133, 62, 1),
(85, 134, 62, 1),
(86, 135, 62, 0),
(87, 136, 62, 0),
(88, 137, 62, 0),
(89, 233, 29, 0),
(90, 236, 29, 1),
(91, 237, 29, 1),
(92, 238, 29, 1),
(93, 241, 29, 0),
(94, 242, 29, 0),
(95, 246, 29, 1),
(96, 247, 29, 1),
(97, 249, 29, 1),
(98, 253, 29, 1),
(99, 255, 29, 1),
(100, 256, 29, 1),
(101, 257, 29, 0),
(102, 258, 29, 0),
(103, 264, 29, 0),
(104, 233, 107, 0),
(105, 236, 107, 1),
(106, 237, 107, 1),
(107, 238, 107, 1),
(108, 241, 107, 0),
(109, 242, 107, 0),
(110, 246, 107, 1),
(111, 247, 107, 1),
(112, 249, 107, 1),
(113, 253, 107, 1),
(114, 255, 107, 1),
(115, 256, 107, 1),
(116, 257, 107, 0),
(117, 258, 107, 0),
(118, 264, 107, 0),
(119, 121, 132, 1),
(120, 125, 132, 1),
(121, 126, 132, 1),
(122, 127, 132, 1),
(123, 121, 63, 1),
(124, 125, 63, 1),
(125, 126, 63, 1),
(126, 127, 63, 1),
(127, 273, 45, 1),
(128, 274, 45, 0),
(129, 275, 45, 1),
(130, 276, 45, 1),
(131, 277, 45, 1),
(132, 278, 45, 1),
(133, 279, 45, 1),
(134, 281, 45, 1),
(135, 282, 45, 1),
(136, 283, 45, 1),
(137, 287, 45, 0),
(138, 288, 45, 1),
(139, 291, 45, 1),
(140, 292, 45, 0),
(141, 273, 85, 1),
(142, 274, 85, 0),
(143, 275, 85, 1),
(144, 276, 85, 1),
(145, 277, 85, 1),
(146, 278, 85, 1),
(147, 279, 85, 1),
(148, 281, 85, 1),
(149, 282, 85, 1),
(150, 283, 85, 1),
(151, 287, 85, 0),
(152, 288, 85, 1),
(153, 291, 85, 1),
(154, 292, 85, 0),
(155, 273, 72, 1),
(156, 274, 72, 0),
(157, 275, 72, 1),
(158, 276, 72, 1),
(159, 277, 72, 1),
(160, 278, 72, 1),
(161, 279, 72, 1),
(162, 281, 72, 1),
(163, 282, 72, 1),
(164, 283, 72, 1),
(165, 287, 72, 0),
(166, 288, 72, 1),
(167, 291, 72, 1),
(168, 292, 72, 0),
(169, 273, 16, 1),
(170, 274, 16, 0),
(171, 275, 16, 1),
(172, 276, 16, 1),
(173, 277, 16, 1),
(174, 278, 16, 1),
(175, 279, 16, 1),
(176, 281, 16, 1),
(177, 282, 16, 1),
(178, 283, 16, 1),
(179, 287, 16, 0),
(180, 288, 16, 1),
(181, 291, 16, 1),
(182, 292, 16, 0),
(183, 295, 77, 1),
(184, 296, 77, 1),
(185, 297, 77, 1),
(186, 299, 77, 1),
(187, 300, 77, 1),
(188, 301, 77, 1),
(189, 302, 77, 1),
(190, 303, 77, 1),
(191, 304, 77, 0),
(192, 306, 77, 1),
(193, 307, 77, 0),
(194, 308, 77, 0),
(195, 295, 76, 1),
(196, 296, 76, 1),
(197, 297, 76, 1),
(198, 299, 76, 1),
(199, 300, 76, 1),
(200, 301, 76, 1),
(201, 302, 76, 1),
(202, 303, 76, 1),
(203, 304, 76, 0),
(204, 306, 76, 1),
(205, 307, 76, 0),
(206, 308, 76, 0),
(207, 295, 83, 1),
(208, 296, 83, 1),
(209, 297, 83, 1),
(210, 299, 83, 1),
(211, 300, 83, 1),
(212, 301, 83, 1),
(213, 302, 83, 1),
(214, 303, 83, 1),
(215, 304, 83, 0),
(216, 306, 83, 1),
(217, 307, 83, 0),
(218, 308, 83, 0),
(219, 295, 81, 1),
(220, 296, 81, 1),
(221, 297, 81, 1),
(222, 299, 81, 1),
(223, 300, 81, 1),
(224, 301, 81, 1),
(225, 302, 81, 1),
(226, 303, 81, 1),
(227, 304, 81, 0),
(228, 306, 81, 1),
(229, 307, 81, 0),
(230, 308, 81, 0),
(231, 17, 102, 1),
(232, 33, 102, 1),
(233, 36, 102, 1),
(234, 38, 102, 1),
(235, 47, 102, 0),
(236, 48, 102, 1),
(237, 55, 102, 0),
(238, 56, 102, 0),
(239, 57, 102, 1),
(240, 58, 102, 1),
(241, 61, 102, 0),
(242, 62, 102, 1),
(243, 63, 102, 1),
(244, 64, 102, 1),
(245, 65, 102, 1),
(246, 68, 102, 1),
(247, 72, 102, 0),
(248, 73, 102, 1),
(249, 75, 102, 0),
(250, 76, 102, 1),
(251, 77, 102, 0),
(252, 78, 102, 0),
(253, 86, 102, 0),
(254, 87, 102, 0),
(255, 89, 102, 1),
(256, 90, 102, 1),
(257, 17, 34, 1),
(258, 33, 34, 1),
(259, 36, 34, 1),
(260, 38, 34, 1),
(261, 47, 34, 0),
(262, 48, 34, 1),
(263, 55, 34, 0),
(264, 56, 34, 0),
(265, 57, 34, 1),
(266, 58, 34, 1),
(267, 61, 34, 0),
(268, 62, 34, 1),
(269, 63, 34, 1),
(270, 64, 34, 1),
(271, 65, 34, 1),
(272, 68, 34, 1),
(273, 72, 34, 0),
(274, 73, 34, 1),
(275, 75, 34, 0),
(276, 76, 34, 1),
(277, 77, 34, 0),
(278, 78, 34, 0),
(279, 86, 34, 0),
(280, 87, 34, 0),
(281, 89, 34, 1),
(282, 90, 34, 1),
(283, 17, 164, 1),
(284, 33, 164, 1),
(285, 36, 164, 1),
(286, 38, 164, 1),
(287, 47, 164, 0),
(288, 48, 164, 1),
(289, 55, 164, 0),
(290, 56, 164, 0),
(291, 57, 164, 1),
(292, 58, 164, 1),
(293, 61, 164, 0),
(294, 62, 164, 1),
(295, 63, 164, 1),
(296, 64, 164, 1),
(297, 65, 164, 1),
(298, 68, 164, 1),
(299, 72, 164, 0),
(300, 73, 164, 1),
(301, 75, 164, 0),
(302, 76, 164, 1),
(303, 77, 164, 0),
(304, 78, 164, 0),
(305, 86, 164, 0),
(306, 87, 164, 0),
(307, 89, 164, 1),
(308, 90, 164, 1),
(309, 17, 39, 1),
(310, 33, 39, 1),
(311, 36, 39, 1),
(312, 38, 39, 1),
(313, 47, 39, 0),
(314, 48, 39, 1),
(315, 55, 39, 0),
(316, 56, 39, 0),
(317, 57, 39, 1),
(318, 58, 39, 1),
(319, 61, 39, 0),
(320, 62, 39, 1),
(321, 63, 39, 1),
(322, 64, 39, 1),
(323, 65, 39, 1),
(324, 68, 39, 1),
(325, 72, 39, 0),
(326, 73, 39, 1),
(327, 75, 39, 0),
(328, 76, 39, 1),
(329, 77, 39, 0),
(330, 78, 39, 0),
(331, 86, 39, 0),
(332, 87, 39, 0),
(333, 89, 39, 1),
(334, 90, 39, 1),
(335, 17, 82, 1),
(336, 33, 82, 1),
(337, 36, 82, 1),
(338, 38, 82, 1),
(339, 47, 82, 0),
(340, 48, 82, 1),
(341, 55, 82, 0),
(342, 56, 82, 0),
(343, 57, 82, 1),
(344, 58, 82, 1),
(345, 61, 82, 0),
(346, 62, 82, 1),
(347, 63, 82, 1),
(348, 64, 82, 1),
(349, 65, 82, 1),
(350, 68, 82, 1),
(351, 72, 82, 0),
(352, 73, 82, 1),
(353, 75, 82, 0),
(354, 76, 82, 1),
(355, 77, 82, 0),
(356, 78, 82, 0),
(357, 86, 82, 0),
(358, 87, 82, 0),
(359, 89, 82, 1),
(360, 90, 82, 1),
(361, 234, 27, 0),
(362, 235, 27, 0),
(363, 239, 27, 1),
(364, 240, 27, 1),
(365, 243, 27, 1),
(366, 244, 27, 1),
(367, 245, 27, 0),
(368, 248, 27, 1),
(369, 250, 27, 0),
(370, 251, 27, 1),
(371, 252, 27, 1),
(372, 254, 27, 1),
(373, 259, 27, 0),
(374, 260, 27, 1),
(375, 261, 27, 1),
(376, 262, 27, 1),
(377, 263, 27, 1),
(378, 265, 27, 1),
(379, 266, 27, 1),
(380, 267, 27, 1),
(381, 268, 27, 0),
(382, 269, 27, 1),
(383, 270, 27, 1),
(384, 234, 22, 0),
(385, 235, 22, 0),
(386, 239, 22, 1),
(387, 240, 22, 1),
(388, 243, 22, 1),
(389, 244, 22, 0),
(390, 245, 22, 0),
(391, 248, 22, 1),
(392, 250, 22, 0),
(393, 251, 22, 1),
(394, 252, 22, 1),
(395, 254, 22, 1),
(396, 259, 22, 0),
(397, 260, 22, 1),
(398, 261, 22, 1),
(399, 262, 22, 0),
(400, 263, 22, 1),
(401, 265, 22, 1),
(402, 266, 22, 1),
(403, 267, 22, 1),
(404, 268, 22, 0),
(405, 269, 22, 1),
(406, 270, 22, 1),
(407, 234, 11, 0),
(408, 235, 11, 0),
(409, 239, 11, 1),
(410, 240, 11, 1),
(411, 243, 11, 1),
(412, 244, 11, 0),
(413, 245, 11, 0),
(414, 248, 11, 1),
(415, 250, 11, 0),
(416, 251, 11, 1),
(417, 252, 11, 1),
(418, 254, 11, 1),
(419, 259, 11, 0),
(420, 260, 11, 1),
(421, 261, 11, 1),
(422, 262, 11, 1),
(423, 263, 11, 1),
(424, 265, 11, 1),
(425, 266, 11, 1),
(426, 267, 11, 1),
(427, 268, 11, 0),
(428, 269, 11, 1),
(429, 270, 11, 1),
(430, 234, 31, 0),
(431, 235, 31, 0),
(432, 239, 31, 1),
(433, 240, 31, 1),
(434, 243, 31, 1),
(435, 244, 31, 1),
(436, 245, 31, 1),
(437, 248, 31, 1),
(438, 250, 31, 0),
(439, 251, 31, 1),
(440, 252, 31, 1),
(441, 254, 31, 1),
(442, 259, 31, 1),
(443, 260, 31, 1),
(444, 261, 31, 1),
(445, 262, 31, 1),
(446, 263, 31, 1),
(447, 265, 31, 1),
(448, 266, 31, 1),
(449, 267, 31, 1),
(450, 268, 31, 0),
(451, 269, 31, 1),
(452, 270, 31, 1),
(453, 234, 28, 0),
(454, 235, 28, 0),
(455, 239, 28, 1),
(456, 240, 28, 1),
(457, 243, 28, 1),
(458, 244, 28, 0),
(459, 245, 28, 0),
(460, 248, 28, 1),
(461, 250, 28, 0),
(462, 251, 28, 1),
(463, 252, 28, 1),
(464, 254, 28, 1),
(465, 259, 28, 1),
(466, 260, 28, 1),
(467, 261, 28, 1),
(468, 262, 28, 0),
(469, 263, 28, 1),
(470, 265, 28, 1),
(471, 266, 28, 1),
(472, 267, 28, 1),
(473, 268, 28, 0),
(474, 269, 28, 1),
(475, 270, 28, 1),
(476, 234, 165, 0),
(477, 235, 165, 0),
(478, 239, 165, 1),
(479, 240, 165, 1),
(480, 243, 165, 1),
(481, 244, 165, 0),
(482, 245, 165, 0),
(483, 248, 165, 1),
(484, 250, 165, 0),
(485, 251, 165, 1),
(486, 252, 165, 1),
(487, 254, 165, 1),
(488, 259, 165, 0),
(489, 260, 165, 1),
(490, 261, 165, 1),
(491, 262, 165, 1),
(492, 263, 165, 1),
(493, 265, 165, 1),
(494, 266, 165, 1),
(495, 267, 165, 1),
(496, 268, 165, 0),
(497, 269, 165, 1),
(498, 270, 165, 1),
(499, 289, 74, 1),
(500, 289, 86, 1),
(501, 289, 79, 1),
(502, 289, 9, 1),
(503, 289, 87, 1),
(504, 12, 41, 1),
(505, 25, 41, 1),
(506, 26, 41, 1),
(507, 28, 41, 1),
(508, 30, 41, 1),
(509, 35, 41, 1),
(510, 37, 41, 1),
(511, 39, 41, 1),
(512, 41, 41, 1),
(513, 43, 41, 1),
(514, 44, 41, 1),
(515, 49, 41, 1),
(516, 50, 41, 1),
(517, 54, 41, 1),
(518, 60, 41, 1),
(519, 69, 41, 1),
(520, 70, 41, 1),
(521, 71, 41, 1),
(522, 79, 41, 1),
(523, 80, 41, 1),
(524, 81, 41, 1),
(525, 82, 41, 1),
(526, 83, 41, 1),
(527, 84, 41, 1),
(528, 85, 41, 1),
(529, 88, 41, 1),
(530, 12, 65, 1),
(531, 25, 65, 1),
(532, 26, 65, 1),
(533, 28, 65, 1),
(534, 30, 65, 1),
(535, 35, 65, 1),
(536, 37, 65, 1),
(537, 39, 65, 1),
(538, 41, 65, 1),
(539, 43, 65, 1),
(540, 44, 65, 1),
(541, 49, 65, 1),
(542, 50, 65, 1),
(543, 54, 65, 1),
(544, 60, 65, 1),
(545, 69, 65, 1),
(546, 70, 65, 1),
(547, 71, 65, 1),
(548, 79, 65, 1),
(549, 80, 65, 1),
(550, 81, 65, 1),
(551, 82, 65, 1),
(552, 83, 65, 1),
(553, 84, 65, 1),
(554, 85, 65, 1),
(555, 88, 65, 1),
(556, 12, 42, 1),
(557, 25, 42, 1),
(558, 26, 42, 1),
(559, 28, 42, 1),
(560, 30, 42, 1),
(561, 35, 42, 1),
(562, 37, 42, 1),
(563, 39, 42, 1),
(564, 41, 42, 1),
(565, 43, 42, 1),
(566, 44, 42, 1),
(567, 49, 42, 1),
(568, 50, 42, 1),
(569, 54, 42, 1),
(570, 60, 42, 1),
(571, 69, 42, 1),
(572, 70, 42, 1),
(573, 71, 42, 1),
(574, 79, 42, 1),
(575, 80, 42, 1),
(576, 81, 42, 1),
(577, 82, 42, 1),
(578, 83, 42, 1),
(579, 84, 42, 1),
(580, 85, 42, 1),
(581, 88, 42, 1),
(582, 12, 38, 1),
(583, 25, 38, 1),
(584, 26, 38, 1),
(585, 28, 38, 1),
(586, 30, 38, 1),
(587, 35, 38, 1),
(588, 37, 38, 1),
(589, 39, 38, 1),
(590, 41, 38, 1),
(591, 43, 38, 1),
(592, 44, 38, 1),
(593, 49, 38, 1),
(594, 50, 38, 1),
(595, 54, 38, 1),
(596, 60, 38, 1),
(597, 69, 38, 1),
(598, 70, 38, 1),
(599, 71, 38, 1),
(600, 79, 38, 1),
(601, 80, 38, 1),
(602, 81, 38, 1),
(603, 82, 38, 1),
(604, 83, 38, 1),
(605, 84, 38, 1),
(606, 85, 38, 1),
(607, 88, 38, 1),
(608, 12, 69, 1),
(609, 25, 69, 1),
(610, 26, 69, 1),
(611, 28, 69, 1),
(612, 30, 69, 1),
(613, 35, 69, 1),
(614, 37, 69, 1),
(615, 39, 69, 1),
(616, 41, 69, 1),
(617, 43, 69, 1),
(618, 44, 69, 1),
(619, 49, 69, 1),
(620, 50, 69, 1),
(621, 54, 69, 1),
(622, 60, 69, 1),
(623, 69, 69, 1),
(624, 70, 69, 1),
(625, 71, 69, 1),
(626, 79, 69, 1),
(627, 80, 69, 1),
(628, 81, 69, 1),
(629, 82, 69, 1),
(630, 83, 69, 1),
(631, 84, 69, 1),
(632, 85, 69, 1),
(633, 88, 69, 1),
(634, 114, 141, 0),
(635, 115, 141, 1),
(636, 116, 141, 1),
(637, 117, 141, 1),
(638, 118, 141, 0),
(639, 119, 141, 1),
(640, 120, 141, 1),
(641, 122, 141, 1),
(642, 130, 141, 1),
(643, 131, 141, 1),
(644, 132, 141, 1),
(645, 114, 126, 0),
(646, 115, 126, 1),
(647, 116, 126, 1),
(648, 117, 126, 1),
(649, 118, 126, 0),
(650, 119, 126, 1),
(651, 120, 126, 1),
(652, 122, 126, 1),
(653, 130, 126, 1),
(654, 131, 126, 1),
(655, 132, 126, 1),
(656, 114, 130, 0),
(657, 115, 130, 1),
(658, 116, 130, 1),
(659, 117, 130, 1),
(660, 118, 130, 0),
(661, 119, 130, 1),
(662, 120, 130, 1),
(663, 122, 130, 1),
(664, 130, 130, 1),
(665, 131, 130, 1),
(666, 132, 130, 1),
(667, 114, 157, 0),
(668, 115, 157, 1),
(669, 116, 157, 1),
(670, 117, 157, 1),
(671, 118, 157, 0),
(672, 119, 157, 1),
(673, 120, 157, 1),
(674, 122, 157, 1),
(675, 130, 157, 1),
(676, 131, 157, 1),
(677, 132, 157, 1),
(678, 114, 155, 0),
(679, 115, 155, 1),
(680, 116, 155, 1),
(681, 117, 155, 1),
(682, 118, 155, 0),
(683, 119, 155, 1),
(684, 120, 155, 1),
(685, 122, 155, 1),
(686, 130, 155, 1),
(687, 131, 155, 1),
(688, 132, 155, 1),
(689, 114, 158, 0),
(690, 115, 158, 1),
(691, 116, 158, 1),
(692, 117, 158, 1),
(693, 118, 158, 0),
(694, 119, 158, 1),
(695, 120, 158, 1),
(696, 122, 158, 1),
(697, 130, 158, 1),
(698, 131, 158, 1),
(699, 132, 158, 1),
(700, 138, 106, 1),
(701, 141, 106, 0),
(702, 145, 106, 1),
(703, 149, 106, 1),
(704, 152, 106, 1),
(705, 153, 106, 1),
(706, 156, 106, 1),
(707, 157, 106, 1),
(708, 158, 106, 1),
(709, 159, 106, 1),
(710, 160, 106, 0),
(711, 161, 106, 1),
(712, 162, 106, 1),
(713, 164, 106, 0),
(714, 169, 106, 0),
(715, 175, 106, 0),
(716, 176, 106, 1),
(717, 138, 32, 1),
(718, 141, 32, 0),
(719, 145, 32, 1),
(720, 149, 32, 1),
(721, 152, 32, 1),
(722, 153, 32, 1),
(723, 156, 32, 1),
(724, 157, 32, 1),
(725, 158, 32, 1),
(726, 159, 32, 1),
(727, 160, 32, 0),
(728, 161, 32, 1),
(729, 162, 32, 1),
(730, 164, 32, 0),
(731, 169, 32, 0),
(732, 175, 32, 0),
(733, 176, 32, 1),
(734, 138, 30, 1),
(735, 141, 30, 0),
(736, 145, 30, 1),
(737, 149, 30, 1),
(738, 152, 30, 1),
(739, 153, 30, 1),
(740, 156, 30, 1),
(741, 157, 30, 1),
(742, 158, 30, 1),
(743, 159, 30, 1),
(744, 160, 30, 0),
(745, 161, 30, 1),
(746, 162, 30, 1),
(747, 164, 30, 0),
(748, 169, 30, 0),
(749, 175, 30, 0),
(750, 176, 30, 0),
(751, 138, 12, 1),
(752, 141, 12, 0),
(753, 145, 12, 1),
(754, 149, 12, 1),
(755, 152, 12, 1),
(756, 153, 12, 1),
(757, 156, 12, 1),
(758, 157, 12, 1),
(759, 158, 12, 1),
(760, 159, 12, 1),
(761, 160, 12, 0),
(762, 161, 12, 1),
(763, 162, 12, 1),
(764, 164, 12, 0),
(765, 169, 12, 0),
(766, 175, 12, 0),
(767, 176, 12, 1),
(768, 138, 15, 1),
(769, 141, 15, 0),
(770, 145, 15, 1),
(771, 149, 15, 1),
(772, 152, 15, 1),
(773, 153, 15, 1),
(774, 156, 15, 1),
(775, 157, 15, 1),
(776, 158, 15, 1),
(777, 159, 15, 1),
(778, 160, 15, 0),
(779, 161, 15, 1),
(780, 162, 15, 1),
(781, 164, 15, 0),
(782, 169, 15, 0),
(783, 175, 15, 0),
(784, 176, 15, 0),
(785, 11, 36, 1),
(786, 13, 36, 1),
(787, 14, 36, 1),
(788, 15, 36, 1),
(789, 16, 36, 1),
(790, 18, 36, 1),
(791, 19, 36, 1),
(792, 20, 36, 1),
(793, 21, 36, 1),
(794, 22, 36, 1),
(795, 23, 36, 1),
(796, 24, 36, 1),
(797, 27, 36, 0),
(798, 29, 36, 0),
(799, 31, 36, 0),
(800, 32, 36, 1),
(801, 34, 36, 0),
(802, 40, 36, 1),
(803, 42, 36, 1),
(804, 45, 36, 1),
(805, 46, 36, 1),
(806, 51, 36, 0),
(807, 52, 36, 1),
(808, 53, 36, 1),
(809, 59, 36, 0),
(810, 66, 36, 1),
(811, 67, 36, 1),
(812, 74, 36, 1),
(813, 11, 66, 1),
(814, 13, 66, 1),
(815, 14, 66, 1),
(816, 15, 66, 1),
(817, 16, 66, 1),
(818, 18, 66, 1),
(819, 19, 66, 1),
(820, 20, 66, 1),
(821, 21, 66, 1),
(822, 22, 66, 1),
(823, 23, 66, 1),
(824, 24, 66, 1),
(825, 27, 66, 0),
(826, 29, 66, 0),
(827, 31, 66, 0),
(828, 32, 66, 1),
(829, 34, 66, 0),
(830, 40, 66, 1),
(831, 42, 66, 1),
(832, 45, 66, 1),
(833, 46, 66, 1),
(834, 51, 66, 1),
(835, 52, 66, 1),
(836, 53, 66, 1),
(837, 59, 66, 1),
(838, 66, 66, 1),
(839, 67, 66, 1),
(840, 74, 66, 1),
(841, 11, 43, 1),
(842, 13, 43, 1),
(843, 14, 43, 1),
(844, 15, 43, 1),
(845, 16, 43, 1),
(846, 18, 43, 1),
(847, 19, 43, 1),
(848, 20, 43, 1),
(849, 21, 43, 1),
(850, 22, 43, 1),
(851, 23, 43, 1),
(852, 24, 43, 1),
(853, 27, 43, 0),
(854, 29, 43, 0),
(855, 31, 43, 0),
(856, 32, 43, 1),
(857, 34, 43, 0),
(858, 40, 43, 1),
(859, 42, 43, 1),
(860, 45, 43, 1),
(861, 46, 43, 1),
(862, 51, 43, 1),
(863, 52, 43, 1),
(864, 53, 43, 1),
(865, 59, 43, 1),
(866, 66, 43, 1),
(867, 67, 43, 1),
(868, 74, 43, 1),
(869, 11, 40, 1),
(870, 13, 40, 1),
(871, 14, 40, 1),
(872, 15, 40, 1),
(873, 16, 40, 1),
(874, 18, 40, 1),
(875, 19, 40, 1),
(876, 20, 40, 1),
(877, 21, 40, 1),
(878, 22, 40, 1),
(879, 23, 40, 1),
(880, 24, 40, 1),
(881, 27, 40, 0),
(882, 29, 40, 0),
(883, 31, 40, 0),
(884, 32, 40, 1),
(885, 34, 40, 0),
(886, 40, 40, 1),
(887, 42, 40, 1),
(888, 45, 40, 1),
(889, 46, 40, 1),
(890, 51, 40, 1),
(891, 52, 40, 1),
(892, 53, 40, 1),
(893, 59, 40, 1),
(894, 66, 40, 1),
(895, 67, 40, 1),
(896, 74, 40, 1),
(897, 11, 90, 1),
(898, 13, 90, 1),
(899, 14, 90, 1),
(900, 15, 90, 1),
(901, 16, 90, 1),
(902, 18, 90, 1),
(903, 19, 90, 1),
(904, 20, 90, 1),
(905, 21, 90, 1),
(906, 22, 90, 1),
(907, 23, 90, 1),
(908, 24, 90, 1),
(909, 27, 90, 0),
(910, 29, 90, 0),
(911, 31, 90, 0),
(912, 32, 90, 1),
(913, 34, 90, 0),
(914, 40, 90, 1),
(915, 42, 90, 1),
(916, 45, 90, 1),
(917, 46, 90, 1),
(918, 51, 90, 1),
(919, 52, 90, 1),
(920, 53, 90, 1),
(921, 59, 90, 1),
(922, 66, 90, 1),
(923, 67, 90, 1),
(924, 74, 90, 1),
(925, 11, 129, 1),
(926, 13, 129, 1),
(927, 14, 129, 1),
(928, 15, 129, 1),
(929, 16, 129, 1),
(930, 18, 129, 1),
(931, 19, 129, 1),
(932, 20, 129, 1),
(933, 21, 129, 1),
(934, 22, 129, 1),
(935, 23, 129, 1),
(936, 24, 129, 1),
(937, 27, 129, 0),
(938, 29, 129, 0),
(939, 31, 129, 0),
(940, 32, 129, 1),
(941, 34, 129, 0),
(942, 40, 129, 1),
(943, 42, 129, 1),
(944, 45, 129, 1),
(945, 46, 129, 1),
(946, 51, 129, 1),
(947, 52, 129, 1),
(948, 53, 129, 1),
(949, 59, 129, 1),
(950, 66, 129, 1),
(951, 67, 129, 1),
(952, 74, 129, 1),
(953, 123, 140, 1),
(954, 124, 140, 0),
(955, 128, 140, 1),
(956, 129, 140, 1),
(957, 123, 110, 1),
(958, 124, 110, 0),
(959, 128, 110, 1),
(960, 129, 110, 1),
(961, 123, 17, 1),
(962, 124, 17, 0),
(963, 128, 17, 1),
(964, 129, 17, 1),
(965, 123, 120, 1),
(966, 124, 120, 0),
(967, 128, 120, 1),
(968, 129, 120, 1),
(969, 123, 156, 1),
(970, 124, 156, 0),
(971, 128, 156, 1),
(972, 129, 156, 1),
(973, 123, 1, 1),
(974, 124, 1, 0),
(975, 128, 1, 1),
(976, 129, 1, 1),
(977, 298, 25, 0),
(978, 298, 110, 0),
(979, 298, 18, 0),
(980, 298, 73, 0),
(981, 298, 67, 0),
(982, 298, 166, 0),
(983, 1, 162, 1),
(984, 2, 162, 1),
(985, 3, 162, 1),
(986, 4, 162, 1),
(987, 5, 162, 1),
(988, 6, 162, 1),
(989, 7, 162, 0),
(990, 8, 162, 1),
(991, 9, 162, 0),
(992, 10, 162, 0),
(993, 1, 163, 1),
(994, 2, 163, 1),
(995, 3, 163, 1),
(996, 4, 163, 1),
(997, 5, 163, 0),
(998, 6, 163, 1),
(999, 7, 163, 0),
(1000, 8, 163, 1),
(1001, 9, 163, 0),
(1002, 10, 163, 0),
(1003, 1, 35, 1),
(1004, 2, 35, 1),
(1005, 3, 35, 1),
(1006, 4, 35, 1),
(1007, 5, 35, 1),
(1008, 6, 35, 1),
(1009, 7, 35, 0),
(1010, 8, 35, 1),
(1011, 9, 35, 0),
(1012, 10, 35, 0),
(1013, 1, 88, 1),
(1014, 2, 88, 1),
(1015, 3, 88, 1),
(1016, 4, 88, 1),
(1017, 5, 88, 1),
(1018, 6, 88, 1),
(1019, 7, 88, 0),
(1020, 8, 88, 1),
(1021, 9, 88, 0),
(1022, 10, 88, 0),
(1023, 1, 44, 1),
(1024, 2, 44, 1),
(1025, 3, 44, 1),
(1026, 4, 44, 1),
(1027, 5, 44, 1),
(1028, 6, 44, 1),
(1029, 7, 44, 0),
(1030, 8, 44, 1),
(1031, 9, 44, 0),
(1032, 10, 44, 0),
(1033, 1, 91, 1),
(1034, 2, 91, 1),
(1035, 3, 91, 1),
(1036, 4, 91, 1),
(1037, 5, 91, 1),
(1038, 6, 91, 1),
(1039, 7, 91, 0),
(1040, 8, 91, 1),
(1041, 9, 91, 0),
(1042, 10, 91, 0),
(1043, 1, 103, 1),
(1044, 2, 103, 1),
(1045, 3, 103, 1),
(1046, 4, 103, 1),
(1047, 5, 103, 0),
(1048, 6, 103, 1),
(1049, 7, 103, 0),
(1050, 8, 103, 1),
(1051, 9, 103, 0),
(1052, 10, 103, 0),
(1053, 139, 67, 1),
(1054, 140, 67, 1),
(1055, 143, 67, 1),
(1056, 146, 67, 0),
(1057, 147, 67, 0),
(1058, 148, 67, 1),
(1059, 150, 67, 1),
(1060, 151, 67, 1),
(1061, 154, 67, 0),
(1062, 163, 67, 1),
(1063, 168, 67, 1),
(1064, 173, 67, 1),
(1065, 178, 67, 0),
(1066, 139, 25, 1),
(1067, 140, 25, 1),
(1068, 143, 25, 1),
(1069, 146, 25, 0),
(1070, 147, 25, 0),
(1071, 148, 25, 1),
(1072, 150, 25, 1),
(1073, 151, 25, 1),
(1074, 154, 25, 0),
(1075, 163, 25, 1),
(1076, 168, 25, 1),
(1077, 173, 25, 1),
(1078, 178, 25, 0),
(1079, 139, 24, 1),
(1080, 140, 24, 1),
(1081, 143, 24, 1),
(1082, 146, 24, 0),
(1083, 147, 24, 0),
(1084, 148, 24, 1),
(1085, 150, 24, 1),
(1086, 151, 24, 1),
(1087, 154, 24, 0),
(1088, 163, 24, 1),
(1089, 168, 24, 1),
(1090, 173, 24, 1),
(1091, 178, 24, 0),
(1092, 139, 110, 1),
(1093, 140, 110, 1),
(1094, 143, 110, 1),
(1095, 146, 110, 0),
(1096, 147, 110, 0),
(1097, 148, 110, 1),
(1098, 150, 110, 1),
(1099, 151, 110, 1),
(1100, 154, 110, 0),
(1101, 163, 110, 1),
(1102, 168, 110, 1),
(1103, 173, 110, 1),
(1104, 178, 110, 0),
(1105, 139, 133, 1),
(1106, 140, 133, 1),
(1107, 143, 133, 1),
(1108, 146, 133, 0),
(1109, 147, 133, 0),
(1110, 148, 133, 1),
(1111, 150, 133, 1),
(1112, 151, 133, 1),
(1113, 154, 133, 0),
(1114, 163, 133, 1),
(1115, 168, 133, 1),
(1116, 173, 133, 1),
(1117, 178, 133, 0),
(1118, 142, 14, 0),
(1119, 144, 14, 0),
(1120, 155, 14, 0),
(1121, 165, 14, 0),
(1122, 166, 14, 0),
(1123, 167, 14, 0),
(1124, 170, 14, 0),
(1125, 171, 14, 0),
(1126, 172, 14, 0),
(1127, 174, 14, 0),
(1128, 177, 14, 0),
(1129, 142, 33, 0),
(1130, 144, 33, 0),
(1131, 155, 33, 0),
(1132, 165, 33, 0),
(1133, 166, 33, 0),
(1134, 167, 33, 0),
(1135, 170, 33, 0),
(1136, 171, 33, 0),
(1137, 172, 33, 0),
(1138, 174, 33, 0),
(1139, 177, 33, 0),
(1140, 142, 9, 0),
(1141, 144, 9, 0),
(1142, 155, 9, 0),
(1143, 165, 9, 0),
(1144, 166, 9, 0),
(1145, 167, 9, 0),
(1146, 170, 9, 0),
(1147, 171, 9, 0),
(1148, 172, 9, 0),
(1149, 174, 9, 0),
(1150, 177, 9, 0),
(1151, 142, 23, 0),
(1152, 144, 23, 0),
(1153, 155, 23, 0),
(1154, 165, 23, 0),
(1155, 166, 23, 0),
(1156, 167, 23, 0),
(1157, 170, 23, 0),
(1158, 171, 23, 0),
(1159, 172, 23, 0),
(1160, 174, 23, 0),
(1161, 177, 23, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_heteroevaluacion`
--

CREATE TABLE `tb_heteroevaluacion` (
  `idheteroevaluacion` int(11) NOT NULL,
  `idautoridad` int(11) NOT NULL,
  `iddocente` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_heteroevaluacion`
--

INSERT INTO `tb_heteroevaluacion` (`idheteroevaluacion`, `idautoridad`, `iddocente`, `estado`) VALUES
(1, 5, 23, 1),
(2, 5, 21, 1),
(3, 5, 18, 1),
(4, 5, 30, 1),
(5, 5, 14, 1),
(6, 5, 35, 1),
(7, 5, 22, 1),
(8, 5, 38, 1),
(9, 5, 20, 1),
(10, 5, 32, 1),
(11, 5, 36, 1),
(12, 5, 27, 1),
(13, 5, 6, 1),
(14, 5, 33, 1),
(15, 5, 1, 1),
(16, 5, 37, 1),
(17, 5, 28, 1),
(18, 5, 17, 1),
(19, 5, 7, 1),
(20, 5, 26, 1),
(21, 5, 39, 1),
(22, 5, 19, 1),
(24, 5, 31, 1),
(25, 5, 15, 1),
(27, 5, 24, 1),
(28, 5, 34, 1),
(29, 5, 16, 1),
(30, 2, 27, 1),
(31, 2, 31, 1),
(32, 2, 7, 1),
(33, 2, 26, 1),
(34, 2, 6, 1),
(35, 2, 36, 1),
(36, 4, 31, 1),
(37, 4, 24, 1),
(38, 4, 19, 1),
(39, 4, 28, 1),
(40, 4, 35, 1),
(41, 4, 14, 1),
(42, 4, 23, 1),
(43, 4, 18, 1),
(44, 4, 29, 1),
(45, 4, 33, 1),
(46, 4, 26, 1),
(47, 4, 36, 1),
(48, 3, 21, 1),
(49, 3, 16, 1),
(50, 3, 15, 1),
(51, 4, 34, 1),
(52, 2, 23, 1),
(53, 5, 29, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_heteroevaluacion_administrativo`
--

CREATE TABLE `tb_heteroevaluacion_administrativo` (
  `idheteroevaluacion` int(11) NOT NULL,
  `idautoridad` int(11) NOT NULL,
  `idadministrativo` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_heteroevaluacion_administrativo`
--

INSERT INTO `tb_heteroevaluacion_administrativo` (`idheteroevaluacion`, `idautoridad`, `idadministrativo`, `estado`) VALUES
(6, 2, 8, 1),
(7, 2, 5, 1),
(8, 2, 14, 1),
(9, 4, 6, 1),
(10, 5, 10, 1),
(11, 6, 15, 1),
(12, 6, 18, 1),
(13, 7, 17, 1),
(14, 7, 9, 1),
(15, 7, 4, 1),
(16, 7, 7, 1),
(17, 7, 16, 1),
(18, 7, 16, 0),
(19, 7, 11, 1),
(20, 7, 13, 1),
(21, 7, 12, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_heteroevaluacion_estudiante_administrativo`
--

CREATE TABLE `tb_heteroevaluacion_estudiante_administrativo` (
  `idheteroevaluacion` int(11) NOT NULL,
  `idadministrativo` int(11) NOT NULL,
  `idestudiante` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_heteroevaluacion_estudiante_administrativo`
--

INSERT INTO `tb_heteroevaluacion_estudiante_administrativo` (`idheteroevaluacion`, `idadministrativo`, `idestudiante`, `total`, `estado`) VALUES
(18, 17, 220, 100, 1),
(19, 4, 220, 80, 1),
(20, 5, 220, 80, 1),
(21, 6, 220, 100, 1),
(22, 7, 220, 80, 1),
(23, 4, 222, 80, 1),
(24, 9, 220, 100, 1),
(25, 6, 222, 100, 1),
(26, 8, 220, 60, 1),
(27, 5, 222, 100, 1),
(28, 10, 220, 80, 1),
(29, 7, 222, 100, 1),
(30, 11, 220, 80, 1),
(31, 12, 220, 80, 1),
(32, 8, 222, 100, 1),
(33, 9, 222, 80, 1),
(34, 13, 220, 60, 1),
(35, 10, 222, 80, 1),
(36, 14, 220, 80, 1),
(37, 11, 222, 80, 1),
(38, 15, 220, 80, 1),
(39, 12, 222, 80, 1),
(40, 13, 222, 80, 1),
(41, 16, 220, 80, 1),
(42, 14, 222, 80, 1),
(43, 18, 220, 80, 1),
(44, 15, 222, 80, 1),
(45, 19, 220, 100, 1),
(46, 16, 222, 80, 1),
(47, 17, 222, 80, 1),
(48, 18, 222, 80, 1),
(49, 19, 222, 80, 1),
(50, 19, 271, 80, 1),
(51, 6, 271, 100, 1),
(52, 7, 271, 80, 1),
(53, 8, 271, 80, 1),
(54, 5, 271, 80, 1),
(55, 4, 271, 60, 1),
(56, 9, 271, 60, 1),
(57, 17, 271, 80, 1),
(58, 18, 271, 60, 1),
(59, 11, 271, 60, 1),
(60, 12, 271, 60, 1),
(61, 4, 205, 100, 1),
(62, 6, 205, 100, 1),
(63, 5, 205, 100, 1),
(64, 7, 205, 100, 1),
(65, 8, 205, 100, 1),
(66, 9, 205, 100, 1),
(67, 10, 205, 100, 1),
(68, 11, 205, 100, 1),
(69, 12, 205, 100, 1),
(70, 13, 205, 40, 1),
(71, 14, 205, 80, 1),
(72, 15, 205, 80, 1),
(73, 16, 205, 100, 1),
(74, 17, 205, 100, 1),
(75, 18, 205, 60, 1),
(76, 19, 205, 100, 1),
(77, 4, 125, 80, 1),
(78, 5, 125, 80, 1),
(79, 7, 125, 80, 1),
(80, 9, 125, 80, 1),
(81, 11, 125, 80, 1),
(82, 13, 125, 80, 1),
(83, 15, 125, 80, 1),
(84, 17, 125, 80, 1),
(85, 19, 125, 80, 1),
(86, 4, 127, 20, 1),
(87, 6, 125, 80, 1),
(88, 8, 125, 80, 1),
(89, 10, 125, 80, 1),
(90, 12, 125, 80, 1),
(91, 14, 125, 80, 1),
(92, 16, 125, 80, 1),
(93, 18, 125, 80, 1),
(94, 4, 127, 60, 1),
(95, 5, 127, 100, 1),
(96, 6, 127, 100, 1),
(97, 7, 127, 100, 1),
(98, 6, 126, 80, 1),
(99, 8, 127, 100, 1),
(100, 17, 126, 60, 1),
(101, 18, 126, 40, 1),
(102, 10, 127, 100, 1),
(103, 9, 127, 100, 1),
(104, 11, 127, 100, 1),
(105, 12, 127, 100, 1),
(106, 13, 127, 100, 1),
(107, 14, 127, 80, 1),
(108, 16, 126, 40, 1),
(109, 15, 127, 100, 1),
(110, 16, 127, 100, 1),
(111, 7, 126, 80, 1),
(112, 4, 126, 60, 1),
(113, 17, 127, 100, 1),
(114, 8, 126, 60, 1),
(115, 18, 127, 100, 1),
(116, 19, 127, 100, 1),
(117, 5, 126, 40, 1),
(118, 9, 126, 40, 1),
(119, 11, 126, 60, 1),
(120, 10, 126, 60, 1),
(121, 14, 126, 60, 1),
(122, 15, 126, 40, 1),
(123, 13, 126, 60, 1),
(124, 12, 126, 40, 1),
(125, 19, 126, 40, 1),
(126, 4, 52, 40, 1),
(127, 6, 52, 100, 1),
(128, 5, 52, 60, 1),
(129, 4, 13, 100, 1),
(130, 7, 52, 40, 1),
(131, 8, 52, 80, 1),
(132, 5, 13, 100, 1),
(133, 6, 13, 100, 1),
(134, 9, 52, 40, 1),
(135, 7, 13, 100, 1),
(136, 10, 52, 60, 1),
(137, 9, 13, 100, 1),
(138, 8, 13, 100, 1),
(139, 11, 52, 60, 1),
(140, 10, 13, 100, 1),
(141, 11, 13, 100, 1),
(142, 12, 13, 100, 1),
(143, 13, 13, 100, 1),
(144, 12, 52, 20, 1),
(145, 14, 13, 100, 1),
(146, 15, 13, 100, 1),
(147, 13, 52, 20, 1),
(148, 16, 13, 100, 1),
(149, 17, 13, 100, 1),
(150, 18, 13, 100, 1),
(151, 14, 52, 40, 1),
(152, 19, 13, 100, 1),
(153, 15, 52, 60, 1),
(154, 16, 52, 80, 1),
(155, 17, 52, 60, 1),
(156, 18, 52, 20, 1),
(157, 19, 52, 80, 1),
(158, 4, 140, 100, 1),
(159, 4, 143, 80, 1),
(160, 6, 143, 80, 1),
(161, 8, 143, 100, 1),
(162, 9, 143, 100, 1),
(163, 11, 143, 100, 1),
(164, 13, 143, 80, 1),
(165, 4, 224, 60, 1),
(166, 16, 143, 80, 1),
(167, 17, 143, 80, 1),
(168, 5, 140, 100, 1),
(169, 4, 33, 100, 1),
(170, 18, 143, 80, 1),
(171, 6, 224, 100, 1),
(172, 6, 140, 100, 1),
(173, 19, 143, 80, 1),
(174, 7, 140, 100, 1),
(175, 6, 148, 20, 1),
(176, 5, 143, 80, 1),
(177, 7, 143, 80, 1),
(178, 4, 148, 80, 1),
(179, 10, 143, 80, 1),
(180, 12, 143, 80, 1),
(181, 19, 224, 60, 1),
(182, 18, 224, 60, 1),
(183, 14, 143, 80, 1),
(184, 5, 224, 40, 1),
(185, 15, 143, 80, 1),
(186, 5, 148, 80, 1),
(187, 7, 224, 60, 1),
(188, 7, 148, 100, 1),
(189, 8, 148, 80, 1),
(190, 8, 224, 40, 1),
(191, 8, 224, 60, 1),
(192, 9, 148, 80, 1),
(193, 9, 224, 80, 1),
(194, 10, 148, 80, 1),
(195, 10, 224, 60, 1),
(196, 11, 148, 80, 1),
(197, 5, 67, 60, 1),
(198, 8, 140, 80, 1),
(199, 10, 224, 80, 1),
(200, 12, 148, 80, 1),
(201, 16, 224, 80, 1),
(202, 13, 148, 80, 1),
(203, 9, 140, 80, 1),
(204, 15, 224, 80, 1),
(205, 14, 148, 80, 1),
(206, 19, 67, 80, 1),
(207, 14, 224, 80, 1),
(208, 15, 148, 80, 1),
(209, 13, 224, 80, 1),
(210, 16, 148, 80, 1),
(211, 4, 67, 80, 1),
(212, 12, 224, 80, 1),
(213, 18, 140, 100, 1),
(214, 17, 148, 80, 1),
(215, 11, 224, 80, 1),
(216, 6, 67, 80, 1),
(217, 18, 148, 80, 1),
(218, 17, 224, 80, 1),
(219, 10, 140, 80, 1),
(220, 19, 148, 80, 1),
(221, 7, 67, 80, 1),
(222, 11, 140, 80, 1),
(223, 12, 140, 80, 1),
(224, 6, 150, 20, 1),
(225, 13, 140, 80, 1),
(226, 8, 67, 60, 1),
(227, 14, 140, 80, 1),
(228, 9, 67, 80, 1),
(229, 7, 150, 80, 1),
(230, 15, 140, 80, 1),
(231, 16, 140, 100, 1),
(232, 17, 140, 100, 1),
(233, 19, 140, 80, 1),
(234, 4, 123, 80, 1),
(235, 6, 151, 100, 1),
(236, 5, 123, 80, 1),
(237, 7, 123, 100, 1),
(238, 9, 123, 100, 1),
(239, 6, 19, 100, 1),
(240, 9, 151, 100, 1),
(241, 11, 123, 80, 1),
(242, 10, 123, 100, 1),
(243, 17, 151, 100, 1),
(244, 6, 123, 100, 1),
(245, 8, 123, 100, 1),
(246, 12, 123, 80, 1),
(247, 13, 123, 80, 1),
(248, 14, 123, 80, 1),
(249, 4, 19, 60, 1),
(250, 15, 123, 80, 1),
(251, 5, 19, 40, 1),
(252, 16, 123, 80, 1),
(253, 8, 19, 40, 1),
(254, 17, 123, 60, 1),
(255, 7, 19, 40, 1),
(256, 18, 123, 60, 1),
(257, 9, 19, 40, 1),
(258, 10, 19, 40, 1),
(259, 19, 123, 100, 1),
(260, 11, 19, 40, 1),
(261, 12, 19, 40, 1),
(262, 13, 19, 60, 1),
(263, 14, 19, 40, 1),
(264, 15, 19, 40, 1),
(265, 16, 19, 40, 1),
(266, 17, 19, 40, 1),
(267, 18, 19, 40, 1),
(268, 19, 19, 20, 1),
(269, 5, 18, 100, 1),
(270, 4, 18, 40, 1),
(271, 6, 18, 40, 1),
(272, 7, 18, 60, 1),
(273, 8, 18, 60, 1),
(274, 9, 18, 60, 1),
(275, 10, 18, 20, 1),
(276, 11, 18, 20, 1),
(277, 12, 18, 60, 1),
(278, 13, 18, 60, 1),
(279, 15, 151, 80, 1),
(280, 18, 151, 80, 1),
(281, 14, 18, 80, 1),
(282, 19, 151, 100, 1),
(283, 15, 18, 80, 1),
(284, 16, 18, 60, 1),
(285, 17, 18, 60, 1),
(286, 18, 18, 60, 1),
(287, 19, 18, 80, 1),
(288, 4, 276, 100, 1),
(289, 5, 276, 100, 1),
(290, 6, 276, 100, 1),
(291, 7, 276, 100, 1),
(292, 8, 276, 100, 1),
(293, 9, 276, 100, 1),
(294, 10, 276, 100, 1),
(295, 11, 276, 100, 1),
(296, 12, 276, 100, 1),
(297, 13, 276, 100, 1),
(298, 14, 276, 100, 1),
(299, 15, 276, 100, 1),
(300, 16, 276, 100, 1),
(301, 17, 276, 100, 1),
(302, 18, 276, 100, 1),
(303, 19, 276, 100, 1),
(304, 4, 165, 100, 1),
(305, 5, 165, 100, 1),
(306, 6, 165, 100, 1),
(307, 7, 165, 100, 1),
(308, 10, 165, 100, 1),
(309, 9, 165, 60, 1),
(310, 8, 165, 80, 1),
(311, 11, 165, 100, 1),
(312, 12, 165, 80, 1),
(313, 13, 165, 100, 1),
(314, 14, 165, 80, 1),
(315, 15, 165, 80, 1),
(316, 16, 165, 80, 1),
(317, 9, 273, 20, 1),
(318, 18, 165, 80, 1),
(319, 19, 165, 80, 1),
(320, 17, 165, 40, 1),
(321, 6, 273, 100, 1),
(322, 17, 273, 80, 1),
(323, 16, 273, 60, 1),
(324, 13, 273, 80, 1),
(325, 4, 139, 60, 1),
(326, 6, 139, 100, 1),
(327, 5, 273, 80, 1),
(328, 7, 139, 80, 1),
(329, 4, 273, 80, 1),
(330, 8, 139, 80, 1),
(331, 7, 273, 80, 1),
(332, 9, 139, 80, 1),
(333, 8, 273, 80, 1),
(334, 19, 139, 80, 1),
(335, 10, 273, 80, 1),
(336, 18, 139, 80, 1),
(337, 11, 273, 80, 1),
(338, 17, 139, 80, 1),
(339, 16, 139, 80, 1),
(340, 12, 273, 80, 1),
(341, 14, 139, 80, 1),
(342, 15, 139, 80, 1),
(343, 14, 273, 80, 1),
(344, 12, 139, 80, 1),
(345, 5, 139, 80, 1),
(346, 11, 139, 80, 1),
(347, 15, 273, 100, 1),
(348, 13, 139, 80, 1),
(349, 6, 281, 100, 1),
(350, 18, 273, 80, 1),
(351, 10, 139, 80, 1),
(352, 19, 273, 80, 1),
(353, 5, 281, 100, 1),
(354, 7, 281, 100, 1),
(355, 4, 281, 100, 1),
(356, 4, 299, 100, 1),
(357, 5, 299, 100, 1),
(358, 9, 281, 100, 1),
(359, 6, 299, 100, 1),
(360, 8, 281, 100, 1),
(361, 7, 299, 100, 1),
(362, 10, 281, 100, 1),
(363, 8, 299, 100, 1),
(364, 11, 281, 100, 1),
(365, 9, 299, 100, 1),
(366, 12, 281, 100, 1),
(367, 10, 299, 100, 1),
(368, 11, 299, 100, 1),
(369, 13, 281, 100, 1),
(370, 12, 299, 100, 1),
(371, 14, 281, 100, 1),
(372, 13, 299, 100, 1),
(373, 15, 281, 100, 1),
(374, 14, 299, 100, 1),
(375, 16, 281, 100, 1),
(376, 17, 281, 100, 1),
(377, 15, 299, 100, 1),
(378, 18, 281, 100, 1),
(379, 16, 299, 100, 1),
(380, 17, 299, 100, 1),
(381, 19, 281, 100, 1),
(382, 18, 299, 100, 1),
(383, 19, 299, 80, 1),
(384, 7, 33, 80, 1),
(385, 6, 33, 100, 1),
(386, 11, 33, 100, 1),
(387, 12, 33, 100, 1),
(388, 13, 33, 100, 1),
(389, 9, 33, 20, 1),
(390, 19, 33, 80, 1),
(391, 4, 302, 20, 1),
(392, 4, 301, 80, 1),
(393, 9, 285, 20, 1),
(394, 6, 301, 100, 1),
(395, 9, 302, 20, 1),
(396, 5, 302, 100, 1),
(397, 19, 285, 100, 1),
(398, 4, 194, 100, 1),
(399, 6, 302, 100, 1),
(400, 5, 301, 80, 1),
(401, 7, 302, 100, 1),
(402, 6, 194, 100, 1),
(403, 5, 285, 100, 1),
(404, 7, 301, 80, 1),
(405, 4, 285, 100, 1),
(406, 13, 302, 100, 1),
(407, 6, 285, 100, 1),
(408, 8, 301, 80, 1),
(409, 8, 302, 100, 1),
(410, 8, 285, 100, 1),
(411, 10, 302, 100, 1),
(412, 7, 285, 100, 1),
(413, 9, 301, 60, 1),
(414, 5, 194, 100, 1),
(415, 10, 285, 100, 1),
(416, 11, 302, 100, 1),
(417, 7, 194, 100, 1),
(418, 11, 285, 100, 1),
(419, 12, 285, 100, 1),
(420, 12, 302, 100, 1),
(421, 13, 285, 100, 1),
(422, 14, 302, 100, 1),
(423, 14, 285, 100, 1),
(424, 10, 301, 80, 1),
(425, 15, 285, 100, 1),
(426, 15, 302, 100, 1),
(427, 16, 285, 100, 1),
(428, 16, 302, 100, 1),
(429, 17, 285, 100, 1),
(430, 17, 302, 100, 1),
(431, 18, 285, 100, 1),
(432, 18, 302, 100, 1),
(433, 19, 302, 100, 1),
(434, 11, 301, 80, 1),
(435, 8, 194, 100, 1),
(436, 12, 301, 80, 1),
(437, 9, 194, 80, 1),
(438, 13, 301, 80, 1),
(439, 10, 194, 100, 1),
(440, 11, 194, 80, 1),
(441, 12, 194, 80, 1),
(442, 19, 177, 100, 1),
(443, 13, 194, 100, 1),
(444, 14, 301, 80, 1),
(445, 5, 177, 100, 1),
(446, 4, 177, 100, 1),
(447, 4, 243, 100, 1),
(448, 9, 177, 80, 1),
(449, 18, 177, 80, 1),
(450, 6, 177, 100, 1),
(451, 5, 243, 80, 1),
(452, 7, 177, 100, 1),
(453, 6, 243, 100, 1),
(454, 8, 177, 100, 1),
(455, 7, 243, 100, 1),
(456, 10, 177, 100, 1),
(457, 8, 243, 100, 1),
(458, 11, 177, 100, 1),
(459, 12, 177, 100, 1),
(460, 9, 243, 100, 1),
(461, 14, 177, 100, 1),
(462, 16, 177, 100, 1),
(463, 10, 243, 100, 1),
(464, 15, 177, 100, 1),
(465, 11, 243, 100, 1),
(466, 17, 177, 100, 1),
(467, 13, 177, 100, 1),
(468, 12, 243, 100, 1),
(469, 13, 243, 100, 1),
(470, 14, 194, 100, 1),
(471, 14, 243, 100, 1),
(472, 15, 301, 100, 1),
(473, 15, 243, 100, 1),
(474, 15, 194, 100, 1),
(475, 16, 243, 100, 1),
(476, 17, 243, 100, 1),
(477, 18, 243, 100, 1),
(478, 16, 301, 80, 1),
(479, 19, 243, 100, 1),
(480, 16, 194, 100, 1),
(481, 17, 301, 80, 1),
(482, 17, 194, 80, 1),
(483, 18, 194, 100, 1),
(484, 18, 301, 80, 1),
(485, 19, 194, 100, 1),
(486, 19, 301, 80, 1),
(487, 19, 240, 20, 1),
(488, 17, 240, 20, 1),
(489, 15, 240, 20, 1),
(490, 18, 240, 20, 1),
(491, 16, 240, 20, 1),
(492, 4, 240, 100, 1),
(493, 5, 240, 100, 1),
(494, 6, 240, 100, 1),
(495, 7, 240, 100, 1),
(496, 8, 240, 100, 1),
(497, 9, 240, 100, 1),
(498, 10, 240, 100, 1),
(499, 14, 240, 100, 1),
(500, 11, 240, 100, 1),
(501, 12, 240, 100, 1),
(502, 13, 240, 100, 1),
(503, 4, 144, 100, 1),
(504, 5, 144, 100, 1),
(505, 6, 144, 80, 1),
(506, 7, 144, 100, 1),
(507, 8, 144, 60, 1),
(508, 9, 144, 80, 1),
(509, 10, 144, 100, 1),
(510, 4, 303, 100, 1),
(511, 11, 144, 100, 1),
(512, 12, 144, 100, 1),
(513, 5, 303, 100, 1),
(514, 6, 303, 100, 1),
(515, 7, 303, 100, 1),
(516, 8, 303, 100, 1),
(517, 13, 144, 80, 1),
(518, 9, 303, 100, 1),
(519, 10, 303, 100, 1),
(520, 14, 144, 60, 1),
(521, 11, 303, 100, 1),
(522, 12, 303, 100, 1),
(523, 15, 144, 60, 1),
(524, 13, 303, 100, 1),
(525, 14, 303, 100, 1),
(526, 15, 303, 100, 1),
(527, 16, 144, 60, 1),
(528, 16, 303, 100, 1),
(529, 17, 303, 100, 1),
(530, 18, 303, 100, 1),
(531, 17, 144, 80, 1),
(532, 19, 303, 100, 1),
(533, 4, 66, 100, 1),
(534, 18, 144, 60, 1),
(535, 19, 144, 60, 1),
(536, 5, 66, 100, 1),
(537, 6, 66, 100, 1),
(538, 7, 66, 100, 1),
(539, 8, 66, 100, 1),
(540, 9, 66, 100, 1),
(541, 10, 66, 100, 1),
(542, 11, 66, 100, 1),
(543, 12, 66, 100, 1),
(544, 13, 66, 100, 1),
(545, 14, 66, 100, 1),
(546, 15, 66, 100, 1),
(547, 16, 66, 100, 1),
(548, 17, 66, 100, 1),
(549, 18, 66, 100, 1),
(550, 19, 66, 100, 1),
(551, 7, 265, 100, 1),
(552, 9, 265, 100, 1),
(553, 4, 265, 100, 1),
(554, 17, 265, 60, 1),
(555, 18, 265, 60, 1),
(556, 6, 265, 100, 1),
(557, 10, 265, 100, 1),
(558, 11, 265, 100, 1),
(559, 12, 265, 40, 1),
(560, 19, 265, 60, 1),
(561, 5, 265, 60, 1),
(562, 8, 265, 60, 1),
(563, 13, 265, 60, 1),
(564, 14, 265, 60, 1),
(565, 15, 265, 60, 1),
(566, 16, 265, 60, 1),
(567, 4, 180, 100, 1),
(568, 6, 180, 100, 1),
(569, 4, 296, 80, 1),
(570, 19, 180, 100, 1),
(571, 5, 296, 80, 1),
(572, 9, 180, 100, 1),
(573, 5, 180, 100, 1),
(574, 6, 296, 100, 1),
(575, 7, 180, 100, 1),
(576, 8, 180, 100, 1),
(577, 7, 296, 100, 1),
(578, 10, 180, 100, 1),
(579, 8, 296, 80, 1),
(580, 11, 180, 100, 1),
(581, 12, 180, 100, 1),
(582, 9, 296, 80, 1),
(583, 13, 180, 100, 1),
(584, 14, 180, 100, 1),
(585, 15, 180, 100, 1),
(586, 10, 296, 80, 1),
(587, 16, 180, 100, 1),
(588, 17, 180, 100, 1),
(589, 11, 296, 80, 1),
(590, 18, 180, 100, 1),
(591, 12, 296, 80, 1),
(592, 13, 296, 80, 1),
(593, 14, 296, 80, 1),
(594, 15, 296, 80, 1),
(595, 16, 296, 80, 1),
(596, 17, 296, 80, 1),
(597, 18, 296, 80, 1),
(598, 19, 296, 80, 1),
(599, 4, 142, 100, 1),
(600, 5, 142, 100, 1),
(601, 6, 142, 100, 1),
(602, 7, 142, 100, 1),
(603, 8, 142, 100, 1),
(604, 9, 142, 100, 1),
(605, 10, 142, 100, 1),
(606, 11, 142, 100, 1),
(607, 12, 142, 100, 1),
(608, 13, 142, 100, 1),
(609, 14, 142, 100, 1),
(610, 15, 142, 100, 1),
(611, 16, 142, 100, 1),
(612, 17, 142, 100, 1),
(613, 18, 142, 100, 1),
(614, 19, 142, 100, 1),
(615, 5, 260, 60, 1),
(616, 4, 260, 60, 1),
(617, 6, 260, 60, 1),
(618, 7, 260, 60, 1),
(619, 8, 260, 60, 1),
(620, 9, 260, 60, 1),
(621, 10, 260, 60, 1),
(622, 11, 260, 60, 1),
(623, 12, 260, 60, 1),
(624, 6, 306, 100, 1),
(625, 13, 260, 60, 1),
(626, 14, 260, 60, 1),
(627, 15, 260, 60, 1),
(628, 16, 260, 60, 1),
(629, 17, 260, 60, 1),
(630, 4, 306, 100, 1),
(631, 18, 260, 60, 1),
(632, 19, 260, 60, 1),
(633, 7, 306, 100, 1),
(634, 10, 306, 80, 1),
(635, 13, 306, 80, 1),
(636, 15, 306, 80, 1),
(637, 19, 306, 80, 1),
(638, 17, 306, 80, 1),
(639, 14, 306, 80, 1),
(640, 11, 306, 80, 1),
(641, 16, 306, 80, 1),
(642, 18, 306, 100, 1),
(643, 12, 306, 80, 1),
(644, 8, 306, 80, 1),
(645, 9, 306, 80, 1),
(646, 5, 306, 100, 1),
(647, 4, 189, 20, 1),
(648, 6, 189, 100, 1),
(649, 5, 189, 100, 1),
(650, 7, 189, 100, 1),
(651, 9, 189, 20, 1),
(652, 8, 189, 100, 1),
(653, 10, 189, 100, 1),
(654, 6, 239, 100, 1),
(655, 11, 189, 100, 1),
(656, 5, 239, 80, 1),
(657, 12, 189, 100, 1),
(658, 13, 189, 100, 1),
(659, 14, 189, 100, 1),
(660, 15, 189, 100, 1),
(661, 16, 189, 100, 1),
(662, 17, 189, 100, 1),
(663, 18, 189, 100, 1),
(664, 7, 261, 100, 1),
(665, 5, 261, 100, 1),
(666, 4, 261, 60, 1),
(667, 6, 261, 60, 1),
(668, 9, 261, 60, 1),
(669, 5, 269, 20, 1),
(670, 8, 261, 80, 1),
(671, 4, 269, 20, 1),
(672, 10, 261, 60, 1),
(673, 6, 269, 100, 1),
(674, 11, 261, 60, 1),
(675, 19, 189, 100, 1),
(676, 7, 269, 100, 1),
(677, 12, 261, 60, 1),
(678, 13, 261, 60, 1),
(679, 14, 261, 60, 1),
(680, 15, 261, 60, 1),
(681, 16, 261, 60, 1),
(682, 17, 261, 60, 1),
(683, 18, 261, 60, 1),
(684, 4, 179, 80, 1),
(685, 19, 261, 60, 1),
(686, 6, 179, 100, 1),
(687, 8, 179, 100, 1),
(688, 10, 179, 100, 1),
(689, 5, 179, 100, 1),
(690, 7, 179, 80, 1),
(691, 9, 179, 40, 1),
(692, 11, 179, 100, 1),
(693, 8, 269, 100, 1),
(694, 9, 269, 100, 1),
(695, 10, 269, 100, 1),
(696, 12, 179, 100, 1),
(697, 11, 269, 100, 1),
(698, 12, 269, 100, 1),
(699, 13, 269, 100, 1),
(700, 13, 179, 60, 1),
(701, 14, 269, 100, 1),
(702, 15, 269, 100, 1),
(703, 14, 179, 100, 1),
(704, 16, 269, 100, 1),
(705, 15, 179, 100, 1),
(706, 17, 269, 100, 1),
(707, 18, 269, 100, 1),
(708, 16, 179, 100, 1),
(709, 19, 269, 100, 1),
(710, 17, 179, 100, 1),
(711, 18, 179, 100, 1),
(712, 19, 179, 100, 1),
(713, 4, 191, 100, 1),
(714, 5, 191, 100, 1),
(715, 6, 191, 100, 1),
(716, 7, 191, 100, 1),
(717, 8, 191, 100, 1),
(718, 9, 191, 20, 1),
(719, 10, 191, 80, 1),
(720, 11, 191, 60, 1),
(721, 12, 191, 60, 1),
(722, 4, 239, 80, 1),
(723, 13, 191, 60, 1),
(724, 14, 191, 80, 1),
(725, 15, 191, 100, 1),
(726, 16, 191, 80, 1),
(727, 17, 191, 80, 1),
(728, 18, 191, 100, 1),
(729, 19, 191, 100, 1),
(730, 8, 239, 80, 1),
(731, 14, 239, 80, 1),
(732, 16, 239, 100, 1),
(733, 17, 239, 100, 1),
(734, 9, 239, 100, 1),
(735, 7, 239, 80, 1),
(736, 10, 239, 80, 1),
(737, 4, 192, 100, 1),
(738, 11, 239, 80, 1),
(739, 12, 239, 80, 1),
(740, 5, 192, 80, 1),
(741, 13, 239, 80, 1),
(742, 15, 239, 80, 1),
(743, 18, 239, 80, 1),
(744, 6, 192, 100, 1),
(745, 19, 239, 80, 1),
(746, 7, 192, 100, 1),
(747, 9, 192, 20, 1),
(748, 8, 192, 80, 1),
(749, 10, 192, 100, 1),
(750, 11, 192, 80, 1),
(751, 12, 192, 100, 1),
(752, 14, 192, 80, 1),
(753, 13, 192, 20, 1),
(754, 15, 192, 100, 1),
(755, 4, 14, 60, 1),
(756, 5, 14, 100, 1),
(757, 6, 14, 100, 1),
(758, 7, 14, 100, 1),
(759, 8, 14, 80, 1),
(760, 16, 192, 100, 1),
(761, 9, 14, 80, 1),
(762, 10, 14, 80, 1),
(763, 17, 192, 80, 1),
(764, 12, 14, 80, 1),
(765, 11, 14, 80, 1),
(766, 13, 14, 80, 1),
(767, 14, 14, 80, 1),
(768, 19, 192, 100, 1),
(769, 18, 192, 100, 1),
(770, 15, 14, 80, 1),
(771, 5, 295, 100, 1),
(772, 4, 295, 100, 1),
(773, 16, 14, 80, 1),
(774, 17, 14, 80, 1),
(775, 6, 295, 100, 1),
(776, 7, 295, 100, 1),
(777, 8, 295, 100, 1),
(778, 18, 14, 80, 1),
(779, 19, 14, 80, 1),
(780, 9, 295, 100, 1),
(781, 10, 295, 100, 1),
(782, 11, 295, 100, 1),
(783, 12, 295, 100, 1),
(784, 13, 295, 100, 1),
(785, 14, 295, 100, 1),
(786, 15, 295, 100, 1),
(787, 16, 295, 100, 1),
(788, 17, 295, 100, 1),
(789, 18, 295, 100, 1),
(790, 19, 295, 100, 1),
(791, 4, 280, 100, 1),
(792, 6, 280, 100, 1),
(793, 5, 280, 100, 1),
(794, 7, 280, 100, 1),
(795, 8, 280, 100, 1),
(796, 9, 280, 100, 1),
(797, 10, 280, 100, 1),
(798, 11, 280, 100, 1),
(799, 12, 280, 100, 1),
(800, 13, 280, 100, 1),
(801, 14, 280, 100, 1),
(802, 15, 280, 100, 1),
(803, 16, 280, 100, 1),
(804, 17, 280, 100, 1),
(805, 18, 280, 100, 1),
(806, 19, 280, 100, 1),
(807, 4, 21, 100, 1),
(808, 6, 21, 100, 1),
(809, 8, 21, 80, 1),
(810, 12, 21, 80, 1),
(811, 11, 21, 100, 1),
(812, 5, 21, 100, 1),
(813, 13, 21, 60, 1),
(814, 9, 21, 20, 1),
(815, 18, 21, 100, 1),
(816, 17, 21, 40, 1),
(817, 19, 21, 80, 1),
(818, 7, 21, 80, 1),
(819, 14, 21, 80, 1),
(820, 10, 21, 80, 1),
(821, 16, 21, 100, 1),
(822, 15, 21, 80, 1),
(823, 5, 42, 100, 1),
(824, 4, 42, 100, 1),
(825, 7, 42, 100, 1),
(826, 9, 42, 100, 1),
(827, 11, 42, 100, 1),
(828, 13, 42, 100, 1),
(829, 19, 42, 100, 1),
(830, 17, 42, 100, 1),
(831, 15, 42, 100, 1),
(832, 12, 42, 100, 1),
(833, 8, 42, 100, 1),
(834, 18, 42, 100, 1),
(835, 16, 42, 100, 1),
(836, 14, 42, 100, 1),
(837, 10, 42, 100, 1),
(838, 6, 42, 100, 1),
(839, 4, 283, 20, 1),
(840, 4, 32, 100, 1),
(841, 5, 32, 100, 1),
(842, 6, 32, 100, 1),
(843, 7, 32, 100, 1),
(844, 8, 32, 100, 1),
(845, 9, 32, 20, 1),
(846, 10, 32, 100, 1),
(847, 11, 32, 100, 1),
(848, 12, 32, 100, 1),
(849, 13, 32, 100, 1),
(850, 14, 32, 100, 1),
(851, 15, 32, 100, 1),
(852, 16, 32, 100, 1),
(853, 17, 32, 80, 1),
(854, 18, 32, 100, 1),
(855, 19, 32, 100, 1),
(856, 4, 22, 100, 1),
(857, 4, 150, 80, 1),
(858, 5, 22, 100, 1),
(859, 5, 150, 80, 1),
(860, 6, 22, 100, 1),
(861, 8, 150, 80, 1),
(862, 9, 150, 80, 1),
(863, 7, 22, 80, 1),
(864, 10, 150, 80, 1),
(865, 11, 150, 80, 1),
(866, 12, 150, 80, 1),
(867, 13, 150, 80, 1),
(868, 14, 150, 80, 1),
(869, 15, 150, 80, 1),
(870, 16, 150, 80, 1),
(871, 4, 151, 80, 1),
(872, 5, 151, 80, 1),
(873, 7, 151, 100, 1),
(874, 17, 150, 60, 1),
(875, 8, 151, 80, 1),
(876, 19, 150, 80, 1),
(877, 10, 151, 100, 1),
(878, 18, 150, 60, 1),
(879, 11, 151, 80, 1),
(880, 12, 151, 80, 1),
(881, 13, 151, 80, 1),
(882, 14, 151, 100, 1),
(883, 16, 151, 100, 1),
(884, 5, 267, 80, 1),
(885, 6, 267, 100, 1),
(886, 8, 22, 80, 1),
(887, 7, 267, 100, 1),
(888, 9, 22, 60, 1),
(889, 10, 22, 80, 1),
(890, 9, 267, 100, 1),
(891, 11, 22, 80, 1),
(892, 11, 267, 100, 1),
(893, 12, 22, 80, 1),
(894, 13, 22, 80, 1),
(895, 14, 22, 80, 1),
(896, 15, 22, 80, 1),
(897, 16, 22, 80, 1),
(898, 17, 22, 60, 1),
(899, 18, 22, 80, 1),
(900, 19, 22, 80, 1),
(901, 17, 267, 100, 1),
(902, 19, 267, 100, 1),
(903, 16, 267, 100, 1),
(904, 14, 267, 40, 1),
(905, 12, 267, 40, 1),
(906, 13, 267, 40, 1),
(907, 10, 267, 60, 1),
(908, 8, 267, 60, 1),
(909, 4, 267, 60, 1),
(910, 15, 267, 20, 1),
(911, 18, 267, 40, 1),
(912, 4, 40, 100, 1),
(913, 5, 40, 40, 1),
(914, 6, 40, 100, 1),
(915, 7, 40, 100, 1),
(916, 8, 40, 60, 1),
(917, 9, 40, 100, 1),
(918, 10, 40, 100, 1),
(919, 11, 40, 60, 1),
(920, 12, 40, 60, 1),
(921, 13, 40, 60, 1),
(922, 14, 40, 60, 1),
(923, 15, 40, 60, 1),
(924, 16, 40, 40, 1),
(925, 17, 40, 100, 1),
(926, 18, 40, 60, 1),
(927, 19, 40, 40, 1),
(928, 5, 23, 100, 1),
(929, 4, 23, 100, 1),
(930, 19, 23, 100, 1),
(931, 6, 23, 100, 1),
(932, 4, 138, 100, 1),
(933, 7, 23, 40, 1),
(934, 5, 138, 80, 1),
(935, 10, 23, 100, 1),
(936, 6, 138, 100, 1),
(937, 7, 138, 100, 1),
(938, 8, 138, 100, 1),
(939, 11, 23, 100, 1),
(940, 9, 138, 100, 1),
(941, 18, 23, 100, 1),
(942, 10, 138, 100, 1),
(943, 11, 138, 100, 1),
(944, 12, 138, 100, 1),
(945, 13, 138, 100, 1),
(946, 14, 138, 100, 1),
(947, 15, 138, 100, 1),
(948, 16, 138, 100, 1),
(949, 17, 138, 100, 1),
(950, 19, 138, 100, 1),
(951, 18, 138, 80, 1),
(952, 6, 93, 100, 1),
(953, 6, 16, 100, 1),
(954, 7, 16, 100, 1),
(955, 12, 16, 100, 1),
(956, 9, 93, 20, 1),
(957, 4, 16, 80, 1),
(958, 5, 16, 80, 1),
(959, 8, 16, 80, 1),
(960, 9, 16, 80, 1),
(961, 10, 16, 40, 1),
(962, 11, 16, 80, 1),
(963, 13, 16, 80, 1),
(964, 14, 16, 80, 1),
(965, 15, 16, 80, 1),
(966, 16, 16, 80, 1),
(967, 17, 16, 80, 1),
(968, 18, 16, 80, 1),
(969, 19, 16, 80, 1),
(970, 4, 272, 100, 1),
(971, 7, 272, 100, 1),
(972, 5, 272, 100, 1),
(973, 6, 272, 100, 1),
(974, 8, 272, 100, 1),
(975, 9, 272, 100, 1),
(976, 10, 272, 100, 1),
(977, 11, 272, 100, 1),
(978, 12, 272, 100, 1),
(979, 13, 272, 100, 1),
(980, 14, 272, 100, 1),
(981, 15, 272, 100, 1),
(982, 16, 272, 100, 1),
(983, 17, 272, 100, 1),
(984, 18, 272, 100, 1),
(985, 19, 272, 100, 1),
(986, 4, 163, 60, 1),
(987, 6, 163, 100, 1),
(988, 5, 163, 80, 1),
(989, 7, 163, 80, 1),
(990, 8, 163, 80, 1),
(991, 19, 163, 80, 1),
(992, 18, 163, 80, 1),
(993, 16, 163, 80, 1),
(994, 15, 163, 80, 1),
(995, 12, 163, 80, 1),
(996, 11, 163, 80, 1),
(997, 14, 163, 80, 1),
(998, 10, 163, 80, 1),
(999, 9, 163, 80, 1),
(1000, 17, 163, 80, 1),
(1001, 13, 163, 80, 1),
(1002, 4, 128, 100, 1),
(1003, 5, 128, 100, 1),
(1004, 6, 128, 100, 1),
(1005, 7, 128, 100, 1),
(1006, 8, 128, 100, 1),
(1007, 9, 128, 100, 1),
(1008, 10, 128, 100, 1),
(1009, 11, 128, 100, 1),
(1010, 12, 128, 100, 1),
(1011, 13, 128, 100, 1),
(1012, 14, 128, 100, 1),
(1013, 15, 128, 100, 1),
(1014, 16, 128, 100, 1),
(1015, 17, 128, 100, 1),
(1016, 18, 128, 100, 1),
(1017, 19, 128, 100, 1),
(1018, 4, 129, 80, 1),
(1019, 5, 129, 100, 1),
(1020, 6, 129, 100, 1),
(1021, 7, 129, 100, 1),
(1022, 8, 129, 100, 1),
(1023, 9, 129, 80, 1),
(1024, 10, 129, 100, 1),
(1025, 11, 129, 100, 1),
(1026, 12, 129, 100, 1),
(1027, 13, 129, 100, 1),
(1028, 14, 129, 100, 1),
(1029, 15, 129, 100, 1),
(1030, 16, 129, 100, 1),
(1031, 17, 129, 100, 1),
(1032, 18, 129, 100, 1),
(1033, 19, 129, 100, 1),
(1034, 4, 300, 20, 1),
(1035, 5, 300, 20, 1),
(1036, 18, 300, 100, 1),
(1037, 19, 300, 40, 1),
(1038, 17, 300, 20, 1),
(1039, 6, 300, 100, 1),
(1040, 7, 300, 80, 1),
(1041, 8, 300, 60, 1),
(1042, 10, 300, 80, 1),
(1043, 9, 300, 80, 1),
(1044, 11, 300, 100, 1),
(1045, 12, 300, 100, 1),
(1046, 13, 300, 100, 1),
(1047, 15, 300, 60, 1),
(1048, 14, 300, 100, 1),
(1049, 16, 300, 40, 1),
(1050, 4, 182, 20, 1),
(1051, 5, 182, 80, 1),
(1052, 6, 182, 100, 1),
(1053, 9, 182, 60, 1),
(1054, 11, 182, 100, 1),
(1055, 12, 182, 80, 1),
(1056, 13, 182, 80, 1),
(1057, 7, 182, 40, 1),
(1058, 8, 182, 80, 1),
(1059, 10, 182, 100, 1),
(1060, 14, 182, 100, 1),
(1061, 15, 182, 100, 1),
(1062, 16, 182, 80, 1),
(1063, 17, 182, 80, 1),
(1064, 18, 182, 100, 1),
(1065, 19, 182, 100, 1),
(1066, 5, 45, 60, 1),
(1067, 4, 45, 60, 1),
(1068, 7, 45, 60, 1),
(1069, 9, 45, 60, 1),
(1070, 11, 45, 60, 1),
(1071, 13, 45, 60, 1),
(1072, 15, 45, 60, 1),
(1073, 19, 45, 60, 1),
(1074, 17, 45, 60, 1),
(1075, 14, 45, 60, 1),
(1076, 18, 45, 60, 1),
(1077, 16, 45, 60, 1),
(1078, 12, 45, 60, 1),
(1079, 10, 45, 60, 1),
(1080, 8, 45, 60, 1),
(1081, 6, 45, 60, 1),
(1082, 10, 271, 80, 1),
(1083, 14, 271, 80, 1),
(1084, 15, 271, 80, 1),
(1085, 13, 271, 80, 1),
(1086, 16, 271, 80, 1),
(1087, 4, 245, 100, 1),
(1088, 5, 245, 100, 1),
(1089, 6, 245, 100, 1),
(1090, 7, 245, 100, 1),
(1091, 8, 245, 100, 1),
(1092, 19, 245, 100, 1),
(1093, 4, 155, 80, 1),
(1094, 6, 155, 100, 1),
(1095, 8, 155, 80, 1),
(1096, 5, 155, 100, 1),
(1097, 18, 155, 20, 1),
(1098, 7, 155, 80, 1),
(1099, 9, 155, 80, 1),
(1100, 10, 155, 80, 1),
(1101, 4, 171, 100, 1),
(1102, 11, 155, 100, 1),
(1103, 12, 155, 100, 1),
(1104, 13, 155, 100, 1),
(1105, 14, 155, 80, 1),
(1106, 15, 155, 80, 1),
(1107, 16, 155, 80, 1),
(1108, 5, 171, 80, 1),
(1109, 17, 155, 80, 1),
(1110, 6, 171, 100, 1),
(1111, 4, 174, 100, 1),
(1112, 4, 167, 100, 1),
(1113, 19, 155, 80, 1),
(1114, 7, 171, 100, 1),
(1115, 5, 174, 100, 1),
(1116, 6, 167, 100, 1),
(1117, 6, 174, 100, 1),
(1118, 7, 174, 100, 1),
(1119, 8, 171, 80, 1),
(1120, 8, 167, 100, 1),
(1121, 8, 174, 100, 1),
(1122, 9, 174, 100, 1),
(1123, 10, 174, 100, 1),
(1124, 9, 167, 100, 1),
(1125, 9, 171, 60, 1),
(1126, 11, 174, 100, 1),
(1127, 11, 167, 100, 1),
(1128, 10, 171, 100, 1),
(1129, 12, 174, 100, 1),
(1130, 11, 171, 100, 1),
(1131, 13, 167, 100, 1),
(1132, 12, 171, 100, 1),
(1133, 13, 174, 100, 1),
(1134, 15, 167, 100, 1),
(1135, 8, 23, 80, 1),
(1136, 14, 174, 100, 1),
(1137, 9, 23, 20, 1),
(1138, 10, 167, 100, 1),
(1139, 13, 171, 80, 1),
(1140, 15, 174, 100, 1),
(1141, 12, 23, 100, 1),
(1142, 16, 174, 100, 1),
(1143, 5, 167, 100, 1),
(1144, 13, 23, 80, 1),
(1145, 17, 174, 100, 1),
(1146, 14, 171, 60, 1),
(1147, 7, 167, 100, 1),
(1148, 14, 23, 100, 1),
(1149, 19, 174, 100, 1),
(1150, 17, 23, 20, 1),
(1151, 12, 167, 100, 1),
(1152, 15, 171, 80, 1),
(1153, 15, 23, 100, 1),
(1154, 18, 174, 100, 1),
(1155, 14, 167, 100, 1),
(1156, 16, 171, 100, 1),
(1157, 16, 23, 60, 1),
(1158, 16, 167, 100, 1),
(1159, 17, 171, 100, 1),
(1160, 17, 167, 100, 1),
(1161, 18, 171, 20, 1),
(1162, 19, 167, 100, 1),
(1163, 19, 171, 80, 1),
(1164, 18, 167, 100, 1),
(1165, 4, 51, 80, 1),
(1166, 4, 15, 100, 1),
(1167, 5, 51, 80, 1),
(1168, 6, 51, 100, 1),
(1169, 5, 15, 100, 1),
(1170, 6, 15, 100, 1),
(1171, 7, 15, 100, 1),
(1172, 8, 15, 100, 1),
(1173, 7, 51, 100, 1),
(1174, 9, 15, 100, 1),
(1175, 8, 51, 80, 1),
(1176, 19, 15, 100, 1),
(1177, 18, 15, 100, 1),
(1178, 9, 51, 80, 1),
(1179, 17, 15, 100, 1),
(1180, 16, 15, 100, 1),
(1181, 19, 51, 100, 1),
(1182, 15, 15, 100, 1),
(1183, 14, 15, 100, 1),
(1184, 18, 51, 80, 1),
(1185, 13, 15, 100, 1),
(1186, 12, 15, 100, 1),
(1187, 11, 15, 100, 1),
(1188, 10, 15, 100, 1),
(1189, 17, 51, 100, 1),
(1190, 15, 51, 80, 1),
(1191, 16, 51, 100, 1),
(1192, 13, 51, 100, 1),
(1193, 14, 51, 80, 1),
(1194, 10, 51, 100, 1),
(1195, 11, 51, 100, 1),
(1196, 12, 51, 100, 1),
(1197, 4, 59, 80, 1),
(1198, 5, 59, 80, 1),
(1199, 6, 59, 100, 1),
(1200, 7, 59, 100, 1),
(1201, 8, 59, 80, 1),
(1202, 9, 59, 80, 1),
(1203, 10, 59, 80, 1),
(1204, 4, 53, 40, 1),
(1205, 19, 59, 100, 1),
(1206, 18, 59, 80, 1),
(1207, 14, 59, 80, 1),
(1208, 6, 53, 60, 1),
(1209, 12, 59, 100, 1),
(1210, 5, 53, 40, 1),
(1211, 13, 59, 80, 1),
(1212, 11, 59, 80, 1),
(1213, 7, 53, 40, 1),
(1214, 17, 59, 80, 1),
(1215, 8, 53, 40, 1),
(1216, 16, 59, 100, 1),
(1217, 9, 53, 40, 1),
(1218, 15, 59, 80, 1),
(1219, 10, 53, 40, 1),
(1220, 11, 53, 40, 1),
(1221, 12, 53, 40, 1),
(1222, 13, 53, 40, 1),
(1223, 14, 53, 40, 1),
(1224, 15, 53, 40, 1),
(1225, 16, 53, 40, 1),
(1226, 17, 53, 40, 1),
(1227, 18, 53, 60, 1),
(1228, 19, 53, 40, 1),
(1229, 4, 20, 100, 1),
(1230, 5, 20, 100, 1),
(1231, 6, 20, 100, 1),
(1232, 7, 20, 100, 1),
(1233, 8, 20, 100, 1),
(1234, 9, 20, 100, 1),
(1235, 10, 20, 100, 1),
(1236, 11, 20, 100, 1),
(1237, 12, 20, 100, 1),
(1238, 13, 20, 100, 1),
(1239, 14, 20, 100, 1),
(1240, 15, 20, 100, 1),
(1241, 16, 20, 100, 1),
(1242, 17, 20, 100, 1),
(1243, 18, 20, 100, 1),
(1244, 19, 20, 100, 1),
(1245, 4, 24, 100, 1),
(1246, 5, 24, 100, 1),
(1247, 4, 11, 80, 1),
(1248, 6, 24, 60, 1),
(1249, 7, 24, 80, 1),
(1250, 5, 11, 80, 1),
(1251, 8, 24, 80, 1),
(1252, 9, 24, 40, 1),
(1253, 6, 11, 80, 1),
(1254, 10, 24, 80, 1),
(1255, 11, 24, 80, 1),
(1256, 7, 11, 80, 1),
(1257, 12, 24, 80, 1),
(1258, 8, 11, 80, 1),
(1259, 13, 24, 80, 1),
(1260, 14, 24, 60, 1),
(1261, 15, 24, 80, 1),
(1262, 16, 24, 80, 1),
(1263, 17, 24, 40, 1),
(1264, 9, 11, 100, 1),
(1265, 18, 24, 80, 1),
(1266, 19, 24, 80, 1),
(1267, 10, 11, 80, 1),
(1268, 12, 11, 40, 1),
(1269, 14, 11, 60, 1),
(1270, 11, 11, 80, 1),
(1271, 13, 11, 60, 1),
(1272, 15, 11, 80, 1),
(1273, 16, 11, 60, 1),
(1274, 17, 11, 80, 1),
(1275, 18, 11, 100, 1),
(1276, 19, 11, 60, 1),
(1277, 4, 50, 80, 1),
(1278, 5, 50, 100, 1),
(1279, 6, 50, 80, 1),
(1280, 7, 50, 60, 1),
(1281, 8, 50, 80, 1),
(1282, 9, 50, 80, 1),
(1283, 10, 50, 80, 1),
(1284, 11, 50, 80, 1),
(1285, 12, 50, 40, 1),
(1286, 13, 50, 40, 1),
(1287, 14, 50, 80, 1),
(1288, 15, 50, 80, 1),
(1289, 16, 50, 60, 1),
(1290, 17, 50, 80, 1),
(1291, 19, 50, 60, 1),
(1292, 18, 50, 100, 1),
(1293, 7, 181, 60, 1),
(1294, 19, 181, 80, 1),
(1295, 12, 181, 60, 1),
(1296, 15, 181, 60, 1),
(1297, 16, 181, 60, 1),
(1298, 13, 181, 60, 1),
(1299, 17, 181, 80, 1),
(1300, 18, 181, 80, 1),
(1301, 10, 181, 80, 1),
(1302, 8, 181, 80, 1),
(1303, 4, 181, 80, 1),
(1304, 5, 181, 80, 1),
(1305, 6, 181, 100, 1),
(1306, 9, 181, 60, 1),
(1307, 11, 181, 60, 1),
(1308, 14, 181, 60, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_materia`
--

CREATE TABLE `tb_materia` (
  `idmateria` int(11) NOT NULL,
  `materia` varchar(255) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_materia`
--

INSERT INTO `tb_materia` (`idmateria`, `materia`, `estado`) VALUES
(1, 'Farmacología', 1),
(2, 'Fisiopatologia', 1),
(3, 'Manejo del Trauma y SVA ', 1),
(4, 'Farmacología II ', 1),
(5, 'Anatomía y Fisiología ', 1),
(6, 'Farmacología I ', 1),
(7, 'Procedimiento de Cirugia Menor ', 1),
(8, 'Semiología ', 1),
(9, 'Metodología de la Investigación', 1),
(10, 'Inglés al servicio del secretariado', 1),
(11, 'Inglés al Servicio del Turismo', 1),
(12, 'Inglés Aplicado a la Tecnología de la Información', 1),
(13, 'Rescate ', 1),
(14, 'Manejo y Traslado de Pacientes ', 1),
(15, 'Atención Pre-Hospitalaria ', 1),
(16, 'Morfofisiologia', 1),
(17, 'Morfofisiología ', 1),
(18, 'Comunidad, desastre y salud', 1),
(19, 'Emergencias Cardiovasculares ', 1),
(20, 'Electrocardiografía Básica ', 1),
(21, 'Emergencias Clínicas ', 1),
(22, 'Manejo del Trauma y Soporte Vital Básico ', 1),
(23, 'Medicina Legal', 1),
(24, 'Bioética', 1),
(25, 'Enfermería Básica I', 1),
(26, 'Primeros Auxilios ', 1),
(27, 'Enfermería en Emergencias', 1),
(28, 'Enfermería Materno Infantil ', 1),
(29, 'Epidemiología Comunitaria ', 1),
(30, 'Administración de Medicamentos ', 1),
(31, 'Cuidados Paliativos ', 1),
(32, 'Enfermería Clínico Quirúrgica', 1),
(33, 'Bioquímica', 1),
(34, 'Medicina natural y tradicional', 1),
(35, 'Enfermería del Adulto Mayor', 1),
(36, 'Enfermería Básica II', 1),
(37, 'Bioseguridad ', 1),
(38, 'Rehabilitación Deportiva', 1),
(39, 'Ergonomia y salud laboral', 1),
(40, 'Introducción a la Rehabilitación Física', 1),
(41, 'Rehabilitación Musculo Esquelético', 1),
(42, 'Desarrollo Psicomotor y Estimulación Temprana', 1),
(43, 'Rehabilitacion fisica en el niño y adolescente', 1),
(44, 'Rehabilitación Física en Geriatría ', 1),
(45, 'Tecnologías en Ayudas Biomecánicas', 1),
(46, 'Kinesiología', 1),
(47, 'Semiología', 1),
(48, 'Rehabilitacion Cardiorespiratoria', 1),
(49, 'Terapia Física ', 1),
(50, 'Rehabilitacion Neurologica', 1),
(51, 'Rehabilitacion físca en alteraciones Neurosensoriales', 1),
(52, 'Rehabilitacion fisica en alteraciones Neurosensoriales', 1),
(53, 'Imagenología aplicada a la Fisioterapia', 1),
(54, 'Morfofisiología', 1),
(55, 'Anatomia y Fisiologia', 1),
(56, 'Cultura Física ', 1),
(57, 'Folklore', 1),
(58, 'Deporte y recreación', 1),
(59, 'Geografía Turística', 1),
(60, 'Sociología del Turismo', 1),
(61, 'Senderismo', 1),
(62, 'Legislación Turística y Ambiental', 1),
(63, 'Arqueología', 1),
(64, 'Marketing Turístico', 1),
(65, 'Técnicas de Guianza', 1),
(66, 'Proyectos de Salud', 1),
(67, 'Promoción de Salud', 1),
(68, 'Salud Pública ', 1),
(69, 'Etica Profesional', 1),
(70, 'Salud Pública', 1),
(71, 'Relaciones Humanas', 1),
(72, 'Comunicación Oral y Escrita', 1),
(73, 'Estilistica del Lenguaje', 1),
(74, 'Marketing', 1),
(75, 'Tributación', 1),
(76, 'Inventario Turístico', 1),
(77, 'RRPP y Organización de Eventos', 1),
(78, 'Matemática Básica', 1),
(79, 'Algebra Lineal', 1),
(80, 'Física para electrónica', 1),
(81, 'Lógica de programación', 1),
(82, 'Lógica matemática', 1),
(83, 'Programación Estructurada', 1),
(84, 'Programación Orientada a Objetos', 1),
(85, 'Redes de Datos', 1),
(86, 'Programación I', 1),
(87, 'Análisis de Base de Datos', 1),
(88, 'Administración de base de datos', 1),
(89, 'Informática ', 1),
(90, 'Circuitos electrónicos', 1),
(91, 'Electrónica', 1),
(92, 'Control de Sistemas Robóticos', 1),
(93, 'Informática Aplicada ', 1),
(94, 'Informática', 1),
(95, 'Matemática Financiera', 1),
(96, 'Sistemas Informáticos Empresariales', 1),
(97, 'Sistema de Archivo computarizado', 1),
(98, 'Mantenimiento de Hardware', 1),
(99, 'Electrotecnia', 1),
(100, 'Arquitectura del Computador', 1),
(101, 'Cultura e Identidad Ecuatoriana', 1),
(102, 'Sistemas Operativos', 1),
(103, 'Estadística', 1),
(104, 'Sistemas Operativos Distribuidos', 1),
(105, 'Sistemas de Información', 1),
(106, 'Desarrollo e Implementación de Software Movil', 1),
(107, 'Auditoría de Sistemas', 1),
(108, 'Proyectos Informáticos', 1),
(109, 'Planificación Turística', 1),
(110, 'Agencias de Viaje', 1),
(111, 'Digitación', 1),
(112, 'Técnicas de secretariado ', 1),
(113, 'Contabilidad Básica', 1),
(114, 'Taller de Oficina', 1),
(115, 'Administración de Empresas', 1),
(116, 'Gestión Gerencial', 1),
(117, 'Sistema de Archivos', 1),
(118, 'Comportamiento Secretarial', 1),
(119, 'Introducción al Turismo', 1),
(120, 'Gestión Hotelera', 1),
(121, 'Historia Universal', 1),
(122, 'Historia del Ecuador', 1),
(123, 'Gestión del Talento Humano', 1),
(124, 'Turismo Comunitario', 1),
(125, 'Flora y Fauna', 1),
(126, 'Control de Calidad de la Industria Farmaceutica', 1),
(127, 'Proyectos de Inversión', 1),
(128, 'Procedimiento Parlamentario', 1),
(129, 'Ecología y Medio Ambiente', 1),
(130, 'Realidad Socioeconómica', 1),
(131, 'Psicología General ', 1),
(132, 'Elementos aplicados a la psicología ', 1),
(133, 'Salud Mental y Discapacidad', 1),
(134, 'Programación Web', 1),
(135, 'Fundamentos de Programación', 1),
(136, 'Francés al Servicio del Turismo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_portafolio`
--

CREATE TABLE `tb_portafolio` (
  `idportafolio` int(11) NOT NULL,
  `iddocente` int(11) NOT NULL,
  `idcriterio` int(11) NOT NULL,
  `documento` varchar(25) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_portafolio`
--

INSERT INTO `tb_portafolio` (`idportafolio`, `iddocente`, `idcriterio`, `documento`, `estado`) VALUES
(2, 30, 1, '1678681910.pdf', 1),
(3, 30, 5, '1678682308.pdf', 1),
(4, 30, 3, '1678683357.pdf', 1),
(5, 16, 1, '1678741158.pdf', 1),
(6, 19, 1, '1678741185.pdf', 1),
(7, 16, 2, '1678741205.pdf', 1),
(8, 31, 3, '1678741206.pdf', 1),
(9, 31, 4, '1678741221.pdf', 1),
(10, 16, 3, '1678741247.pdf', 1),
(11, 31, 5, '1678741277.pdf', 1),
(12, 16, 5, '1678741370.pdf', 1),
(13, 16, 6, '1678741436.pdf', 1),
(14, 31, 6, '1678741442.pdf', 1),
(15, 31, 2, '1678741598.pdf', 1),
(16, 16, 7, '1678741775.pdf', 1),
(17, 16, 8, '1678741876.pdf', 1),
(18, 31, 1, '1678742331.pdf', 1),
(19, 31, 10, '1678742482.pdf', 1),
(20, 23, 1, '1678742503.pdf', 1),
(21, 23, 3, '1678742779.pdf', 1),
(22, 23, 4, '1678742803.pdf', 1),
(23, 31, 8, '1678743042.pdf', 1),
(25, 23, 9, '1678743257.pdf', 1),
(26, 23, 6, '1678744209.pdf', 1),
(27, 19, 2, '1678745680.pdf', 1),
(28, 19, 5, '1678745751.pdf', 1),
(29, 33, 1, '1678745768.pdf', 1),
(30, 33, 3, '1678745789.pdf', 1),
(31, 33, 5, '1678745820.pdf', 1),
(32, 19, 8, '1678745825.pdf', 1),
(33, 33, 6, '1678746004.pdf', 1),
(34, 33, 7, '1678746150.pdf', 1),
(35, 19, 3, '1678746552.pdf', 1),
(36, 31, 7, '1678746921.pdf', 1),
(37, 19, 7, '1678747064.pdf', 1),
(38, 19, 9, '1678747554.pdf', 1),
(39, 19, 6, '1678747661.pdf', 1),
(40, 33, 2, '1678748309.pdf', 1),
(41, 23, 5, '1678748321.pdf', 1),
(42, 33, 8, '1678748338.pdf', 1),
(43, 33, 11, '1678748439.pdf', 1),
(44, 28, 1, '1678767273.pdf', 1),
(45, 28, 2, '1678767300.pdf', 1),
(46, 28, 3, '1678767316.pdf', 1),
(47, 28, 5, '1678767352.pdf', 1),
(48, 28, 6, '1678767419.pdf', 1),
(49, 28, 7, '1678767448.pdf', 1),
(50, 28, 8, '1678767471.pdf', 1),
(51, 28, 9, '1678767509.pdf', 1),
(52, 28, 11, '1678767530.pdf', 1),
(53, 28, 12, '1678767560.pdf', 1),
(54, 36, 6, '1678806147.pdf', 1),
(55, 36, 7, '1678823226.pdf', 1),
(56, 18, 7, '1678823818.pdf', 1),
(57, 18, 1, '1678824168.pdf', 1),
(58, 18, 5, '1678824268.pdf', 1),
(59, 18, 3, '1678824497.pdf', 1),
(60, 18, 6, '1678825059.pdf', 1),
(61, 18, 10, '1678826127.pdf', 1),
(62, 23, 2, '1678828510.pdf', 1),
(64, 23, 10, '1678853481.pdf', 1),
(66, 17, 1, '1678894593.pdf', 1),
(67, 17, 2, '1678894698.pdf', 1),
(68, 17, 3, '1678894753.pdf', 1),
(69, 17, 5, '1678894790.pdf', 1),
(70, 17, 6, '1678894804.pdf', 1),
(71, 17, 7, '1678894845.pdf', 1),
(72, 17, 8, '1678894923.pdf', 1),
(73, 17, 9, '1678895004.pdf', 1),
(74, 17, 10, '1678895166.pdf', 1),
(75, 17, 11, '1678895672.pdf', 1),
(76, 17, 12, '1678895719.pdf', 1),
(77, 20, 1, '1678899719.pdf', 1),
(79, 20, 5, '1678900110.pdf', 1),
(80, 20, 3, '1678901596.PDF', 1),
(81, 20, 4, '1678901615.PDF', 1),
(82, 20, 8, '1678901962.pdf', 1),
(83, 20, 2, '1678905468.pdf', 1),
(84, 36, 2, '1678917863.pdf', 1),
(85, 36, 1, '1678918002.pdf', 1),
(86, 36, 3, '1678918300.pdf', 1),
(87, 36, 8, '1678919452.pdf', 1),
(90, 20, 7, '1678924615.pdf', 1),
(91, 20, 9, '1678924671.pdf', 1),
(92, 20, 10, '1678924694.pdf', 1),
(93, 20, 12, '1678924717.pdf', 1),
(94, 22, 1, '1678931208.pdf', 1),
(95, 22, 5, '1678931240.pdf', 1),
(96, 22, 6, '1678931274.pdf', 1),
(97, 23, 7, '1678939072.pdf', 1),
(98, 23, 11, '1678939127.pdf', 1),
(99, 7, 1, '1678979239.pdf', 1),
(100, 7, 3, '1678979262.pdf', 1),
(101, 7, 4, '1678979495.pdf', 1),
(102, 7, 6, '1678979565.pdf', 1),
(103, 7, 7, '1678979605.pdf', 1),
(104, 7, 5, '1678980249.pdf', 1),
(105, 7, 2, '1678980697.pdf', 1),
(106, 7, 10, '1678985386.pdf', 1),
(107, 22, 3, '1678995129.pdf', 1),
(108, 22, 7, '1678995153.pdf', 1),
(110, 22, 11, '1678995187.pdf', 1),
(111, 22, 12, '1678995204.pdf', 1),
(112, 14, 5, '1679007194.pdf', 1),
(113, 14, 3, '1679007237.pdf', 1),
(114, 14, 2, '1679007368.pdf', 1),
(115, 14, 4, '1679007627.pdf', 1),
(116, 14, 6, '1679008477.pdf', 1),
(117, 14, 1, '1679008691.pdf', 1),
(118, 14, 10, '1679009060.pdf', 1),
(119, 29, 1, '1679029906.pdf', 1),
(120, 29, 2, '1679029924.pdf', 1),
(121, 29, 3, '1679029941.pdf', 1),
(122, 29, 4, '1679029951.pdf', 1),
(123, 29, 5, '1679029972.pdf', 1),
(124, 29, 6, '1679029985.pdf', 1),
(125, 16, 12, '1679029993.pdf', 1),
(126, 29, 7, '1679030001.pdf', 1),
(127, 29, 8, '1679030027.pdf', 1),
(129, 16, 10, '1679030132.pdf', 1),
(130, 39, 1, '1679059944.pdf', 1),
(131, 39, 3, '1679060232.pdf', 1),
(132, 39, 4, '1679060284.pdf', 1),
(133, 39, 5, '1679060372.pdf', 1),
(134, 39, 6, '1679061358.pdf', 1),
(135, 39, 9, '1679061959.pdf', 1),
(136, 39, 2, '1679065859.pdf', 1),
(138, 39, 7, '1679066471.pdf', 1),
(139, 39, 8, '1679066533.pdf', 1),
(140, 33, 10, '1679081120.pdf', 1),
(141, 6, 5, '1679084727.pdf', 1),
(142, 6, 2, '1679085537.pdf', 1),
(143, 6, 1, '1679085796.pdf', 1),
(144, 14, 7, '1679094164.pdf', 1),
(145, 38, 1, '1679099960.pdf', 1),
(147, 38, 2, '1679110980.pdf', 1),
(148, 38, 3, '1679111057.pdf', 1),
(149, 38, 4, '1679111074.pdf', 1),
(150, 38, 5, '1679111116.pdf', 1),
(151, 20, 11, '1679240243.pdf', 1),
(152, 36, 5, '1679341254.pdf', 1),
(153, 36, 10, '1679341563.pdf', 1),
(154, 36, 9, '1679341645.pdf', 1),
(155, 34, 1, '1679342450.pdf', 1),
(156, 34, 3, '1679342686.pdf', 1),
(157, 34, 4, '1679342698.pdf', 1),
(158, 19, 11, '1679345690.pdf', 1),
(159, 34, 5, '1679346015.pdf', 1),
(160, 34, 6, '1679348125.pdf', 1),
(161, 19, 10, '1679349583.pdf', 1),
(162, 34, 9, '1679349630.pdf', 1),
(163, 14, 12, '1679350345.pdf', 1),
(164, 27, 1, '1679350801.pdf', 1),
(165, 27, 2, '1679351562.pdf', 1),
(166, 27, 3, '1679351608.pdf', 1),
(167, 27, 4, '1679351649.pdf', 1),
(168, 27, 9, '1679351820.pdf', 1),
(169, 27, 6, '1679352862.pdf', 1),
(170, 29, 10, '1679352957.pdf', 1),
(171, 27, 8, '1679353427.pdf', 1),
(172, 34, 7, '1679353784.pdf', 1),
(173, 27, 7, '1679353921.pdf', 1),
(174, 16, 11, '1679353939.pdf', 1),
(175, 34, 11, '1679354023.pdf', 1),
(176, 34, 12, '1679354163.pdf', 1),
(177, 21, 1, '1679354287.pdf', 1),
(178, 27, 5, '1679354337.pdf', 1),
(179, 21, 2, '1679354423.pdf', 1),
(180, 21, 3, '1679354477.pdf', 1),
(181, 21, 5, '1679354558.pdf', 1),
(182, 21, 6, '1679354594.pdf', 1),
(183, 34, 8, '1679354651.pdf', 1),
(184, 34, 10, '1679354724.pdf', 1),
(185, 34, 2, '1679355205.pdf', 1),
(186, 26, 2, '1679360598.pdf', 1),
(187, 26, 2, '1679360598.pdf', 1),
(188, 21, 7, '1679360776.pdf', 1),
(189, 26, 5, '1679360910.pdf', 1),
(190, 21, 8, '1679360951.pdf', 1),
(191, 26, 1, '1679360986.pdf', 1),
(192, 26, 8, '1679361228.pdf', 1),
(193, 21, 12, '1679361482.pdf', 1),
(194, 1, 1, '1679361984.pdf', 1),
(195, 21, 11, '1679364046.pdf', 1),
(196, 36, 11, '1679364343.pdf', 1),
(199, 1, 9, '', 1),
(200, 30, 6, '1679376048.pdf', 1),
(201, 30, 2, '1679378049.pdf', 1),
(202, 30, 2, '1679378049.pdf', 1),
(203, 36, 9, '', 1),
(204, 15, 1, '1679429066.pdf', 1),
(205, 15, 2, '1679429289.pdf', 1),
(206, 28, 9, '', 1),
(207, 15, 3, '1679429552.pdf', 1),
(208, 15, 4, '1679429705.pdf', 1),
(209, 15, 5, '1679430185.pdf', 1),
(210, 17, 9, '', 1),
(211, 16, 9, '', 1),
(212, 33, 9, '', 1),
(213, 26, 3, '1679431841.pdf', 1),
(214, 26, 4, '1679431903.pdf', 1),
(215, 19, 12, '1679433401.pdf', 1),
(216, 26, 9, '', 1),
(217, 26, 6, '1679434344.pdf', 1),
(218, 26, 6, '1679434347.pdf', 1),
(219, 26, 7, '1679434475.pdf', 1),
(220, 27, 10, '1679435039.pdf', 1),
(221, 22, 9, '', 1),
(222, 22, 2, '1679438554.pdf', 1),
(223, 22, 8, '1679438585.pdf', 1),
(224, 22, 10, '1679438615.pdf', 1),
(225, 15, 6, '1679440399.pdf', 1),
(226, 33, 12, '1679440415.pdf', 1),
(227, 15, 7, '1679442040.pdf', 1),
(228, 31, 9, '', 1),
(229, 14, 9, '', 1),
(230, 15, 8, '1679444401.pdf', 1),
(231, 15, 10, '1679444438.pdf', 1),
(232, 21, 9, '', 1),
(233, 21, 10, '1679446854.pdf', 1),
(234, 30, 9, '', 1),
(235, 30, 12, '1679452921.pdf', 1),
(236, 27, 9, '', 1),
(237, 14, 8, '1679515848.pdf', 1),
(238, 23, 8, '1679520473.pdf', 1),
(239, 37, 2, '1679525386.pdf', 1),
(240, 30, 4, '1679531029.pdf', 1),
(241, 30, 7, '1679531125.pdf', 1),
(242, 30, 8, '1679531147.pdf', 1),
(243, 30, 10, '1679531183.pdf', 1),
(244, 20, 9, '', 1),
(245, 20, 9, '', 1),
(246, 20, 9, '', 1),
(247, 20, 9, '', 1),
(248, 20, 9, '', 1),
(249, 30, 11, '1679634229.pdf', 1),
(250, 39, 11, '1679641933.pdf', 1),
(251, 7, 9, '', 1),
(252, 7, 12, '1680018943.pdf', 1),
(253, 7, 11, '1680019773.pdf', 1),
(254, 7, 8, '1680215770.pdf', 1),
(255, 15, 9, '', 1),
(257, 24, 6, '1683642275.pdf', 1),
(258, 24, 2, '1683642620.pdf', 1),
(260, 24, 3, '1683642783.pdf', 1),
(261, 24, 4, '1683642861.pdf', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_preguntas`
--

CREATE TABLE `tb_preguntas` (
  `idpregunta` int(11) NOT NULL,
  `idarea` int(11) NOT NULL,
  `titulo` text NOT NULL,
  `p1` text NOT NULL,
  `p2` text NOT NULL,
  `p3` text NOT NULL,
  `p4` text NOT NULL,
  `p5` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_preguntas`
--

INSERT INTO `tb_preguntas` (`idpregunta`, `idarea`, `titulo`, `p1`, `p2`, `p3`, `p4`, `p5`) VALUES
(1, 1, 'Participación en los proyectos de vinculación con la sociedad', 'Se evidencia implicación positiva y proactiva en la planificación de proyectos, ejecución y evaluación, aporta con ideas transformadoras, contribuye al desarrollo institucional y comunitario', 'Se evidencia implicación  en la planificación de proyectos, ejecución y evaluación; aporta con ideas al desarrollo institucional y comunitario', 'Participa en los proyectos de vinculación con la sociedad.            cuando se le solicita, cumpliendo con lo que se le sugiere desde la dirección del departamento de vinculación con la sociedad', 'Participa en los proyectos de vinculación con la sociedad.           cuando se le solicita, cumpliendo de manera parcial con lo que se le sugiere desde la dirección del departamento de vinculación con la sociedad', 'No participa'),
(2, 1, 'Puntualidad en documentación', 'Entrega oportunamente y continuamente la documentación y trabajo requerido, en formatos establecido y sin errores', 'Entregaoportunamente  la documentación y trabajo requerido, en formatos establecido y con márgenes mínimos de errores', 'Entrega ocasionalmente  la documentación y trabajo requerido, en formatos establecido y con márgenes de errores', 'Incumple frecuentemente en  la documentación y trabajo requerido, en formatos establecidos', 'No cumple'),
(3, 1, 'Cumplimiento con el horario asignado', 'Cumple con el horario asignado y aprovecha al máximo las horas de vinculacion asignadas realizando actividades pertinentes a la funcion suastantiva', 'Cumple con el horario asignado y aprovecha las horas de vinculacion asignadas realizando actividades pertinentes a la funcion suastantiva', 'Cumple con parte del horario asignado y aprovecha las horas de vinculacion asigandas realizando actividades pertinentes a la funcion suastantiva', 'Cumple con parte del horario asignado y no se evidencia aprovechamiento de las horas de vinculacion asigandas realizando actividades pertinentes a la funcion suastantiva', 'No cumple el horario asignado y no se evidencia aprovechamiento de las horas de vinculacion asigandas realizando'),
(4, 1, 'Inteligencia emocional', 'Sabe  expresar de manera equilibrada sus propias emociones, entender las emociones de de los demás, acatar sugerencias y rectificar errores  en pro de su mejora continua profesional e institucional', 'Expresa sus propias emociones, entendiende las emociones de de los demás, acatar sugerencias y rectificar errores  en pro de su mejora continua profesional e institucional', 'Expresa sus propias emociones, entendiende las emociones de de los demás, ocasionalmente presenta dificultades para acatar sugerencias y rectificar errores  en pro de su mejora continua profesional e institucional', 'Expresa sus emociones de forma incorrecta, tiene inconvenientes para entender las emociones de los de los demás,  presenta dificultades para acatar sugerencias', 'No cuenta con inteligencia emocional'),
(5, 1, 'Valores institucionales', 'Se evidencía con nitidez de 9 a 10 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'Se evidencía con nitidez de 7 a 8 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'Se evidencía con nitidez de 5 a 7 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'Se evidencía con nitidez de al menos 5 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'No se evidencian valores institucionales'),
(6, 2, 'Participación en los proyectos de investigación', 'Se evidencia implicación positiva y proactiva en la planificación de proyectos, ejecución y evaluación, aporta con ideas transformadoras, contribuye al desarrollo institucional y comunitario', 'Se evidencia implicación  en la planificación de proyectos, ejecución y evaluación; aporta con ideas al desarrollo institucional y comunitario', 'Participa en los proyectos de investigación cuando se le solicita, cumpliendo con lo que se le sugiere desde la dirección del departamento de investigación', 'Participa en los proyectos de investigación cuando se le solicita, cumpliendo de manera parcial con lo que se le sugiere desde la dirección del departamento de investigación', 'No participa'),
(7, 2, 'Puntualidad en documentación', 'Entrega oportunamente y continuamente la documentación y trabajo requerido, en formatos establecido y sin errores', ' Entregaoportunamente  la documentación y trabajo requerido, en formatos establecido y con márgenes mínimos de errores', ' Entrega ocasionalmente  la documentación y trabajo requerido, en formatos establecido y con márgenes de errores', ' Incumple frecuentemente en  la documentación y trabajo requerido, en formatos establecidos', 'No cumple (0 punto)'),
(8, 2, 'Cumplimiento con las horas dedicadas a la investigación', 'Cumple a cabalidad con las horas de investigación, realizando con proactividad, entusiasmo y responsabilidad las actividades pertinentes a la funcion suastantiva', 'Cumple con el horario asignado y aprovecha las horas de vinculacion asignadas realizando actividades pertinentes a la funcion suastantiva', 'Cumple con parte del horario asignado y aprovecha las horas de vinculacion asigandas realizando actividades pertinentes a la funcion suastantiva', 'Cumple con parte del horario asignado y no se evidencia aprovechamiento de las horas de vinculacion asigandas realizando actividades pertinentes a la funcion suastantiva', 'No cumple el horario asignado y no se evidencia aprovechamiento de las horas de vinculacion asigandas realizando'),
(9, 2, 'Inteligencia emocional', 'Sabe expresar de manera equilibrada sus propias emociones, entender las emociones de de los demás, acatar sugerencias y rectificar errores  en pro de su mejora continua profesional e institucional', 'Expresa sus propias emociones, entendiende las emociones de de los demás, acatar sugerencias y rectificar errores  en pro de su mejora continua profesional e institucional', 'Expresa sus propias emociones, entendiende las emociones de de los demás, ocasionalmente presenta dificultades para acatar sugerencias y rectificar errores  en pro de su mejora continua profesional e institucional', 'Expresa sus emociones de forma incorrecta, tiene inconvenientes para entender las emociones de los de los demás,  presenta dificultades para acatar sugerencias', 'No cuenta con inteligencia emocional'),
(10, 2, 'Valores institucionales', 'Se evidencía con nitidez de 9 a 10 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'Se evidencía con nitidez de 7 a 8 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'Se evidencía con nitidez de 5 a 7 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'Se evidencía con nitidez de al menos 5 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'No se evidencian valores institucionales'),
(11, 3, 'Plan Operativo Anual ', 'Cumple con calidad con el 100% de las actividades declaradas en el POA', 'Cumple con calidad con el 95% de las actividades declaradas en el POA', 'Cumple con calidad con el 90% de las actividades declaradas en el POA', 'Cumple con menos del  90% de las actividades declaradas en el POA', 'No cumple'),
(12, 3, 'Cumplimiento de la gestión ', 'Conoce y cumple a cabalidad con las funciones inherentes a la gestión que le corresponde', 'Cumple a cabalidad con las funciones inherentes a la gestión que le corresponde', 'Conoce las funciones inherentes a la gestión que le corresponde', 'Conoce y cumple algunas de las funciones inherentes a la gestión que le corresponde', 'No conoce ni cumple con las funciones (0 punto)'),
(13, 3, 'Proactividad y predisposición en las tareas', 'Se evidencia proactivo y predispuesto en las tareas, con entusiasmo, regulación de la personalidad, comunicación asertiva', 'Se evidencia predispuesto en las tareas,  regulación de la personalidad, comunicación asertiva', 'Se evidencia predispuesto en las tareas,  regulación de la personalidad, la comunicación requiere se desarrollada', 'Se limita a cumplir con  las tareas,  regulación de la personalidad, la comunicación requiere se desarrollada', 'No se evidencia proactividad y predisposición en las tareas'),
(14, 3, 'Puntualidad en documentación', 'Entrega oportunamente y continuamente la documentación y trabajo requerido, en formatos establecido y sin errores', 'Entregaoportunamente  la documentación y trabajo requerido, en formatos establecido y con márgenes mínimos de errores', 'Entrega ocasionalmente  la documentación y trabajo requerido, en formatos establecido y con márgenes de errores', 'Incumple frecuentemente en  la documentación y trabajo requerido, en formatos establecidos', 'No cumple'),
(15, 3, 'Valores institucionales', 'Se evidencía con nitidez de 9 a 10 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'Se evidencía con nitidez de 7 a 8 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'Se evidencía con nitidez de 5 a 7 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'Se evidencía con nitidez de al menos 5 valores: Vocación, respeto, responsabilidad, solidaridad, altruismo, generosidad, empatía, excelencia, justicia, equidad, transpariencia', 'No se evidencian valores institucionales'),
(16, 4, 'Entrega de sílabos, evaluaciones, notas y prácticas (según la asignatura)', 'Efectúa la entrega de sílabos, evaluaciones, notas y prácticas; con el tiempo establecido, de forma organizada y sin errores', 'Efectúa la entrega de sílabos, evaluaciones, notas y prácticas; con el tiempo establecido, de forma organizada y hasta dos errores', 'Efectúa la entrega de sílabos, evaluaciones, notas y prácticas; con el tiempo establecido, con dificultades de organización organizada y hasta tres errores', 'Efectúa la entrega de sílabos, evaluaciones y prácticas; extemporánea, con dificultades de organización organizada y hasta tres errores. (5 puntos)', 'No entrega'),
(17, 4, 'Aprendizaje', 'Aporta a su aprendizaje como profesional en formación, donde demuestra dominio del contenido y propicia la aplicación teórico - práctica', 'Aporta a su aprendizaje como profesional en formación, donde demuestra dominio del contenido con énfasis en la teoría', 'Aporta a su aprendizaje como profesional en formación, donde demuestra dominio del contenido a', 'Aporta a su aprendizaje como profesional en formación solo en teoría', 'Aporta parcialmente al aprendizaje como profesional en formación solo en teoría'),
(18, 4, 'Cumplimiento de la planificación declarada en los sílabos', 'Cumplimiento de la planificación declarada en los sílabos evidenciada en: plataforma moodle actualizada a tiempo, desarrollo de todos los temas', 'Cumplimiento de la planificación declarada en los sílabos evidenciada en: plataforma moodle actualizada fuera de tiempo, desarrollo de todos los temas, en caso de novedades replanifica el o los temas, califica fuera de tiempo, recibe un llamado de atención', 'Cumplimiento parcialmente con la planificación declarada en los sílabos evidenciada en: plataforma moodle actualizada fuera de tiempo, desarrollo de todos los temas, en caso de novedades replanifica el o los temas, califica fuera de tiempo, recibe dos llamados de atención', 'Cumplimiento parcialmente con la planificación declarada en los sílabos evidenciada en: plataforma moodle actualizada fuera de tiempo, desarrollo de todos los temas, en caso de novedades replanifica el o los temas, califica fuera de tiempo, recibe tres llamados de atención', 'No cumple'),
(19, 4, 'Cumplimiento con el horario de clases asignados, así como con el tiempo en cada hora de clase', 'Aprovecha al máximo las horas de clases', 'Aprovecha las horas de clases, pero se le ha llamado la atención al menos una ocasión por:  clase concluida antes de tiempo, horas de atraso al comenzar o cambios de hora sin autorización', 'Se evidencia falencias en el aprovechamiento de las horas de clases, donde se le ha llamado la atención hasta dos ocasiones por:  clase concluida antes de tiempo, horas de atraso al comenzar o cambios de hora sin autorización', 'Se evidencia falencias en el aprovechamiento de las horas de clases, donde se le ha llamado la atención por tres ocasiones por:  clase concluida antes de tiempo, horas de atraso al comenzar o cambios de hora sin autorización', 'No aprovecha el tiempo en el desarrollo de las clases e incurre en faltas como:  clase concluida antes de tiempo, horas de atraso al comenzar y cambios de hora sin autorización'),
(20, 4, 'Eficiencia como tutor de acompañamiento de estudiantes asignados', 'Logra una gestión del 85% de asistencia a clases, el 90% de promoción al periodo académico superior, 85% de retención', 'Logra una gestión del 81 al 84% de asistencia a clases, del 86 - 89% de promoción al periodo académico superior, 81 - 84% de retención', 'Logra una gestión del 80 % de asistencia a clases, hasta el 85% de promoción al periodo académico superior, 80% de retención', 'Logra hasta entre 75 - 79 % de asistencia a clases, del 80 - 84% de promoción al periodo académico superior, 75-79% de retención', 'La gestión se limita al 75 % o menos en la asistencia a clases, del 79 % o menos en la promoción al periodo académico superior, del 75% o menos de retención'),
(21, 5, 'Evidencia los sílabos al inicio del módulo', 'Si se  evidencian los sílabos al inicio del módulo y estos incluyen recursos que coninciden con los que están en las unidades', 'Se evidencian los sílabos al inicio del módulo incluyendo parcialmente con los recursos que están en las unidades', 'Se  evidencian los sílabos al inicio', 'No se  evidencian los sílabos al inicio', ''),
(22, 5, 'Evidencia contenidos y recursos en las 4 unidades', 'Se evidencian los  contenidos y recursos acordes a los declarados en los sílabos en las 4 unidades', 'Se evidencian los  contenidos y recursos en 3 de las 4 unidades', 'Se evidencian los  contenidos y recursos en al menos  2 de las 4 unidades', 'No se evidencian los  contenidos y recursos en las unidades', ''),
(23, 5, 'Se evidencia contenido con base en los sílabos y recursos didácticos correspondientes a las etapas del ciclo del aprendizaje (Experiencia, Reflexión y aplicación) en cada unidad', 'El 100% del contenido está basado en los sílabos y recursos didácticos correspondientes a las etapas del ciclo del aprendizaje (Experiencia, Reflexión y aplicación) en cada unidad', 'Al menos el 75% del contenido está basado en los sílabos y recursos didácticos correspondientes a las etapas del ciclo del aprendizaje (Experiencia, Reflexión y aplicación) en cada unidad', 'Al menos el 50% del contenido está basado en los sílabos y recursos didácticos correspondientes a las etapas del ciclo del aprendizaje (Experiencia, Reflexión y aplicación) en cada unidad', 'Menos del 50% del contenido está basado en los sílabos y recursos didácticos y no se evidencian claramente las etapas del ciclo del aprendizaje (Experiencia, Reflexión y aplicación) en cada unidad', ''),
(24, 5, 'Se evidencia la aplicación de tareas, evaluaciones y otras actividades, realizadas y calificadas a través de la plataforma', 'Existe evidencia sobre la aplicación de tareas, evaluaciones y otras actividades, realizadas y calificadas a través de la plataforma', 'Existe evidencia sobre la aplicación de tareas, evaluaciones y otras actividades, realizadas pero no todas están calificadas, a través de la plataforma', 'Existe poca evidencia sobre la aplicación de tareas, evaluaciones y otras actividades, realizadas y no todas están calificadas, a través de la plataforma', 'No existe  evidencia sobre la aplicación de tareas, evaluaciones y otras actividades, realizadas  a través de la plataforma', ''),
(25, 5, 'Estética y orden del EVA', 'El entorno virtual de aprendizaje se torna 100% claro, ordenado, entendible y estéticamente bien estructurado', 'El entorno virtual de aprendizaje se torna al menos en un 75% claro, ordenado, entendible y estéticamente bien estructurado', 'El entorno virtual de aprendizaje se torna al menos en un 50% claro, ordenado, entendible y estéticamente bien estructurado', 'El entorno virtual de aprendizaje se torna desordenado, con recursos de escaza calidad y poco estructurado', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_preguntas_administrativo`
--

CREATE TABLE `tb_preguntas_administrativo` (
  `idpregunta` int(11) NOT NULL,
  `idarea` int(11) NOT NULL,
  `tipo` varchar(1) NOT NULL,
  `titulo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_preguntas_administrativo`
--

INSERT INTO `tb_preguntas_administrativo` (`idpregunta`, `idarea`, `tipo`, `titulo`) VALUES
(1, 6, 'A', '¿Cómo califica su desempeño laboral?'),
(2, 6, 'A', '¿Cuál es su grado de responsabilidad?'),
(3, 6, 'A', 'Entrega oportunamente la documentación o trabajos requeridos, en formatos establecido y con márgenes mínimos de errores'),
(4, 6, 'A', 'En qué grado usted acata con responsabilidad y predisposición las tareas asignadas, es receptivo ante las sugerencias y demuestra compromiso laboral'),
(5, 6, 'A', 'En qué grado es usted un líder activo y emprendedor que actúa con prontitud, diligencia y energía'),
(6, 6, 'A', 'En qué grado sabe usted impulsar el desarrollo de las habilidades personales y de las potenciales habilidades de las personas que lo rodean'),
(7, 6, 'A', '¿Cómo califica su forma de comunicarse con los integrantes de su equipo?'),
(8, 6, 'A', '¿Cuál es su nivel de implicación y compromiso con la institución?'),
(9, 6, 'A', '¿Cómo califica su comportamiento y manejo de emociones dentro de la institución?'),
(10, 6, 'A', 'Usted cumple las políticas y normas de responsabilidad social de esta institución'),
(11, 6, 'C', 'Adaptación al cambio: Responde oportunamente con nuevas estrategias de solución frente a amenazas y oportunidades del entorno, reflejando capacidad de liderazgo y fomentando fortaleza en los procesos y equipos de trabajo a su cargo'),
(12, 6, 'C', 'Trabajo: demuestra eficacia y eficiencia en la producción y manejo de la documentación o trabajo que está bajo su responsabilidad'),
(13, 6, 'C', 'Puntualidad: entrega oportunamente la documentación y trabajo requerido, en formatos establecido y con márgenes mínimos de errores'),
(14, 6, 'C', 'Predisposición: acata con responsabilidad y predisposición las tareas asignadas, es receptivo ante las sugerencias y demuestra compromiso laboral'),
(15, 6, 'C', 'Dinamismo: Es un líder activo y emprendedor que actúa con prontitud, diligencia y energía'),
(16, 6, 'C', 'Sabe impulsar el desarrollo de las habilidades personales y de las potenciales habilidades de las personas a su cargo'),
(17, 6, 'C', 'Comunicación con el equipo: Domina la forma en como comunicarse con los integrantes de su equipo de manera verbal y no verba'),
(18, 6, 'C', 'Compromiso: Sabe implicarse al máximo en una labor, poniendo todas sus capacidades para conseguir llevarla a cabo'),
(19, 6, 'C', 'Inteligencia emocional: Sabe apreciar y expresar de manera equilibrada sus propias emociones, entender las de los demás, y utiliza esta información para guiar su forma de pensar y su comportamiento'),
(20, 6, 'C', 'Responsabilidad: Emite y cumple políticas y normas de responsabilidad social e institucional'),
(21, 6, 'H', 'Adaptación al cambio: Responde oportunamente con nuevas estrategias de solución frente a amenazas y oportunidades del entorno, reflejando capacidad de liderazgo y fomentando fortaleza en los procesos y equipos de trabajo a su cargo'),
(22, 6, 'H', 'Trabajo: demuestra eficacia y eficiencia en la producción y manejo de la documentación o trabajo que está bajo su responsabilidad'),
(23, 6, 'H', 'Puntualidad: entrega oportunamente la documentación y trabajo requerido, en formatos establecido y con márgenes mínimos de errores'),
(24, 6, 'H', 'Predisposición: acata con responsabilidad y predisposición las tareas asignadas, es receptivo ante las sugerencias y demuestra compromiso laboral'),
(25, 6, 'H', 'Dinamismo: Es un líder activo y emprendedor que actúa con prontitud, diligencia y energía'),
(26, 6, 'H', 'Sabe impulsar el desarrollo de las habilidades personales y de las potenciales habilidades de las personas a su cargo'),
(27, 6, 'H', 'Comunicación con el equipo: Domina la forma en como comunicarse con los integrantes de su equipo de manera verbal y no verbal'),
(28, 6, 'H', 'Compromiso: Sabe implicarse al máximo en una labor, poniendo todas sus capacidades para conseguir llevarla a cabo'),
(29, 6, 'H', 'Inteligencia emocional: Sabe apreciar y expresar de manera equilibrada sus propias emociones, entender las de los demás, y utiliza esta información para guiar su forma de pensar y su comportamiento'),
(30, 6, 'H', 'Responsabilidad: Emite y cumple políticas y normas de responsabilidad social e instituciona');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_satisfaccion`
--

CREATE TABLE `tb_satisfaccion` (
  `idsatisfaccion` int(11) NOT NULL,
  `idestudiante` int(11) NOT NULL,
  `parametro` varchar(2) NOT NULL,
  `calificacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_satisfaccion`
--

INSERT INTO `tb_satisfaccion` (`idsatisfaccion`, `idestudiante`, `parametro`, `calificacion`) VALUES
(10, 205, 'p1', 100),
(11, 205, 'p2', 80),
(12, 205, 'p3', 80),
(13, 205, 'p4', 80),
(14, 205, 'p5', 80),
(15, 205, 'p6', 80),
(16, 205, 'p7', 100),
(17, 205, 'p8', 100),
(18, 205, 'p9', 100),
(19, 125, 'p1', 60),
(20, 125, 'p2', 40),
(21, 125, 'p3', 80),
(22, 125, 'p4', 80),
(23, 125, 'p5', 80),
(24, 125, 'p6', 80),
(25, 125, 'p7', 80),
(26, 125, 'p8', 80),
(27, 125, 'p9', 80),
(28, 127, 'p1', 100),
(29, 127, 'p2', 100),
(30, 127, 'p3', 100),
(31, 127, 'p4', 100),
(32, 127, 'p5', 100),
(33, 127, 'p6', 100),
(34, 127, 'p7', 100),
(35, 127, 'p8', 100),
(36, 127, 'p9', 100),
(37, 151, 'p1', 80),
(38, 151, 'p2', 80),
(39, 148, 'p1', 80),
(40, 148, 'p2', 80),
(41, 151, 'p4', 100),
(42, 148, 'p3', 100),
(43, 148, 'p4', 80),
(44, 151, 'p5', 100),
(45, 148, 'p5', 100),
(46, 148, 'p6', 60),
(47, 151, 'p7', 60),
(48, 148, 'p7', 100),
(49, 148, 'p8', 60),
(50, 151, 'p9', 80),
(51, 148, 'p9', 80),
(52, 140, 'p3', 100),
(53, 151, 'p6', 100),
(54, 140, 'p7', 100),
(55, 140, 'p1', 80),
(56, 151, 'p3', 100),
(57, 140, 'p2', 80),
(58, 140, 'p4', 80),
(59, 140, 'p5', 80),
(60, 140, 'p6', 80),
(61, 151, 'p8', 80),
(62, 140, 'p8', 100),
(63, 140, 'p9', 80),
(64, 123, 'p1', 80),
(65, 123, 'p2', 80),
(66, 123, 'p3', 80),
(67, 123, 'p4', 60),
(68, 123, 'p5', 80),
(69, 123, 'p6', 80),
(70, 123, 'p7', 80),
(71, 123, 'p8', 80),
(72, 123, 'p9', 60),
(73, 299, 'p6', 80),
(74, 299, 'p1', 80),
(75, 299, 'p2', 80),
(76, 299, 'p3', 100),
(77, 299, 'p4', 100),
(78, 299, 'p5', 100),
(79, 299, 'p7', 100),
(80, 299, 'p8', 100),
(81, 299, 'p9', 100),
(82, 144, 'p1', 100),
(83, 144, 'p3', 40),
(84, 144, 'p5', 100),
(85, 144, 'p2', 40),
(86, 33, 'p2', 20),
(87, 33, 'p1', 60),
(88, 33, 'p3', 40),
(89, 33, 'p4', 40),
(90, 177, 'p1', 80),
(91, 177, 'p2', 80),
(92, 177, 'p7', 80),
(93, 177, 'p9', 80),
(94, 177, 'p8', 80),
(95, 177, 'p4', 80),
(96, 177, 'p5', 80),
(97, 177, 'p3', 80),
(98, 177, 'p6', 80),
(99, 301, 'p1', 80),
(100, 301, 'p2', 80),
(101, 301, 'p3', 80),
(102, 301, 'p4', 80),
(103, 301, 'p5', 80),
(104, 301, 'p6', 80),
(105, 301, 'p7', 80),
(106, 301, 'p8', 80),
(107, 144, 'p6', 80),
(108, 301, 'p9', 80),
(109, 144, 'p4', 60),
(110, 144, 'p7', 100),
(111, 144, 'p8', 20),
(112, 144, 'p9', 80),
(113, 303, 'p1', 100),
(114, 303, 'p2', 100),
(115, 303, 'p3', 100),
(116, 303, 'p4', 100),
(117, 303, 'p5', 100),
(118, 303, 'p6', 100),
(119, 303, 'p7', 100),
(120, 303, 'p8', 100),
(121, 303, 'p9', 100),
(122, 265, 'p1', 40),
(123, 265, 'p2', 20),
(124, 265, 'p3', 40),
(125, 265, 'p4', 40),
(126, 265, 'p7', 60),
(127, 265, 'p8', 40),
(128, 265, 'p9', 40),
(129, 265, 'p6', 20),
(130, 265, 'p5', 60),
(131, 180, 'p1', 100),
(132, 180, 'p2', 100),
(133, 180, 'p3', 100),
(134, 180, 'p4', 100),
(135, 180, 'p5', 100),
(136, 180, 'p6', 100),
(137, 180, 'p7', 100),
(138, 180, 'p8', 100),
(139, 180, 'p9', 100),
(140, 296, 'p1', 80),
(141, 296, 'p2', 60),
(142, 296, 'p3', 60),
(143, 296, 'p4', 60),
(144, 296, 'p5', 100),
(145, 296, 'p6', 80),
(146, 296, 'p7', 100),
(147, 296, 'p8', 80),
(148, 296, 'p9', 80),
(149, 260, 'p1', 40),
(150, 260, 'p2', 40),
(151, 260, 'p3', 40),
(152, 260, 'p4', 60),
(153, 260, 'p5', 60),
(154, 260, 'p6', 60),
(155, 260, 'p7', 60),
(156, 260, 'p8', 40),
(157, 260, 'p9', 60),
(158, 179, 'p1', 80),
(159, 179, 'p2', 60),
(160, 179, 'p3', 100),
(161, 179, 'p4', 80),
(162, 179, 'p5', 100),
(163, 179, 'p6', 60),
(164, 179, 'p7', 60),
(165, 179, 'p8', 80),
(166, 191, 'p1', 20),
(167, 191, 'p2', 20),
(168, 191, 'p3', 20),
(169, 191, 'p4', 20),
(170, 191, 'p5', 20),
(171, 191, 'p6', 40),
(172, 191, 'p7', 20),
(173, 191, 'p8', 100),
(174, 191, 'p9', 100),
(175, 295, 'p1', 100),
(176, 295, 'p2', 100),
(177, 295, 'p3', 100),
(178, 295, 'p4', 100),
(179, 295, 'p5', 100),
(180, 295, 'p7', 100),
(181, 295, 'p9', 100),
(182, 295, 'p6', 100),
(183, 295, 'p8', 100),
(184, 42, 'p1', 80),
(185, 42, 'p2', 80),
(186, 42, 'p3', 80),
(187, 42, 'p4', 80),
(188, 42, 'p5', 80),
(189, 42, 'p6', 80),
(190, 42, 'p7', 80),
(191, 42, 'p8', 80),
(192, 42, 'p9', 80),
(193, 32, 'p1', 80),
(194, 32, 'p2', 80),
(195, 32, 'p3', 80),
(196, 32, 'p4', 20),
(197, 32, 'p5', 80),
(198, 32, 'p6', 80),
(199, 32, 'p7', 80),
(200, 32, 'p8', 100),
(201, 32, 'p9', 100),
(202, 128, 'p1', 100),
(203, 128, 'p2', 100),
(204, 128, 'p3', 100),
(205, 128, 'p4', 100),
(206, 128, 'p5', 100),
(207, 128, 'p6', 100),
(208, 128, 'p7', 100),
(209, 128, 'p8', 100),
(210, 128, 'p9', 100),
(211, 129, 'p1', 80),
(212, 129, 'p2', 40),
(213, 129, 'p3', 100),
(214, 129, 'p4', 100),
(215, 129, 'p5', 100),
(216, 129, 'p6', 100),
(217, 129, 'p7', 100),
(218, 129, 'p8', 100),
(219, 129, 'p9', 100),
(220, 300, 'p1', 100),
(221, 300, 'p2', 100),
(222, 300, 'p3', 80),
(223, 300, 'p4', 100),
(224, 300, 'p5', 100),
(225, 300, 'p6', 40),
(226, 300, 'p7', 80),
(227, 300, 'p8', 80),
(228, 300, 'p9', 100),
(229, 182, 'p1', 80),
(230, 182, 'p2', 80),
(231, 182, 'p3', 60),
(232, 182, 'p4', 80),
(233, 182, 'p5', 100),
(234, 182, 'p6', 80),
(235, 182, 'p7', 60),
(236, 182, 'p8', 80),
(237, 182, 'p9', 100),
(238, 245, 'p5', 100),
(239, 174, 'p1', 60),
(240, 174, 'p2', 20),
(241, 174, 'p3', 20),
(242, 174, 'p4', 20),
(243, 174, 'p5', 60),
(244, 174, 'p6', 20),
(245, 174, 'p7', 100),
(246, 15, 'p1', 100),
(247, 15, 'p2', 100),
(248, 15, 'p3', 100),
(249, 15, 'p4', 100),
(250, 15, 'p5', 100),
(251, 15, 'p6', 100),
(252, 15, 'p7', 100),
(253, 15, 'p8', 100),
(254, 15, 'p9', 100),
(255, 11, 'p1', 80),
(256, 11, 'p2', 20),
(257, 11, 'p3', 80),
(258, 11, 'p4', 80),
(259, 11, 'p5', 80),
(260, 11, 'p6', 60),
(261, 11, 'p7', 60),
(262, 11, 'p8', 100),
(263, 11, 'p9', 80),
(264, 50, 'p1', 60),
(265, 50, 'p2', 20),
(266, 50, 'p3', 60),
(267, 50, 'p4', 60),
(268, 50, 'p5', 80),
(269, 50, 'p6', 40),
(270, 50, 'p7', 80),
(271, 50, 'p8', 100),
(272, 50, 'p9', 80),
(273, 181, 'p1', 60),
(274, 181, 'p2', 60),
(275, 181, 'p3', 40),
(276, 181, 'p4', 20),
(277, 181, 'p5', 100),
(278, 181, 'p6', 60),
(279, 181, 'p7', 100),
(280, 181, 'p8', 60),
(281, 181, 'p9', 80);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_silabos`
--

CREATE TABLE `tb_silabos` (
  `idsilabo` int(11) NOT NULL,
  `iddocente` int(11) NOT NULL,
  `idsemestre` int(11) NOT NULL,
  `paralelo` varchar(1) NOT NULL,
  `jornada` varchar(25) NOT NULL,
  `idmateria` int(11) NOT NULL,
  `silabo` varchar(25) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_silabos`
--

INSERT INTO `tb_silabos` (`idsilabo`, `iddocente`, `idsemestre`, `paralelo`, `jornada`, `idmateria`, `silabo`, `estado`) VALUES
(1, 1, 1, 'A', 'Nocturno', 135, '1679362773.pdf', 1),
(9, 34, 3, 'A', 'Nocturno', 2, '', 0),
(10, 34, 3, 'A', 'Nocturno', 3, '1679436646.pdf', 1),
(11, 34, 4, 'A', 'Nocturno', 4, '1679436673.pdf', 1),
(12, 20, 2, 'A', 'Nocturno', 55, '1679535118.pdf', 1),
(13, 20, 3, 'A', 'Nocturno', 6, '1679535406.pdf', 1),
(14, 20, 3, 'A', 'Nocturno', 7, '1679535430.pdf', 1),
(15, 20, 2, 'A', 'Nocturno', 8, '1679536117.pdf', 1),
(16, 24, 6, 'A', 'Intensivo', 9, '', 0),
(17, 24, 1, 'A', 'Nocturno', 9, '', 0),
(18, 24, 1, 'B', 'Nocturno', 9, '', 0),
(19, 27, 5, 'A', 'En Línea', 10, '1679514806.pdf', 1),
(20, 27, 5, 'A', 'En Línea', 11, '1679514825.pdf', 1),
(21, 27, 5, 'A', 'En Línea', 12, '1679514842.pdf', 1),
(22, 21, 4, 'A', 'Nocturno', 13, '1679446503.pdf', 1),
(23, 21, 3, 'A', 'Nocturno', 14, '1679446522.pdf', 1),
(24, 21, 1, 'A', 'Nocturno', 15, '1679446533.pdf', 1),
(25, 21, 1, 'A', 'Nocturno', 17, '1679446547.pdf', 1),
(26, 21, 1, 'B', 'Nocturno', 17, '1679446557.pdf', 1),
(27, 21, 4, 'A', 'Nocturno', 18, '1679446574.pdf', 1),
(28, 19, 4, 'A', 'Nocturno', 19, '1679433485.pdf', 1),
(29, 19, 6, 'A', 'Nocturno', 20, '', 0),
(30, 19, 2, 'A', 'Nocturno', 20, '1679433502.pdf', 1),
(31, 19, 4, 'A', 'Nocturno', 21, '1679433517.pdf', 1),
(32, 19, 2, 'A', 'Nocturno', 22, '1679433528.pdf', 1),
(33, 19, 3, 'A', 'Nocturno', 23, '1679433547.pdf', 1),
(34, 28, 4, 'A', 'Vespertino', 24, '1679429403.pdf', 1),
(35, 28, 1, 'A', 'Matutino', 25, '1679429417.pdf', 1),
(36, 28, 2, 'A', 'Vespertino', 26, '1679429431.pdf', 1),
(38, 28, 3, 'A', 'Vespertino', 28, '1679429442.pdf', 1),
(39, 28, 4, 'A', 'Vespertino', 27, '1679429453.pdf', 1),
(40, 35, 2, 'A', 'Vespertino', 29, '', 0),
(41, 35, 3, 'A', 'Vespertino', 30, '', 0),
(42, 35, 3, 'A', 'Vespertino', 31, '', 0),
(43, 35, 2, 'A', 'Vespertino', 32, '', 0),
(44, 35, 1, 'B', 'Matutino', 33, '', 0),
(45, 35, 6, 'A', 'Intensivo', 34, '', 0),
(46, 33, 1, 'A', 'En Línea', 111, '1679431125.pdf', 1),
(47, 33, 1, 'A', 'En Línea', 112, '1679431137.pdf', 1),
(48, 33, 3, 'A', 'En Línea', 113, '1679431159.pdf', 1),
(49, 33, 3, 'A', 'En Línea', 114, '1679431171.pdf', 1),
(50, 33, 3, 'A', 'En Línea', 115, '1679431186.pdf', 1),
(51, 33, 5, 'A', 'En Línea', 115, '1679431241.pdf', 1),
(52, 33, 4, 'A', 'En Línea', 116, '1679431220.pdf', 1),
(53, 33, 4, 'A', 'En Línea', 117, '1679431263.pdf', 1),
(54, 33, 5, 'A', 'En Línea', 118, '1679431280.pdf', 1),
(55, 33, 1, 'A', 'En Línea', 119, '1679431300.pdf', 1),
(56, 33, 2, 'A', 'En Línea', 120, '1679431313.pdf', 1),
(57, 33, 2, 'A', 'En Línea', 121, '1679431328.pdf', 1),
(58, 33, 1, 'A', 'En Línea', 122, '1679431348.pdf', 1),
(59, 33, 4, 'A', 'En Línea', 123, '1679431367.pdf', 1),
(60, 33, 4, 'A', 'En Línea', 124, '1679431383.pdf', 1),
(61, 33, 4, 'A', 'En Línea', 125, '1679431398.pdf', 1),
(62, 33, 6, 'A', 'Intensivo', 126, '1679431428.pdf', 1),
(63, 33, 6, 'A', 'Nocturno', 127, '1679431449.pdf', 1),
(64, 33, 3, 'A', 'En Línea', 128, '1679431469.pdf', 1),
(65, 16, 3, 'A', 'Vespertino', 35, '1679431080.pdf', 1),
(66, 16, 2, 'A', 'Vespertino', 36, '1679431112.pdf', 1),
(67, 16, 1, 'A', 'Nocturno', 26, '1679431140.pdf', 1),
(68, 16, 1, 'B', 'Nocturno', 26, '1679431150.pdf', 1),
(69, 16, 3, 'A', 'Vespertino', 37, '1679431183.pdf', 1),
(71, 30, 5, 'A', 'Intensivo', 38, '1679452665.pdf', 1),
(72, 30, 6, 'A', 'Intensivo', 39, '1679452727.pdf', 1),
(73, 30, 1, 'A', 'Nocturno', 40, '1679452748.pdf', 1),
(74, 30, 3, 'B', 'Vesp/Noct', 41, '1679452766.pdf', 1),
(75, 30, 3, 'A', 'Vesp/Noct', 42, '1679452780.pdf', 1),
(76, 22, 4, 'A', 'Vesp/Noct', 43, '1679436237.pdf', 1),
(77, 22, 4, 'A', 'Vesp/Noct', 44, '1679436258.pdf', 1),
(78, 22, 5, 'A', 'Intensivo', 45, '1679436276.pdf', 1),
(79, 22, 3, 'B', 'Vesp/Noct', 46, '1679436293.pdf', 1),
(80, 22, 2, 'A', 'Nocturno', 8, '1679436310.pdf', 1),
(81, 37, 4, 'A', 'Vesp/Noct', 48, '', 0),
(82, 37, 4, 'A', 'Vesp/Noct', 49, '', 0),
(83, 37, 4, 'A', 'Vesp/Noct', 50, '', 0),
(84, 38, 5, 'A', 'Intensivo', 51, '', 0),
(85, 38, 6, 'A', 'Intensivo', 51, '', 0),
(86, 39, 3, 'B', 'Vesp/Noct', 53, '', 0),
(87, 17, 3, 'A', 'Vesp/Noct', 2, '1679430198.pdf', 1),
(88, 17, 1, 'B', 'Matutino', 16, '1679430215.pdf', 1),
(89, 17, 2, 'A', 'Nocturno', 5, '1679430227.pdf', 1),
(90, 15, 2, 'A', 'Vespertino', 56, '1679447837.pdf', 1),
(91, 15, 1, 'B', 'Matutino', 9, '1680566135.pdf', 1),
(92, 15, 2, 'A', 'Nocturno', 56, '1679447870.pdf', 1),
(93, 15, 1, 'A', 'En Línea', 57, '1680564976.pdf', 1),
(94, 15, 1, 'A', 'En Línea', 58, '1680565068.pdf', 1),
(95, 15, 2, 'A', 'En Línea', 59, '1680565317.pdf', 1),
(96, 15, 2, 'A', 'En Línea', 60, '1680565255.pdf', 1),
(97, 15, 3, 'A', 'En Línea', 61, '1680565366.pdf', 1),
(98, 15, 3, 'A', 'En Línea', 62, '1680565549.pdf', 1),
(99, 15, 3, 'A', 'En Línea', 63, '1680565549.pdf', 1),
(100, 15, 5, 'A', 'En Línea', 64, '1680565877.pdf', 1),
(101, 15, 5, 'A', 'En Línea', 65, '1680565640.pdf', 1),
(102, 15, 4, 'A', 'Vespertino', 66, '1679447892.pdf', 1),
(103, 15, 1, 'B', 'Matutino', 67, '1680566115.pdf', 1),
(104, 14, 6, 'A', 'Intensivo', 68, '1679443712.pdf', 1),
(105, 14, 5, 'A', 'Intensivo', 69, '1679443722.pdf', 1),
(106, 14, 2, 'A', 'Nocturno', 37, '1679443736.pdf', 1),
(107, 14, 6, 'A', 'Nocturno', 70, '1679443748.pdf', 1),
(108, 14, 2, 'A', 'Nocturno', 68, '1679443757.pdf', 1),
(109, 23, 1, 'A', 'En Línea', 71, '', 0),
(110, 23, 1, 'A', 'Nocturno', 72, '1679520702.pdf', 1),
(111, 23, 1, 'A', 'En Línea', 72, '', 0),
(112, 23, 3, 'A', 'En Línea', 73, '', 0),
(113, 32, 5, 'A', 'En Línea', 74, '', 0),
(114, 32, 5, 'A', 'En Línea', 75, '', 0),
(115, 32, 3, 'A', 'En Línea', 76, '', 0),
(116, 32, 3, 'A', 'En Línea', 77, '', 0),
(117, 31, 1, 'A', 'En Línea', 78, '1679443626.pdf', 1),
(118, 31, 1, 'B', 'En Línea', 78, '1679443617.pdf', 1),
(119, 31, 1, 'A', 'En Línea', 79, '1679443600.pdf', 1),
(120, 31, 1, 'A', 'Nocturno', 80, '1679443582.pdf', 1),
(121, 7, 1, 'A', 'En Línea', 81, '1680018013.pdf', 1),
(122, 7, 1, 'A', 'En Línea', 82, '1680018030.pdf', 1),
(123, 7, 2, 'A', 'En Línea', 83, '1680018041.pdf', 1),
(124, 7, 3, 'A', 'En Línea', 84, '1680018051.pdf', 1),
(125, 7, 3, 'A', 'En Línea', 85, '1680018061.pdf', 1),
(126, 7, 2, 'A', 'Nocturno', 86, '1680018073.pdf', 1),
(127, 7, 4, 'A', 'En Línea', 87, '1680018082.pdf', 1),
(128, 7, 5, 'A', 'En Línea', 88, '1680018091.pdf', 1),
(129, 7, 2, 'A', 'Vespertino', 89, '1680018104.pdf', 1),
(130, 7, 2, 'A', 'Nocturno', 90, '1680018116.pdf', 1),
(131, 7, 4, 'A', 'En Línea', 91, '1680018478.pdf', 1),
(132, 7, 6, 'A', 'Nocturno', 92, '1680018194.pdf', 1),
(133, 18, 1, 'A', 'Nocturno', 93, '', 0),
(134, 18, 1, 'A', 'En Línea', 89, '', 0),
(135, 18, 4, 'A', 'En Línea', 95, '', 0),
(136, 18, 4, 'A', 'En Línea', 96, '', 0),
(137, 18, 5, 'A', 'Intensivo', 97, '', 0),
(138, 18, 1, 'B', 'En Línea', 89, '', 0),
(139, 18, 1, 'A', 'En Línea', 98, '', 0),
(140, 18, 1, 'A', 'Nocturno', 99, '', 0),
(141, 18, 2, 'A', 'Nocturno', 91, '', 0),
(142, 18, 2, 'A', 'Nocturno', 89, '', 0),
(143, 29, 1, 'A', 'En Línea', 100, '', 0),
(144, 29, 1, 'A', 'En Línea', 101, '', 0),
(145, 29, 2, 'A', 'En Línea', 102, '', 0),
(146, 29, 3, 'A', 'En Línea', 103, '', 0),
(147, 29, 4, 'A', 'En Línea', 103, '', 0),
(148, 29, 3, 'A', 'Intensivo', 104, '', 0),
(149, 29, 4, 'A', 'En Línea', 96, '', 0),
(150, 29, 5, 'A', 'En Línea', 106, '', 0),
(151, 29, 5, 'A', 'En Línea', 107, '', 0),
(152, 29, 5, 'A', 'En Línea', 108, '', 0),
(153, 29, 4, 'A', 'En Línea', 109, '', 0),
(154, 29, 4, 'A', 'En Línea', 110, '', 0),
(155, 29, 2, 'A', 'Nocturno', 102, '', 0),
(156, 29, 1, 'A', 'Nocturno', 82, '', 0),
(157, 29, 2, 'A', 'Nocturno', 79, '', 0),
(158, 26, 2, 'A', 'Nocturno', 129, '1679434184.pdf', 1),
(159, 26, 3, 'A', 'En Línea', 129, '1679434204.pdf', 1),
(160, 26, 2, 'A', 'En Línea', 129, '1679434247.pdf', 1),
(161, 26, 2, 'B', 'Intensivo', 129, '1679432463.pdf', 1),
(162, 6, 1, 'B', 'Matutino', 72, '', 0),
(163, 6, 1, 'A', 'Matutino', 130, '', 0),
(164, 36, 4, 'A', 'Vespertino', 131, '1679427425.pdf', 1),
(165, 36, 4, 'A', 'Nocturno', 132, '1679427443.pdf', 1),
(166, 36, 1, 'A', 'Nocturno', 131, '1679427454.pdf', 1),
(167, 36, 6, 'A', 'Intensivo', 133, '1679427463.pdf', 1),
(168, 1, 4, 'A', 'En Línea', 134, '1679365229.pdf', 1),
(169, 34, 3, 'B', 'Vesp/Noct', 1, '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_usuario`
--

CREATE TABLE `tb_usuario` (
  `usuario` varchar(25) NOT NULL,
  `nombres` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_usuario`
--

INSERT INTO `tb_usuario` (`usuario`, `nombres`, `contrasena`) VALUES
('admin', 'Administrador', 'R2o4UW9NMzVsdDJvTnF5L05pcW1CZz09');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_administrativo`
--
ALTER TABLE `tb_administrativo`
  ADD PRIMARY KEY (`idadministrativo`),
  ADD KEY `idarea` (`idarea`),
  ADD KEY `idcargo` (`idcargo`);

--
-- Indices de la tabla `tb_area`
--
ALTER TABLE `tb_area`
  ADD PRIMARY KEY (`idarea`);

--
-- Indices de la tabla `tb_autoevaluacion`
--
ALTER TABLE `tb_autoevaluacion`
  ADD PRIMARY KEY (`idautoevaluacion`),
  ADD KEY `iddocente` (`iddocente`);

--
-- Indices de la tabla `tb_autoevaluacion_administrativo`
--
ALTER TABLE `tb_autoevaluacion_administrativo`
  ADD PRIMARY KEY (`idautoevaluacion`),
  ADD KEY `idadministrativo` (`idadministrativo`);

--
-- Indices de la tabla `tb_autoridad`
--
ALTER TABLE `tb_autoridad`
  ADD PRIMARY KEY (`idautoridad`),
  ADD KEY `idarea` (`idarea`);

--
-- Indices de la tabla `tb_cargo`
--
ALTER TABLE `tb_cargo`
  ADD PRIMARY KEY (`idcargo`);

--
-- Indices de la tabla `tb_carrera`
--
ALTER TABLE `tb_carrera`
  ADD PRIMARY KEY (`idcarrera`);

--
-- Indices de la tabla `tb_coevaluacion`
--
ALTER TABLE `tb_coevaluacion`
  ADD PRIMARY KEY (`idcoevaluacion`),
  ADD KEY `idevaluador` (`idevaluador`),
  ADD KEY `iddocente` (`iddocente`);

--
-- Indices de la tabla `tb_coevaluacion_administrativo`
--
ALTER TABLE `tb_coevaluacion_administrativo`
  ADD PRIMARY KEY (`idcoevaluacion`),
  ADD KEY `idevaluador` (`idevaluador`),
  ADD KEY `idadministrativo` (`idadministrativo`);

--
-- Indices de la tabla `tb_criterio`
--
ALTER TABLE `tb_criterio`
  ADD PRIMARY KEY (`idcriterio`);

--
-- Indices de la tabla `tb_detalle_autoevaluacion`
--
ALTER TABLE `tb_detalle_autoevaluacion`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idautoevaluacion` (`idautoevaluacion`);

--
-- Indices de la tabla `tb_detalle_autoevaluacion_administrativo`
--
ALTER TABLE `tb_detalle_autoevaluacion_administrativo`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idautoevaluacion` (`idautoevaluacion`);

--
-- Indices de la tabla `tb_detalle_coevaluacion`
--
ALTER TABLE `tb_detalle_coevaluacion`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idcoevaluacion` (`idcoevaluacion`);

--
-- Indices de la tabla `tb_detalle_coevaluacion_administrativo`
--
ALTER TABLE `tb_detalle_coevaluacion_administrativo`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idcoevaluacion` (`idcoevaluacion`);

--
-- Indices de la tabla `tb_detalle_evaluacion_estudiante`
--
ALTER TABLE `tb_detalle_evaluacion_estudiante`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idevaluacion` (`idevaluacion`);

--
-- Indices de la tabla `tb_detalle_heteroevaluacion`
--
ALTER TABLE `tb_detalle_heteroevaluacion`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idheteroevaluacion` (`idheteroevaluacion`);

--
-- Indices de la tabla `tb_detalle_heteroevaluacion_administrativo`
--
ALTER TABLE `tb_detalle_heteroevaluacion_administrativo`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idheteroevaluacion` (`idheteroevaluacion`);

--
-- Indices de la tabla `tb_docente`
--
ALTER TABLE `tb_docente`
  ADD PRIMARY KEY (`iddocente`),
  ADD KEY `idarea` (`idarea`);

--
-- Indices de la tabla `tb_estudiante`
--
ALTER TABLE `tb_estudiante`
  ADD PRIMARY KEY (`idestudiante`),
  ADD KEY `idcarrera` (`idcarrera`);

--
-- Indices de la tabla `tb_evaluacion_estudiante`
--
ALTER TABLE `tb_evaluacion_estudiante`
  ADD PRIMARY KEY (`idevaluacion`),
  ADD KEY `idestudiante` (`idestudiante`),
  ADD KEY `idsilabo` (`idsilabo`);

--
-- Indices de la tabla `tb_heteroevaluacion`
--
ALTER TABLE `tb_heteroevaluacion`
  ADD PRIMARY KEY (`idheteroevaluacion`),
  ADD KEY `idautoridad` (`idautoridad`),
  ADD KEY `iddocente` (`iddocente`);

--
-- Indices de la tabla `tb_heteroevaluacion_administrativo`
--
ALTER TABLE `tb_heteroevaluacion_administrativo`
  ADD PRIMARY KEY (`idheteroevaluacion`),
  ADD KEY `idautoridad` (`idautoridad`),
  ADD KEY `idadministrativo` (`idadministrativo`);

--
-- Indices de la tabla `tb_heteroevaluacion_estudiante_administrativo`
--
ALTER TABLE `tb_heteroevaluacion_estudiante_administrativo`
  ADD PRIMARY KEY (`idheteroevaluacion`),
  ADD KEY `idadministrativo` (`idadministrativo`),
  ADD KEY `idestudiante` (`idestudiante`);

--
-- Indices de la tabla `tb_materia`
--
ALTER TABLE `tb_materia`
  ADD PRIMARY KEY (`idmateria`);

--
-- Indices de la tabla `tb_portafolio`
--
ALTER TABLE `tb_portafolio`
  ADD PRIMARY KEY (`idportafolio`),
  ADD KEY `iddocente` (`iddocente`),
  ADD KEY `idcriterio` (`idcriterio`);

--
-- Indices de la tabla `tb_preguntas`
--
ALTER TABLE `tb_preguntas`
  ADD PRIMARY KEY (`idpregunta`),
  ADD KEY `idarea` (`idarea`);

--
-- Indices de la tabla `tb_preguntas_administrativo`
--
ALTER TABLE `tb_preguntas_administrativo`
  ADD PRIMARY KEY (`idpregunta`),
  ADD KEY `idarea` (`idarea`);

--
-- Indices de la tabla `tb_satisfaccion`
--
ALTER TABLE `tb_satisfaccion`
  ADD PRIMARY KEY (`idsatisfaccion`),
  ADD KEY `idestudiante` (`idestudiante`);

--
-- Indices de la tabla `tb_silabos`
--
ALTER TABLE `tb_silabos`
  ADD PRIMARY KEY (`idsilabo`),
  ADD KEY `iddocente` (`iddocente`),
  ADD KEY `idmateria` (`idmateria`);

--
-- Indices de la tabla `tb_usuario`
--
ALTER TABLE `tb_usuario`
  ADD PRIMARY KEY (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_administrativo`
--
ALTER TABLE `tb_administrativo`
  MODIFY `idadministrativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `tb_area`
--
ALTER TABLE `tb_area`
  MODIFY `idarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tb_autoevaluacion`
--
ALTER TABLE `tb_autoevaluacion`
  MODIFY `idautoevaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `tb_autoevaluacion_administrativo`
--
ALTER TABLE `tb_autoevaluacion_administrativo`
  MODIFY `idautoevaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `tb_autoridad`
--
ALTER TABLE `tb_autoridad`
  MODIFY `idautoridad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tb_cargo`
--
ALTER TABLE `tb_cargo`
  MODIFY `idcargo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tb_carrera`
--
ALTER TABLE `tb_carrera`
  MODIFY `idcarrera` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tb_coevaluacion`
--
ALTER TABLE `tb_coevaluacion`
  MODIFY `idcoevaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `tb_coevaluacion_administrativo`
--
ALTER TABLE `tb_coevaluacion_administrativo`
  MODIFY `idcoevaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `tb_criterio`
--
ALTER TABLE `tb_criterio`
  MODIFY `idcriterio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `tb_detalle_autoevaluacion`
--
ALTER TABLE `tb_detalle_autoevaluacion`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `tb_detalle_autoevaluacion_administrativo`
--
ALTER TABLE `tb_detalle_autoevaluacion_administrativo`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `tb_detalle_coevaluacion`
--
ALTER TABLE `tb_detalle_coevaluacion`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `tb_detalle_coevaluacion_administrativo`
--
ALTER TABLE `tb_detalle_coevaluacion_administrativo`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `tb_detalle_evaluacion_estudiante`
--
ALTER TABLE `tb_detalle_evaluacion_estudiante`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=795;

--
-- AUTO_INCREMENT de la tabla `tb_detalle_heteroevaluacion`
--
ALTER TABLE `tb_detalle_heteroevaluacion`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `tb_detalle_heteroevaluacion_administrativo`
--
ALTER TABLE `tb_detalle_heteroevaluacion_administrativo`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `tb_docente`
--
ALTER TABLE `tb_docente`
  MODIFY `iddocente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `tb_estudiante`
--
ALTER TABLE `tb_estudiante`
  MODIFY `idestudiante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=309;

--
-- AUTO_INCREMENT de la tabla `tb_evaluacion_estudiante`
--
ALTER TABLE `tb_evaluacion_estudiante`
  MODIFY `idevaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1162;

--
-- AUTO_INCREMENT de la tabla `tb_heteroevaluacion`
--
ALTER TABLE `tb_heteroevaluacion`
  MODIFY `idheteroevaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `tb_heteroevaluacion_administrativo`
--
ALTER TABLE `tb_heteroevaluacion_administrativo`
  MODIFY `idheteroevaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `tb_heteroevaluacion_estudiante_administrativo`
--
ALTER TABLE `tb_heteroevaluacion_estudiante_administrativo`
  MODIFY `idheteroevaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1309;

--
-- AUTO_INCREMENT de la tabla `tb_materia`
--
ALTER TABLE `tb_materia`
  MODIFY `idmateria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT de la tabla `tb_portafolio`
--
ALTER TABLE `tb_portafolio`
  MODIFY `idportafolio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=262;

--
-- AUTO_INCREMENT de la tabla `tb_preguntas`
--
ALTER TABLE `tb_preguntas`
  MODIFY `idpregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `tb_preguntas_administrativo`
--
ALTER TABLE `tb_preguntas_administrativo`
  MODIFY `idpregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `tb_satisfaccion`
--
ALTER TABLE `tb_satisfaccion`
  MODIFY `idsatisfaccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=282;

--
-- AUTO_INCREMENT de la tabla `tb_silabos`
--
ALTER TABLE `tb_silabos`
  MODIFY `idsilabo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_administrativo`
--
ALTER TABLE `tb_administrativo`
  ADD CONSTRAINT `fk_administrativos_area` FOREIGN KEY (`idarea`) REFERENCES `tb_area` (`idarea`),
  ADD CONSTRAINT `fk_administrativos_cargo` FOREIGN KEY (`idcargo`) REFERENCES `tb_cargo` (`idcargo`);

--
-- Filtros para la tabla `tb_autoevaluacion`
--
ALTER TABLE `tb_autoevaluacion`
  ADD CONSTRAINT `fk_autoevaluacion_docente` FOREIGN KEY (`iddocente`) REFERENCES `tb_docente` (`iddocente`);

--
-- Filtros para la tabla `tb_autoevaluacion_administrativo`
--
ALTER TABLE `tb_autoevaluacion_administrativo`
  ADD CONSTRAINT `fk_autoevaluacion_administrativo` FOREIGN KEY (`idadministrativo`) REFERENCES `tb_administrativo` (`idadministrativo`);

--
-- Filtros para la tabla `tb_autoridad`
--
ALTER TABLE `tb_autoridad`
  ADD CONSTRAINT `fk_autoridad_area` FOREIGN KEY (`idarea`) REFERENCES `tb_area` (`idarea`);

--
-- Filtros para la tabla `tb_coevaluacion`
--
ALTER TABLE `tb_coevaluacion`
  ADD CONSTRAINT `fk_coevaluacion_docente_docente` FOREIGN KEY (`iddocente`) REFERENCES `tb_docente` (`iddocente`),
  ADD CONSTRAINT `fk_coevaluacion_evaluador_docente` FOREIGN KEY (`idevaluador`) REFERENCES `tb_docente` (`iddocente`);

--
-- Filtros para la tabla `tb_coevaluacion_administrativo`
--
ALTER TABLE `tb_coevaluacion_administrativo`
  ADD CONSTRAINT `fk_coevaluacion_administrativo_administrativo` FOREIGN KEY (`idadministrativo`) REFERENCES `tb_administrativo` (`idadministrativo`),
  ADD CONSTRAINT `fk_coevaluacion_evaluador_administrativo` FOREIGN KEY (`idevaluador`) REFERENCES `tb_administrativo` (`idadministrativo`);

--
-- Filtros para la tabla `tb_detalle_autoevaluacion`
--
ALTER TABLE `tb_detalle_autoevaluacion`
  ADD CONSTRAINT `fk_detalle_autoevaluacion` FOREIGN KEY (`idautoevaluacion`) REFERENCES `tb_autoevaluacion` (`idautoevaluacion`);

--
-- Filtros para la tabla `tb_detalle_autoevaluacion_administrativo`
--
ALTER TABLE `tb_detalle_autoevaluacion_administrativo`
  ADD CONSTRAINT `fk_detalle_autoevalaucion_administrativo` FOREIGN KEY (`idautoevaluacion`) REFERENCES `tb_autoevaluacion_administrativo` (`idautoevaluacion`);

--
-- Filtros para la tabla `tb_detalle_coevaluacion`
--
ALTER TABLE `tb_detalle_coevaluacion`
  ADD CONSTRAINT `fk_detalle_coevaluacion` FOREIGN KEY (`idcoevaluacion`) REFERENCES `tb_coevaluacion` (`idcoevaluacion`);

--
-- Filtros para la tabla `tb_detalle_coevaluacion_administrativo`
--
ALTER TABLE `tb_detalle_coevaluacion_administrativo`
  ADD CONSTRAINT `fk_detalle_coevaluacion_administrativo` FOREIGN KEY (`idcoevaluacion`) REFERENCES `tb_coevaluacion_administrativo` (`idcoevaluacion`);

--
-- Filtros para la tabla `tb_detalle_evaluacion_estudiante`
--
ALTER TABLE `tb_detalle_evaluacion_estudiante`
  ADD CONSTRAINT `fk_detalle_evaluacion` FOREIGN KEY (`idevaluacion`) REFERENCES `tb_evaluacion_estudiante` (`idevaluacion`);

--
-- Filtros para la tabla `tb_detalle_heteroevaluacion`
--
ALTER TABLE `tb_detalle_heteroevaluacion`
  ADD CONSTRAINT `fk_detalle_heteroevaluacion` FOREIGN KEY (`idheteroevaluacion`) REFERENCES `tb_heteroevaluacion` (`idheteroevaluacion`);

--
-- Filtros para la tabla `tb_detalle_heteroevaluacion_administrativo`
--
ALTER TABLE `tb_detalle_heteroevaluacion_administrativo`
  ADD CONSTRAINT `fk_detalle_heteroevaluacion_administrativo` FOREIGN KEY (`idheteroevaluacion`) REFERENCES `tb_heteroevaluacion_administrativo` (`idheteroevaluacion`);

--
-- Filtros para la tabla `tb_docente`
--
ALTER TABLE `tb_docente`
  ADD CONSTRAINT `fk_docente_area` FOREIGN KEY (`idarea`) REFERENCES `tb_area` (`idarea`);

--
-- Filtros para la tabla `tb_evaluacion_estudiante`
--
ALTER TABLE `tb_evaluacion_estudiante`
  ADD CONSTRAINT `fk_evaluacion_estudiante` FOREIGN KEY (`idestudiante`) REFERENCES `tb_estudiante` (`idestudiante`),
  ADD CONSTRAINT `fk_evaluacion_silabo` FOREIGN KEY (`idsilabo`) REFERENCES `tb_silabos` (`idsilabo`);

--
-- Filtros para la tabla `tb_heteroevaluacion`
--
ALTER TABLE `tb_heteroevaluacion`
  ADD CONSTRAINT `fk_heteroevaluacion_autoridad` FOREIGN KEY (`idautoridad`) REFERENCES `tb_autoridad` (`idautoridad`),
  ADD CONSTRAINT `fk_heteroevaluacion_docente` FOREIGN KEY (`iddocente`) REFERENCES `tb_docente` (`iddocente`);

--
-- Filtros para la tabla `tb_heteroevaluacion_administrativo`
--
ALTER TABLE `tb_heteroevaluacion_administrativo`
  ADD CONSTRAINT `fk_heteroevalaucion_administrativo` FOREIGN KEY (`idadministrativo`) REFERENCES `tb_administrativo` (`idadministrativo`),
  ADD CONSTRAINT `fk_heteroevaluacion_administrativo_autoridad` FOREIGN KEY (`idautoridad`) REFERENCES `tb_autoridad` (`idautoridad`);

--
-- Filtros para la tabla `tb_heteroevaluacion_estudiante_administrativo`
--
ALTER TABLE `tb_heteroevaluacion_estudiante_administrativo`
  ADD CONSTRAINT `fk_heteroevaluacion_estudiante_administrativo` FOREIGN KEY (`idadministrativo`) REFERENCES `tb_administrativo` (`idadministrativo`),
  ADD CONSTRAINT `fk_heteroevaluacion_estudiante_estudiante` FOREIGN KEY (`idestudiante`) REFERENCES `tb_estudiante` (`idestudiante`);

--
-- Filtros para la tabla `tb_portafolio`
--
ALTER TABLE `tb_portafolio`
  ADD CONSTRAINT `fk_portafolio_criterio` FOREIGN KEY (`idcriterio`) REFERENCES `tb_criterio` (`idcriterio`),
  ADD CONSTRAINT `fk_portafolio_docente` FOREIGN KEY (`iddocente`) REFERENCES `tb_docente` (`iddocente`);

--
-- Filtros para la tabla `tb_preguntas`
--
ALTER TABLE `tb_preguntas`
  ADD CONSTRAINT `fk_pregunta_area` FOREIGN KEY (`idarea`) REFERENCES `tb_area` (`idarea`);

--
-- Filtros para la tabla `tb_preguntas_administrativo`
--
ALTER TABLE `tb_preguntas_administrativo`
  ADD CONSTRAINT `fk_preguntas_administrativo_area` FOREIGN KEY (`idarea`) REFERENCES `tb_area` (`idarea`);

--
-- Filtros para la tabla `tb_satisfaccion`
--
ALTER TABLE `tb_satisfaccion`
  ADD CONSTRAINT `fk_satisfaccion_estudiante` FOREIGN KEY (`idestudiante`) REFERENCES `tb_estudiante` (`idestudiante`);

--
-- Filtros para la tabla `tb_silabos`
--
ALTER TABLE `tb_silabos`
  ADD CONSTRAINT `fk_silabo_docente` FOREIGN KEY (`iddocente`) REFERENCES `tb_docente` (`iddocente`),
  ADD CONSTRAINT `fk_silabo_materia` FOREIGN KEY (`idmateria`) REFERENCES `tb_materia` (`idmateria`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
