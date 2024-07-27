<?php

  use PHPMailer\PHPMailer\PHPMailer;
  use PHPMailer\PHPMailer\Exception;

  require 'PHPMailer/src/Exception.php';
  require 'PHPMailer/src/PHPMailer.php';
  require 'PHPMailer/src/SMTP.php';
  require_once './config/site.php';

  class Main
  {
    static function limpiar_cadena($string)
    {
      $string = trim($string);
      $string = stripslashes($string);
      $string = str_ireplace("<script>", "", $string);
      $string = str_ireplace("</script>", "", $string);
      $string = str_ireplace("<script type=", "", $string);
      $string = str_ireplace("SELECT * FROM", "", $string);
      $string = str_ireplace("DELETE FROM", "", $string);
      $string = str_ireplace("INSERT INTO", "", $string);
      $string = str_ireplace("--", "", $string);
      $string = str_ireplace("^", "", $string);
      $string = str_ireplace("[", "", $string);
      $string = str_ireplace("]", "", $string);
      $string = str_ireplace("==", "", $string);
      $string = str_ireplace(";", "", $string);

      return $string;
    }

    static function encryption($string)
    {
      $output = FALSE;
      $key = hash('sha256', SECRET_KEY);
      $iv = substr(hash('sha256', SECRET_IV), 0, 16);
      $output = openssl_encrypt($string, METHOD, $key, 0, $iv);
      $output = base64_encode($output);

      return $output;
    }

    static function decryption($string)
    {
      $key = hash('sha256', SECRET_KEY);
      $iv = substr(hash('sha256', SECRET_IV), 0, 16);
      $output = openssl_decrypt(base64_decode($string), METHOD, $key, 0, $iv);

      return $output;
    }

    static function generate_string($strength = 16) 
    {
      $permitted_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
      $input_length = strlen($permitted_chars);
      $random_string = '';
      for($i = 0; $i < $strength; $i++) {
          $random_character = $permitted_chars[mt_rand(0, $input_length - 1)];
          $random_string .= $random_character;
      }
  
      return $random_string;
    }

    public function enviarCorreo($email, $destinatario, $titulo, $mensaje)
    {

      $mail = new PHPMailer(true);

      try {
         //Server settings
         //$mail->SMTPDebug = 2; 
         //$mail->SMTPDebug = SMTP::DEBUG_SERVER;                    //Enable verbose debug output
         $mail->isSMTP();                                            //Send using SMTP
         $mail->Host       = 'mail.itsup.edu.ec';                    //Set the SMTP server to send through
         $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
         $mail->Username   = 'evaluacion@itsup.edu.ec';              //SMTP username
         $mail->Password   = 'evaluacion123';                        //SMTP password
         $mail->SMTPSecure = 'tls';                                  //Enable implicit TLS encryption
         $mail->Port       = 25;                                     //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

         //Recipients
         $mail->setFrom('evaluacion@itsup.edu.ec', 'Evaluación ITSUP');
         $mail->addAddress($email, $destinatario);     //Add a recipient
         
         //Content
         $mail->isHTML(true); 
         $mail->CharSet = 'UTF-8';                                 //Set email format to HTML
         $mail->Subject = $titulo;
         $mail->Body    = $mensaje;
         $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

         $mail->send();
      } catch (Exception $e) {
         echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
      }
    }

  }

?>