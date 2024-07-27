<?php

    class Heteroevaluacionadministrativos extends DB
    {
        public static function SelectAutoridadAdministrativos($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_autoridad_administrativo(:idautoridad);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Heteroevaluacionadministrativos::class);
        }

        public static function findHeteroevaluacionAdministrativo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_administrativo_select(:idheteroevaluacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Heteroevaluacion::class);
        }

        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_detalle_heteroevaluacion_administrativos_insert(:idheteroevaluacion, :indicador1, :indicador2, :indicador3, :indicador4, :indicador5, :indicador6, :indicador7, :indicador8, :indicador9, :indicador10, :total);");
            
            return $prepare->execute($params);
        }
    }

?>