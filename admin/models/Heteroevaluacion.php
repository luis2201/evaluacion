<?php

    class Heteroevaluacion extends DB
    {
        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_insert(:idautoridad, :iddocente);");

            return $prepare->execute($params);
        }

        public static function SelectAutoridadDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_autoridad_docente(:idautoridad);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Heteroevaluacion::class);
        }

        public static function Delete($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_delete(:idheteroevaluacion);");

            return $prepare->execute($params);
        }
    }

?>