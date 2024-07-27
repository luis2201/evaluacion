<?php

    class PortafolioController
    {
        public function index()
        {
            $criterios = Criterios::findAll();
            $documentos = Portafolio::selectIdDocente($_SESSION['iddocente_eval']);

            view("portafolio.index", ["criterios" => $criterios, "documentos" => $documentos]);
        }

        public function findcriterio()
        {
            $iddocente = Main::limpiar_cadena($_POST['iddocente']);
            $idcriterio = Main::limpiar_cadena($_POST['idcriterio']);

            $iddocente = Main::decryption($iddocente);
            $idcriterio = Main::decryption($idcriterio);

            $params = ["iddocente" => $iddocente, "idcriterio" => $idcriterio];
            $resp = Portafolio::findCriterio($params);

            echo json_encode($resp);
        }

        public function insert()
        {
            $iddocente = Main::limpiar_cadena($_POST['iddocente']);
            $idcriterio = Main::limpiar_cadena($_POST['idcriterio']);
            
            $file           = $_FILES['documento']['name'];
            $path           = DOC;
            $newnamedoc     = strtotime("now");
            $extension      = pathinfo($file, PATHINFO_EXTENSION);

            $iddocente = Main::decryption($iddocente);
            $idcriterio = Main::decryption($idcriterio);
            $documento      = $newnamedoc . '.' . $extension;      
            
            $res = move_uploaded_file($_FILES['documento']['tmp_name'], $path . $documento);

            if($res){
                $params = ["iddocente" => $iddocente, "idcriterio" => $idcriterio, "documento" => $documento];

                $resp = Portafolio::Insert($params);
            }

            echo json_encode($resp);
        }

        public function delete($idportafolio)
        {
            $idportafolio = Main::limpiar_cadena($idportafolio);
            $idportafolio = Main::decryption($idportafolio);
            $documento = "";

            $params = ["idportafolio" => $idportafolio];
            
            $resp = Portafolio::findDocumento($params);
            foreach($resp as $row){
                $documento = $row->documento;
            }

            $resp = Portafolio::Delete($params);
             
            if($resp){
                $resp = unlink($_SERVER['DOCUMENT_ROOT'].'docente/files/'.$documento);
            } 
            
            echo json_encode($resp);
        }
    }

?>