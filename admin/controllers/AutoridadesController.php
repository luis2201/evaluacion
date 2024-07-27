<?php

    class AutoridadesController
    {
        public function index()
        {
            $autoridades = Autoridades::findAll();
            $areas = Area::findAll();

            view("autoridades.index", ["autoridades" => $autoridades, "areas" => $areas]);
        }

        public function findidentificacion()
        {
            $idautoridad = Main::limpiar_cadena($_POST['idautoridad']);
            $identificacion = Main::limpiar_cadena($_POST['identificacion']);
            
            $idautoridad = Main::decryption($idautoridad);

            $params = [":idautoridad" => $idautoridad, ":identificacion" => $identificacion];
            $resp = Autoridades::findIdentificacion($params);
            
            echo json_encode($resp);
        }

        public function findcorreo()
        {
            $idautoridad = Main::limpiar_cadena($_POST['idautoridad']);
            $correo = Main::limpiar_cadena($_POST['correo']);
            
            $idautoridad = Main::decryption($idautoridad);

            $params = [":idautoridad" => $idautoridad, ":correo" => $correo];
            $resp = Autoridades::findCorreo($params);

            echo json_encode($resp);
        }

        public function findid($idautoridad)
        {
            $idautoridad = Main::limpiar_cadena($idautoridad);
            $idautoridad = Main::decryption($idautoridad);
            
            $params = [":idautoridad" => $idautoridad];
            $resp = Autoridades::findId($params);

            echo json_encode($resp);
        }

        public function save()
        {
            $idautoridad = Main::limpiar_cadena($_POST['idautoridad']);
            $tipoidentificacion = Main::limpiar_cadena($_POST['tipoidentificacion']);
            $identificacion = Main::limpiar_cadena($_POST['identificacion']);
            $nombres = Main::limpiar_cadena($_POST['nombres']);
            $apellidos = Main::limpiar_cadena($_POST['apellidos']);
            $correo = Main::limpiar_cadena($_POST['correo']);
            $idarea = Main::limpiar_cadena($_POST['idarea']);

            $idautoridad = Main::decryption($idautoridad);

            if($idautoridad == 0){
                $contrasena =  Main::generate_string(10);
                
                $pass =  Main::encryption($contrasena);
                
                $params = [":tipoidentificacion" => $tipoidentificacion, ":identificacion" => $identificacion, ":nombres" => $nombres, ":apellidos" => $apellidos, ":correo" => $correo, ":idarea" => $idarea, ":contrasena" => $pass];
                $resp = Autoridades::Insert($params);

                if($resp){
                    $titulo = "Sistema de Evaluación ITSUP";
                    $mensaje = "<h4>¡Bienvenido al Sistema de Evaluación ITSUP!</h4>
                                <p>Puede acceder al sistema ingresando a evaluacion.itsup.edu.ec/autoridades. Sus credenciales de acceso son:</p>
                                <p><strong>Usuario: </strong>$identificacion<br>
                                <strong>Contraseña: </strong>$contrasena";
                    Main::enviarCorreo($correo, $nombres.' '.$apellidos, $titulo, $mensaje);
                }
            } else{
                $params = [":idautoridad" => $idautoridad, ":tipoidentificacion" => $tipoidentificacion, ":identificacion" => $identificacion, ":nombres" => $nombres, ":apellidos" => $apellidos, ":correo" => $correo, ":idarea" => $idarea];
                $resp = Autoridades::Update($params);
            }
            

            echo json_encode($resp);
        }

        public function delete($idautoridad)
        {
            $idautoridad = Main::limpiar_cadena($idautoridad);
            $idautoridad = Main::decryption($idautoridad);
            
            $params = [":idautoridad" => $idautoridad];
            $resp = Autoridades::Delete($params);

            echo json_encode($idautoridad);
        }
    }

?>