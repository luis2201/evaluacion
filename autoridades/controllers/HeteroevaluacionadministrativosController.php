<?php

    class HeteroevaluacionadministrativosController
    {
        public function index()
        {  
            $heteroevaluaciones = Heteroevaluacionadministrativos::SelectAutoridadAdministrativos([":idautoridad" => $_SESSION['idautoridad_eval']]);

            view("heteroevaluacionadministrativos.index", ["heteroevaluaciones" => $heteroevaluaciones]);
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
            $indicador6 = Main::limpiar_cadena($data->indicador6);
            $indicador7 = Main::limpiar_cadena($data->indicador7);
            $indicador8 = Main::limpiar_cadena($data->indicador8);
            $indicador9 = Main::limpiar_cadena($data->indicador9);
            $indicador10 = Main::limpiar_cadena($data->indicador10);
            $total = Main::limpiar_cadena($data->total);

            $idheteroevaluacion = Main::decryption($idheteroevaluacion);

            $params = [":idheteroevaluacion" => $idheteroevaluacion, ":indicador1" => $indicador1, ":indicador2" => $indicador2, ":indicador3" => $indicador3, ":indicador4" => $indicador4, ":indicador5" => $indicador5, ":indicador6" => $indicador6, ":indicador7" => $indicador7, ":indicador8" => $indicador8, ":indicador9" => $indicador9, ":indicador10" => $indicador10, ":total" => $total];
            $resp = Heteroevaluacionadministrativos::Insert($params);
          
            echo json_encode($resp);
        }

        public function findheteroevaluacionadministrativo($idheteroevaluacion)
        {
            $idheteroevaluacion = Main::limpiar_cadena($idheteroevaluacion);
            $idheteroevaluacion = Main::decryption($idheteroevaluacion);
            
            $params = [":idheteroevaluacion" => $idheteroevaluacion];
            $resp = Heteroevaluacionadministrativos::findHeteroevaluacionAdministrativo($params);

            echo json_encode($resp);
        }

    }

?>