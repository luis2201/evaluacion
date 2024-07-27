<?php

    class Criterios extends DB
    {
        public static function findAll()
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_criterios_select_all();");
            $prepare->execute();

            return $prepare->fetchAll(PDO::FETCH_CLASS, Criterios::class);
        }
    }