<?php 

    class Pregunta extends DB
    {
        public static function findPreguntaArea($idarea)
        {
            $db = new DB();

            $params = [":idarea" => $idarea];
            $prepare = $db->prepare("call sp_preguntas_select_area(:idarea);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Pregunta::class);
        }

        public static function findPreguntaAreaAutoevaluacion($idarea)
        {
            $db = new DB();

            $params = [":idarea" => $idarea, ":tipo" => 'A'];
            $prepare = $db->prepare("call sp_preguntas_select_area_autoevaluacion(:idarea, :tipo);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Pregunta::class);
        }

        public static function findPreguntaAreaCoevaluacion($idarea)
        {
            $db = new DB();

            $params = [":idarea" => $idarea, ":tipo" => 'C'];
            $prepare = $db->prepare("call sp_preguntas_select_area_coevaluacion(:idarea, :tipo);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Pregunta::class);
        }
    }

?>