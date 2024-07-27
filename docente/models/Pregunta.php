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
    }

?>