<?php

    class LoginController
    {
        public function index()
        {
            view("login.index", []);
        }

        public function validate()
        {
            $data = json_decode(file_get_contents('php://input'));

            $usuario = Main::limpiar_cadena($data->usuario);
            $contrasena = Main::limpiar_cadena($data->contrasena);
            
            $contrasena = Main::encryption($contrasena);

            $param = [":usuario" => $usuario, ":contrasena" => $contrasena];
            $resp = Login::Validate($param);

            if (!empty($resp)) {
                foreach($resp as $row){
                    $_SESSION['idautoridad_eval'] = $row->idautoridad;
                    $_SESSION['identificacion_eval'] = $row->identificacion;
                    $_SESSION['autoridad_eval'] = $row->nombres.' '.$row->apellidos;
                    $_SESSION['tipousuario_eval'] = 'AUTORIDAD';
                }
            } 

            echo json_encode($resp);
        }
    }

?>