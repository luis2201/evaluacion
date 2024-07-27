<?php

    class Coevaluacion extends DB
    {
        public static function SelectEvaluadorAdministrativo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_coevaluacion_evaluador_administrativo(:idevaluador);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Coevaluacion::class);
        }

        public static function findCoevaluacionAdministrativo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_coevaluacion_administrativo_select(:idcoevaluacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Coevaluacion::class);
        }

        public static function Insert($params)
        {
            $db = new DB();
            
            $prepare = $db->prepare("call sp_detalle_coevaluacion_administrativo_insert(:idcoevaluacion, :indicador1, :indicador2, :indicador3, :indicador4, :indicador5, :indicador6, :indicador7, :indicador8, :indicador9, :indicador10, :total);");
            
            return $prepare->execute($params);
        }
    }

?>