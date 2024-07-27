<?php

    class Heteroevaluacion extends DB
    {
        public static function SelectAutoridadDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_autoridad_docente(:idautoridad);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Heteroevaluacion::class);
        }

        public static function findHeteroevaluacionDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_docente_select(:idheteroevaluacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Heteroevaluacion::class);
        }

        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_detalle_heteroevaluacion_insert(:idheteroevaluacion, :indicador1, :indicador2, :indicador3, :indicador4, :indicador5, :total);");
            
            return $prepare->execute($params);
        }
    }

?>