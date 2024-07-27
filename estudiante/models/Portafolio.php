<?php

    class Portafolio extends DB
    {
        public static function selectIdDocente($iddocente)
        {
            $db = new DB();
            $prepare = $db->prepare("call sp_portafolio_select_iddocente(:iddocente);");
            
            $prepare->execute([":iddocente" => $iddocente]);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Portafolio::class);
        }

        public static function findCriterio($params)
        {
            $db = new DB();
            $prepare = $db->prepare("call sp_portafolio_select_idcriterio(:iddocente, :idcriterio);");
            
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Portafolio::class);
        }

        public static function Insert($params)
        {
            $db = new DB();
            $prepare = $db->prepare("call sp_portafolio_insert(:iddocente, :idcriterio, :documento)");
            
            return $prepare->execute($params);
        }

        public static function findDocumento($params)
        {
            $db = new DB();
            $prepare = $db->prepare("call select_documento_idportafolio(:idportafolio);");
            
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Portafolio::class);
        }

        public static function Delete($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_portafolio_delete(:idportafolio);");
            
            return $prepare->execute($params);
        }
    }

?>