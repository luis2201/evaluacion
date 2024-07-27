<?php

    class Administrativos extends DB
    {
        public static function findAll()
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_administrativo_select_all();");
            $prepare->execute();

            return $prepare->fetchAll(PDO::FETCH_CLASS, Administrativos::class);
        }

        public static function findIdentificacion($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_administrativo_select_identificacion(:idadministrativo, :identificacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Administrativos::class);
        }

        public static function findCorreo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_administrativo_select_correo(:idadministrativo, :correo);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Administrativos::class);
        }

        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_administrativo_insert(:tipoidentificacion, :identificacion, :nombres, :apellidos, :correo, :idarea, :contrasena);");
            
            return $prepare->execute($params);            
        }

        public static function findId($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_administrativo_select_id(:idadministrativo);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Administrativos::class);
        }

        public static function Update($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_administrativo_update(:idadministrativo, :tipoidentificacion, :identificacion, :nombres, :apellidos, :correo, :idarea);");
            
            return $prepare->execute($params);            
        }

        public static function Delete($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_administrativo_delete(:idadministrativo);");
            
            return $prepare->execute($params);            
        }

        public static function administrativoMateriaAll()
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_administrativo_materia_select_all();");
            $prepare->execute();       
            
            return $prepare->fetchAll(PDO::FETCH_CLASS, Administrativos::class);
        }

    }

?>