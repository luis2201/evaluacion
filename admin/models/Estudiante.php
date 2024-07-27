<?php

    class Estudiante extends DB
    {
        public static function findAll()
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_estudiante_select_all();");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Estudiante::class);
        }

        public static function findEstudiante($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_estudiante_select_carrera(:idcarrera, :idsemestre, :jornada);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Estudiante::class);
        }

        public static function validaEstado($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_estudiante_valida_estado(:idestudiante);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Estudiante::class);
        }
    }

?>