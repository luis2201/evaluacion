<?php 

    class Login extends DB
    {
        public static function Validate($param)
        {
            $db = new DB();

            $prepare = $db->prepare("call sp_login_estudiante_validate(:usuario, :contrasena)");
            $prepare->execute($param);

            return $prepare->fetchAll(PDO::FETCH_CLASS, Login::class);
        }
    }

?>