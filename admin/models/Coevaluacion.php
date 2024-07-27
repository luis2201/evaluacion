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

        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_coevaluacion_insert(:idevaluador, :iddocente);");

            return $prepare->execute($params);
        }

        public static function Delete($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_coevaluacion_delete(:idcoevaluacion);");

            return $prepare->execute($params);
        }
    }

?>