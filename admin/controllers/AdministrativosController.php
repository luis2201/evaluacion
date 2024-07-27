<?php

    class AdministrativosController
    {
        public function index()
        {
            $administrativos = Administrativos::findAll();
            $areas = Area::findAll();

            view("administrativos.index", ["administrativos" => $administrativos, "areas" => $areas]);
        }

        public function findidentificacion()
        {
            $idadministrativo = Main::limpiar_cadena($_POST['idadministrativo']);
            $identificacion = Main::limpiar_cadena($_POST['identificacion']);
            
            $idadministrativo = Main::decryption($idadministrativo);

            $params = [":idadministrativo" => $idadministrativo, ":identificacion" => $identificacion];
            $resp = Administrativos::findIdentificacion($params);
            
            echo json_encode($resp);
        }

        public function findcorreo()
        {
            $idadministrativo = Main::limpiar_cadena($_POST['idadministrativo']);
            $correo = Main::limpiar_cadena($_POST['correo']);
            
            $idadministrativo = Main::decryption($idadministrativo);

            $params = [":idadministrativo" => $idadministrativo, ":correo" => $correo];
            $resp = Administrativos::findCorreo($params);

            echo json_encode($resp);
        }

        public function findid($idadministrativo)
        {
            $idadministrativo = Main::limpiar_cadena($idadministrativo);
            $idadministrativo = Main::decryption($idadministrativo);
            
            $params = [":idadministrativo" => $idadministrativo];
            $resp = Administrativos::findId($params);

            echo json_encode($resp);
        }

        public function save()
        {
            $idadministrativo = Main::limpiar_cadena($_POST['idadministrativo']);
            $tipoidentificacion = Main::limpiar_cadena($_POST['tipoidentificacion']);
            $identificacion = Main::limpiar_cadena($_POST['identificacion']);
            $nombres = Main::limpiar_cadena($_POST['nombres']);
            $apellidos = Main::limpiar_cadena($_POST['apellidos']);
            $correo = Main::limpiar_cadena($_POST['correo']);
            $idarea = Main::limpiar_cadena($_POST['idarea']);

            $idadministrativo = Main::decryption($idadministrativo);

            if($idadministrativo == 0){
                $contrasena =  Main::generate_string(10);
                
                $pass =  Main::encryption($contrasena);
                
                $params = [":tipoidentificacion" => $tipoidentificacion, ":identificacion" => $identificacion, ":nombres" => $nombres, ":apellidos" => $apellidos, ":correo" => $correo, ":idarea" => $idarea, ":contrasena" => $pass];
                $resp = Administrativos::Insert($params);

                if($resp){
                    $titulo = "Sistema de Evaluación ITSUP";
                    $mensaje = "<h4>¡Bienvenido al Sistema de Evaluación ITSUP!</h4>
                                <p>Puede acceder al sistema ingresando a evaluacion.itsup.edu.ec/administrativos. Sus credenciales de acceso son:</p>
                                <p><strong>Usuario: </strong>$identificacion<br>
                                <strong>Contraseña: </strong>$contrasena";
                    //Main::enviarCorreo($correo, $nombres.' '.$apellidos, $titulo, $mensaje);
                }
            } else{
                $params = [":idadministrativo" => $idadministrativo, ":tipoidentificacion" => $tipoidentificacion, ":identificacion" => $identificacion, ":nombres" => $nombres, ":apellidos" => $apellidos, ":correo" => $correo, ":idarea" => $idarea];
                $resp = Administrativos::Update($params);
            }
            

            echo json_encode($resp);
        }

        public function delete($idadministrativo)
        {
            $idadministrativo = Main::limpiar_cadena($idadministrativo);
            $idadministrativo = Main::decryption($idadministrativo);
            
            $params = [":idadministrativo" => $idadministrativo];
            $resp = Administrativos::Delete($params);

            echo json_encode($resp);
        }
        
    }

?>