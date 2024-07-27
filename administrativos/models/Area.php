<?php

    class Area extends DB
    {
        public static function findIdAreaAdministrativo($idadministrativo)
        {
            $db = new DB();

            $params = [":idadministrativo" => $idadministrativo]; 
            $prepare = $db->prepare("call sp_area_select_idadministrativo(:idadministrativo);");
            
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Area::class);
        } 

    }

?>