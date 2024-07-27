<?php

  class Satisfaccionusuario extends DB
  {    
    public static function validaEvaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT COUNT(*) AS num FROM tb_satisfaccion WHERE idestudiante = :idestudiante AND parametro = :parametro AND calificacion>0;");
      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Administrativos::class);
    }

    public static function Insert($params)
    {
      $db = new DB();

      $prepare = $db->prepare("call sp_satisfaccion_insert(:idestudiante, :parametro, :calificacion)");
      return $prepare->execute($params);      
    }
  }