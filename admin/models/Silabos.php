<?php 

    class Silabos extends DB
    {
        public function FindDocenteIdMateria($params)
        {   
            $db = new DB();

            $prepare = $db->prepare("call sp_silabos_select_iddocente_materia(:iddocente, :idsemestre, :paralelo, :jornada, :idmateria);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Silabos::class);
        }

        public function Insert($params)
        {   
            $db = new DB();

            $prepare = $db->prepare("call sp_silabos_insert(:iddocente, :idsemestre, :paralelo, :jornada, :idmateria);");
            
            return $prepare->execute($params);
        }

        public static function FindIdDocente($params)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_silabos_select_iddocente(:iddocente);");
            $prepare->execute($params);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Silabos::class);
        }

        public function Delete($params)
        {   
            $db = new DB();

            $prepare = $db->prepare("call sp_silabos_delete(:idsilabo);");
            
            return $prepare->execute($params);
        }
    }