<?php

  class Administrativos extends DB
  {
    public static function findAll()
    {
      $db = new DB();

      $prepare = $db->prepare("call sp_administrativos_select_all()");
      $prepare->execute();

      return $prepare->fetchAll(PDO::FETCH_CLASS, Administrativos::class);
    }

    public static function validaEvaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("call sp_administrativos_valida_evaluacion(:idestudiante, :idadministrativo)");
      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Administrativos::class);
    }

    public static function Insert($params)
    {
      $db = new DB();

      $prepare = $db->prepare("call sp_heteroevaluacion_estudiante_administrativo_insert(:idestudiante, :idadministrativo, :calificacion)");
      return $prepare->execute($params);      
    }
  }