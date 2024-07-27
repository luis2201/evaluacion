<?php

    class Autoridades extends DB
    {
        public static function findAll()
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoridades_select_all();");
            $prepare->execute();

            return $prepare->fetchAll(PDO::FETCH_CLASS, Autoridades::class);
        }

        public static function findIdentificacion($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoridades_select_identificacion(:idautoridad, :identificacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Autoridades::class);
        }

        public static function findCorreo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoridades_select_correo(:idautoridad, :correo);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Autoridades::class);
        }

        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoridades_insert(:tipoidentificacion, :identificacion, :nombres, :apellidos, :correo, :idarea, :contrasena);");
            
            return $prepare->execute($params);            
        }

        public static function findId($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoridades_select_id(:idautoridad);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Autoridades::class);
        }

        public static function Update($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoridades_update(:idautoridad, :tipoidentificacion, :identificacion, :nombres, :apellidos, :correo, :idarea);");
            
            return $prepare->execute($params);            
        }

        public static function Delete($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_autoridades_delete(:idautoridad);");
            
            return $prepare->execute($params);            
        }

    }

?>