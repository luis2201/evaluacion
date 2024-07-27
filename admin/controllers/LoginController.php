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
                    $_SESSION['usuario_eval'] = $row->usuario;
                    $_SESSION['nombres_eval'] = $row->nombres;
                    $_SESSION['tipousuario_eval'] = 'ADMINISTRADOR';
                }
            } 

            echo json_encode($contrasena);
        }
    }

?>