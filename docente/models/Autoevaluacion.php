<?php

    class Autoevaluacion extends DB
    {
        public static function SelectAutoevaluacionDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoevaluacion_docente(:iddocente);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Autoevaluacion::class);
        }

        public static function findAutoevaluacionDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoevaluacion_docente_select(:idautoevaluacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Coevaluacion::class);
        }

        public static function Insert($params)
        {
            $db = new DB();
            
            $prepare = $db->prepare("call sp_detalle_autoevaluacion_insert(:idautoevaluacion, :indicador1, :indicador2, :indicador3, :indicador4, :indicador5, :total);");
            
            return $prepare->execute($params);
        }
    }

?>