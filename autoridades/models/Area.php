<?php

    class Area extends DB
    {
        public static function findIdAreaAutoridad($idautoridad)
        {
            $db = new DB();

            $params = [":idautoridad" => $idautoridad]; 
            $prepare = $db->prepare("call sp_area_select_idautoridad(:idautoridad);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Area::class);
        } 
    }

?>