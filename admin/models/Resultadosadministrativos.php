<?php 

  class Resultadosadministrativos extends DB
  {

    public static function findAll()
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT A.idadministrativo, A.apellidos, A.nombres, DU.total AS autoevaluacion, CO.total AS coevaluacion/*, AVG(HO.total) AS heteroevaluacion*/
                              FROM tb_administrativo A
                              INNER JOIN tb_autoevaluacion_administrativo U ON A.idadministrativo = U.idadministrativo
                              INNER JOIN tb_detalle_autoevaluacion_administrativo DU ON DU.idautoevaluacion = U.idautoevaluacion
                              INNER JOIN tb_coevaluacion_administrativo O ON A.idadministrativo = O.idadministrativo
                              INNER JOIN tb_detalle_coevaluacion_administrativo CO ON CO.idcoevaluacion = O.idcoevaluacion
                              /*INNER JOIN tb_heteroevaluacion_administrativo H ON A.idadministrativo = H.idadministrativo
                              INNER JOIN tb_detalle_heteroevaluacion_administrativo HO ON HO.idheteroevaluacion = H.idheteroevaluacion*/
                              GROUP BY A.idadministrativo
                              ORDER BY A.apellidos, A.nombres");
      $prepare->execute();

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosadministrativos::class);
    }
    
    public static function Autoevaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT A.idadministrativo, D.indicador1, D.indicador2, D.indicador3, D.indicador4, D.indicador5, 
                              D.indicador6, D.indicador7, D.indicador8, D.indicador9, D.indicador10, D.total 
                              FROM tb_detalle_autoevaluacion_administrativo D 
                              INNER JOIN tb_autoevaluacion_administrativo A ON D.idautoevaluacion = A.idautoevaluacion 
                              WHERE A.idadministrativo = :idadministrativo");
      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosadministrativos::class);
    }

    public static function Coevaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT C.idadministrativo, D.indicador1, D.indicador2, D.indicador3, D.indicador4, D.indicador5, 
                              D.indicador6, D.indicador7, D.indicador8, D.indicador9, D.indicador10, D.total
                              FROM tb_detalle_coevaluacion_administrativo D 
                              INNER JOIN tb_coevaluacion_administrativo C ON D.idcoevaluacion = C.idcoevaluacion
                              WHERE C.idadministrativo = :idadministrativo");

      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosadministrativos::class);
    }

    public static function Heteroevaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT H.idadministrativo, AVG(D.indicador1) AS indicador1, AVG(D.indicador2) AS indicador2, avg(D.indicador3) 
                              AS indicador3, AVG(D.indicador4) AS indicador4, AVG(D.indicador5) AS indicador5, 
                              D.indicador6, D.indicador7, D.indicador8, D.indicador9, D.indicador10, AVG(D.total) AS total
                              FROM tb_detalle_heteroevaluacion_administrativo D 
                              INNER JOIN tb_heteroevaluacion_administrativo H ON D.idheteroevaluacion = H.idheteroevaluacion
                              WHERE H.idadministrativo = :idadministrativo
                              GROUP BY H.idadministrativo");

      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosadministrativos::class);
    }

  }