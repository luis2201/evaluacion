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

            $param = [":usuario" => $usuario, ":contrasena" => $contrasena];
            $resp = Login::Validate($param);

            if (!empty($resp)) {
                foreach($resp as $row){
                    $_SESSION['idestudiante_eval'] = $row->idestudiante;
                    $_SESSION['cedula_eval'] = $row->cedula;
                    $_SESSION['estudiante_eval'] = $row->nombres;
                    $_SESSION['tipousuario_eval'] = 'ESTUDIANTE';
                }
            } 

            echo json_encode($resp);
        }
    }

?>