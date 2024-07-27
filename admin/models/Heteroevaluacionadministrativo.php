<?php

    class Heteroevaluacionadministrativo extends DB
    {
        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_administrativo_insert(:idautoridad, :idadministrativo);");

            return $prepare->execute($params);
        }

        public static function SelectAutoridadAdministrativo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_autoridad_administrativo(:idautoridad);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Heteroevaluacionadministrativo::class);
        }

        public static function Delete($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_heteroevaluacion_administrativo_delete(:idheteroevaluacion);");

            return $prepare->execute($params);
        }
    }

?>