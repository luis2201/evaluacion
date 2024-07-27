<?php

    class Estudiantedocente extends DB
    {
      public static function register($params)
      {
        $db = new DB();

        $prepare = $db->prepare("call sp_evaluacionestudiante_insert(:idestudiante, :idsilabo)");
        
        return $prepare->execute($params);
      }

      public static function findDocenteIdSemestre()
      {
        $db = new DB();

        $prepare = $db->prepare("call sp_evaluacionestudiante_select_all()");        
        $prepare->execute();

        return $prepare->fetchAll(PDO::FETCH_CLASS, Estudiantedocente::class);
      }
    }

?>