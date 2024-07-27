<?php

  class Resultadosestudiantes extends DB
  {
    public static function findAdministrativos()
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT A.idadministrativo, A.apellidos, A.nombres, C.cargo 
                              FROM tb_administrativo A INNER JOIN tb_cargo C ON A.idcargo = C.idcargo 
                              ORDER BY A.apellidos, A.nombres;");
      $prepare->execute();

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosadministrativos::class);
    }

    public static function findCalificacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT TRUNCATE(AVG(total),2) AS total, COUNT(*)AS num
                              FROM tb_heteroevaluacion_estudiante_administrativo
                              WHERE idadministrativo = :idadministrativo");
      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosadministrativos::class);
    }
  }

?>