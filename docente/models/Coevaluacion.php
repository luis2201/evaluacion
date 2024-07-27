<?php

    class Coevaluacion extends DB
    {
        public static function SelectEvaluadorDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_coevaluacion_evaluador_docente(:idevaluador);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Coevaluacion::class);
        }

        public static function findCoevaluacionDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_coevaluacion_docente_select(:idcoevaluacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Coevaluacion::class);
        }

        public static function Insert($params)
        {
            $db = new DB();
            
            $prepare = $db->prepare("call sp_detalle_coevaluacion_insert(:idcoevaluacion, :indicador1, :indicador2, :indicador3, :indicador4, :indicador5, :total);");
            
            return $prepare->execute($params);
        }
    }

?>