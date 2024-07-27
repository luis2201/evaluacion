<?php

    class Autoevaluacion extends DB
    {
        public static function SelectAutoevaluacionAdministrativo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoevaluacion_administrativo(:idadministrativo);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Autoevaluacion::class);
        }

        public static function findAutoevaluacionAdministrativo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoevaluacion_administrativo_select(:idautoevaluacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Autoevaluacion::class);
        }

        public static function Insert($params)
        {
            $db = new DB();
            
            $prepare = $db->prepare("call sp_detalle_autoevaluacion_administrativo_insert(:idautoevaluacion, :indicador1, :indicador2, :indicador3, :indicador4, :indicador5, :indicador6, :indicador7, :indicador8, :indicador9, :indicador10, :total);");
            
            return $prepare->execute($params);
        }
    }

?>