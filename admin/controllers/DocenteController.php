<?php

    class DocenteController
    {
        public function index()
        {
            $docentes = Docente::findAll();
            $areas = Area::findAll();

            view("docente.index", ["docentes" => $docentes, "areas" => $areas]);
        }

        public function findidentificacion()
        {
            $iddocente = Main::limpiar_cadena($_POST['iddocente']);
            $identificacion = Main::limpiar_cadena($_POST['identificacion']);
            
            $iddocente = Main::decryption($iddocente);

            $params = [":iddocente" => $iddocente, ":identificacion" => $identificacion];
            $resp = Docente::findIdentificacion($params);
            
            echo json_encode($resp);
        }

        public function findcorreo()
        {
            $iddocente = Main::limpiar_cadena($_POST['iddocente']);
            $correo = Main::limpiar_cadena($_POST['correo']);
            
            $iddocente = Main::decryption($iddocente);

            $params = [":iddocente" => $iddocente, ":correo" => $correo];
            $resp = Docente::findCorreo($params);

            echo json_encode($resp);
        }

        public function findid($iddocente)
        {
            $iddocente = Main::limpiar_cadena($iddocente);
            $iddocente = Main::decryption($iddocente);
            
            $params = [":iddocente" => $iddocente];
            $resp = Docente::findId($params);

            echo json_encode($resp);
        }

        public function save()
        {
            $iddocente = Main::limpiar_cadena($_POST['iddocente']);
            $tipoidentificacion = Main::limpiar_cadena($_POST['tipoidentificacion']);
            $identificacion = Main::limpiar_cadena($_POST['identificacion']);
            $nombres = Main::limpiar_cadena($_POST['nombres']);
            $apellidos = Main::limpiar_cadena($_POST['apellidos']);
            $correo = Main::limpiar_cadena($_POST['correo']);
            $idarea = Main::limpiar_cadena($_POST['idarea']);

            $iddocente = Main::decryption($iddocente);

            if($iddocente == 0){
                $contrasena =  Main::generate_string(10);
                
                $pass =  Main::encryption($contrasena);
                
                $params = [":tipoidentificacion" => $tipoidentificacion, ":identificacion" => $identificacion, ":nombres" => $nombres, ":apellidos" => $apellidos, ":correo" => $correo, ":idarea" => $idarea, ":contrasena" => $pass];
                $resp = Docente::Insert($params);

                if($resp){
                    $titulo = "Sistema de Evaluación ITSUP";
                    $mensaje = "<h4>¡Bienvenido al Sistema de Evaluación ITSUP!</h4>
                                <p>Puede acceder al sistema ingresando a evaluacion.itsup.edu.ec/docente. Sus credenciales de acceso son:</p>
                                <p><strong>Usuario: </strong>$identificacion<br>
                                <strong>Contraseña: </strong>$contrasena";
                    Main::enviarCorreo($correo, $nombres.' '.$apellidos, $titulo, $mensaje);
                }
            } else{
                $params = [":iddocente" => $iddocente, ":tipoidentificacion" => $tipoidentificacion, ":identificacion" => $identificacion, ":nombres" => $nombres, ":apellidos" => $apellidos, ":correo" => $correo, ":idarea" => $idarea];
                $resp = Docente::Update($params);
            }
            

            echo json_encode($resp);
        }

        public function delete($iddocente)
        {
            $iddocente = Main::limpiar_cadena($iddocente);
            $iddocente = Main::decryption($iddocente);
            
            $params = [":iddocente" => $iddocente];
            $resp = Docente::Delete($params);

            echo json_encode($iddocente);
        }
        
    }

?>