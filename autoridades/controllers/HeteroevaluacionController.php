<?php

    class HeteroevaluacionController
    {
        public function index()
        {  
            $heteroevaluaciones = Heteroevaluacion::SelectAutoridadDocente([":idautoridad" => $_SESSION['idautoridad_eval']]);

            view("heteroevaluacion.index", ["heteroevaluaciones" => $heteroevaluaciones]);
        }

        public function insertar()
        {
            $data = json_decode(file_get_contents('php://input'));

            $idheteroevaluacion = Main::limpiar_cadena($data->idheteroevaluacion);
            $indicador1 = Main::limpiar_cadena($data->indicador1);
            $indicador2 = Main::limpiar_cadena($data->indicador2);
            $indicador3 = Main::limpiar_cadena($data->indicador3);
            $indicador4 = Main::limpiar_cadena($data->indicador4);
            $indicador5 = Main::limpiar_cadena($data->indicador5);
            $total = Main::limpiar_cadena($data->total);

            $idheteroevaluacion = Main::decryption($idheteroevaluacion);

            $params = [":idheteroevaluacion" => $idheteroevaluacion, ":indicador1" => $indicador1, ":indicador2" => $indicador2, ":indicador3" => $indicador3, ":indicador4" => $indicador4, ":indicador5" => $indicador5, ":total" => $total];
            $resp = Heteroevaluacion::Insert($params);
          
            echo json_encode($resp);
        }

        public function findheteroevaluaciondocente($idheteroevaluacion)
        {
            $idheteroevaluacion = Main::limpiar_cadena($idheteroevaluacion);
            $idheteroevaluacion = Main::decryption($idheteroevaluacion);
            
            $params = [":idheteroevaluacion" => $idheteroevaluacion];
            $resp = Heteroevaluacion::findHeteroevaluacionDocente($params);

            echo json_encode($resp);
        }

    }

?>