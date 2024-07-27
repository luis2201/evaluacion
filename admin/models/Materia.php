<?php

    class Materia extends DB
    {
        public static function findAll()
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_materia_select_all();");
            $prepare->execute();

            return $prepare->fetchAll(PDO::FETCH_CLASS, Materia::class);
        }
    }

?>