<?php

  class LogoutController
  {
    
    public function index()
    {
      session_destroy();
      session_unset();

      view('login.index', []);
    }

  }
  

?>