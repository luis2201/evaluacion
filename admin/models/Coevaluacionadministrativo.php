<?php

    class Coevaluacionadministrativo extends DB
    {
        public static function SelectEvaluadorAdministrativo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_coevaluacion_evaluador_administrativo(:idevaluador);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Coevaluacionadministrativo::class);
        }

        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_coevaluacion_administrativo_insert(:idevaluador, :idadministrativo);");

            return $prepare->execute($params);
        }

        public static function Delete($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_coevaluacion_administrativo_delete(:idcoevaluacion);");

            return $prepare->execute($params);
        }
    }

?>