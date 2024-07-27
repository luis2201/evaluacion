<?php 

    class SilabosController
    {
        public function index()
        {
            $iddocente = $_SESSION['iddocente_eval'];
            $silabos = Silabos::findAllIdDocente([":iddocente" => $iddocente]);
        
            view("silabos.index", ["silabos" => $silabos]);
        }

        public function upload()
        {
            $idsilabo = Main::limpiar_cadena($_POST["idsilabo"]);
            $idsilabo = Main::decryption($idsilabo);
            $file = $_FILES['silabo']['name'];

            $path           = DOC;
            $newnamedoc     = strtotime("now");
            $extension      = pathinfo($file, PATHINFO_EXTENSION);

            $iddocente = Main::decryption($iddocente);
            $idcriterio = Main::decryption($idcriterio);
            $silabo = $newnamedoc . '.' . $extension;      
            
            $resp = move_uploaded_file($_FILES['silabo']['tmp_name'], $path . $silabo);

            if($resp){
                $params = [":idsilabo" => $idsilabo, ":silabo" => $silabo];
                $resp = Silabos::Upload($params);
            }

            $iddocente = $_SESSION['iddocente_eval'];
            $silabos = Silabos::findAllIdDocente([":iddocente" => $iddocente]);
            $i = 0;
            $c = 0;
            foreach($silabos as $row){
                $i++;
                if($row->estado == 1){
                    $c++;
                }
            }

            $portafolio = false; 

            if($c == $i){
                $idcriterio = 9; 
                $documento = "";
                $params = [":iddocente" => $iddocente, ":idcriterio" => $idcriterio, ":documento" => $documento];
                $portafolio = Portafolio::Insert($params);
            }

            echo json_encode($resp);
        }
    }

?>