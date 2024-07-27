<?php

    class Portafolio extends DB
    {
        public static function finddocentecriterio($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_portafolio_select_iddocente(:iddocente);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Portafolio::class);
        }
    }

?>