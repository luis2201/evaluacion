<?php 

  class Resultadosdocentes extends DB
  {

    public static function ResultadoAutoevaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT T.iddocente, T.apellidos, T.nombres, D.indicador1, D.indicador2, D.indicador3, D.indicador4, D.indicador5, D.total
                              FROM tb_docente T
                              INNER JOIN tb_autoevaluacion A ON T.iddocente = A.iddocente 
                              INNER JOIN tb_detalle_autoevaluacion D ON A.idautoevaluacion = D.idautoevaluacion 
                              WHERE A.iddocente = :iddocente");
      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosdocentes::class);
    }

    public static function ResultadoCoevaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT T.iddocente, T.apellidos, T.nombres, D.indicador1, D.indicador2, D.indicador3, D.indicador4, D.indicador5, D.total
                              FROM tb_docente T
                              INNER JOIN tb_coevaluacion C ON T.iddocente = C.iddocente 
                              INNER JOIN tb_detalle_coevaluacion D ON C.idcoevaluacion = D.idcoevaluacion 
                              WHERE C.iddocente = :iddocente");
      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosdocentes::class);
    }

    public static function ResultadoArea($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT D.indicador1, D.indicador2, D.indicador3, D.indicador4, D.indicador5, D.total
                              FROM tb_heteroevaluacion H
                              INNER JOIN tb_autoridad A ON H.idautoridad = A.idautoridad
                              INNER JOIN tb_detalle_heteroevaluacion D ON H.idheteroevaluacion = D.idheteroevaluacion
                              WHERE A.idarea = :idarea
                              AND H.iddocente = :iddocente;");
      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosdocentes::class);
    }

    public static function ResultadoEstudiante($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT COUNT(*) AS num, TRUNCATE(AVG(DE.indicador1),2) AS indicador1, TRUNCATE(AVG(DE.indicador2),2) AS indicador2, 
                              TRUNCATE(AVG(DE.indicador3),2) AS indicador3, TRUNCATE(AVG(DE.indicador4),2) AS indicador4, TRUNCATE(AVG(DE.indicador5),2) AS indicador5, 
                              TRUNCATE(AVG(DE.total),2) AS total
                              FROM tb_detalle_evaluacion_estudiante DE
                              INNER JOIN tb_evaluacion_estudiante E ON DE.idevaluacion = E.idevaluacion
                              INNER JOIN tb_silabos S ON S.idsilabo = E.idsilabo
                              INNER JOIN tb_docente D ON D.iddocente = S.iddocente
                              WHERE D.iddocente = :iddocente;");
      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosdocentes::class);
    }
    
    public static function Autoevaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT A.iddocente, D.indicador1, D.indicador2, D.indicador3, D.indicador4, D.indicador5, D.total 
                              FROM tb_detalle_autoevaluacion D 
                              INNER JOIN tb_autoevaluacion A ON D.idautoevaluacion = A.idautoevaluacion 
                              WHERE A.iddocente = :iddocente");
      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosdocentes::class);
    }

    public static function Coevaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT C.iddocente, D.indicador1, D.indicador2, D.indicador3, D.indicador4, D.indicador5, D.total 
                              FROM tb_detalle_coevaluacion D 
                              INNER JOIN tb_coevaluacion C ON D.idcoevaluacion = C.idcoevaluacion
                              WHERE C.iddocente = :iddocente");

      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosdocentes::class);
    }

    public static function Heteroevaluacion($params)
    {
      $db = new DB();

      $prepare = $db->prepare("SELECT H.iddocente, AVG(D.indicador1) AS indicador1, AVG(D.indicador2) AS indicador2, avg(D.indicador3) 
                              AS indicador3, AVG(D.indicador4) AS indicador4, AVG(D.indicador5) AS indicador5, AVG(D.total) AS total
                              FROM tb_detalle_heteroevaluacion D 
                              INNER JOIN tb_heteroevaluacion H ON D.idheteroevaluacion = H.idheteroevaluacion
                              WHERE H.iddocente = :iddocente
                              GROUP BY H.iddocente");

      $prepare->execute($params);

      return $prepare->fetchAll(PDO::FETCH_CLASS, Resultadosdocentes::class);
    }

  }