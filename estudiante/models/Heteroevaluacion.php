<?php

    class Heteroevaluacion extends DB
    {
        public static function SelectEstudianteDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_estudiante_docente(:idestudiante);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Heteroevaluacion::class);
        }

        public static function findHeteroevaluacionDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_estudiante_docente_select_id(:idevaluacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Heteroevaluacion::class);
        }

        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_detalle_heteroevaluacion_estudiante_docente_insert(:idevaluacion, :indicador1, :indicador2, :indicador3, :indicador4, :indicador5, :total);");
            
            return $prepare->execute($params);
        }
    }

?>