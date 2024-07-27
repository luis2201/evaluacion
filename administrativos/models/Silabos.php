<?php

    class Silabos extends DB
    {
        public static function findAllIdDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_silabos_select_iddocente(:iddocente);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Silabos::class);
        }

        public function Upload($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_silabos_upload(:idsilabo, :silabo);");

            return $prepare->execute($params);
        }
    }