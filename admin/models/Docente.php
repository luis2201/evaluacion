<?php

    class Docente extends DB
    {
        public static function findAll()
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_docente_select_all();");
            $prepare->execute();

            return $prepare->fetchAll(PDO::FETCH_CLASS, Docente::class);
        }

        public static function findIdentificacion($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_docente_select_identificacion(:iddocente, :identificacion);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Docente::class);
        }

        public static function findCorreo($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_docente_select_correo(:iddocente, :correo);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Docente::class);
        }

        public static function Insert($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_docente_insert(:tipoidentificacion, :identificacion, :nombres, :apellidos, :correo, :idarea, :contrasena);");
            
            return $prepare->execute($params);            
        }

        public static function findId($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_docente_select_id(:iddocente);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Docente::class);
        }

        public static function Update($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_docente_update(:iddocente, :tipoidentificacion, :identificacion, :nombres, :apellidos, :correo, :idarea);");
            
            return $prepare->execute($params);            
        }

        public static function Delete($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_docente_delete(:iddocente);");
            
            return $prepare->execute($params);            
        }

        public static function DocenteMateriaAll()
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_docente_materia_select_all();");
            $prepare->execute();       
            
            return $prepare->fetchAll(PDO::FETCH_CLASS, Docente::class);
        }

    }

?>