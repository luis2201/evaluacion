<?php

    class Area extends DB
    {
        public static function findIdAreaDocente($iddocente)
        {
            $db = new DB();

            $params = [":iddocente" => $iddocente]; 
            $prepare = $db->prepare("call sp_area_select_iddocente(:iddocente);");
            
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Area::class);
        } 
    }

?>