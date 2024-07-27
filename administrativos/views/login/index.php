<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../assets/img/favicon.png">
  <title>Evaluación | ITSUP</title>
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <!-- Nucleo Icons -->
  <link href="<?php echo DIR; ?>assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="<?php echo DIR; ?>assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- JQuery-Confirm CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
  <!-- CSS Files -->
  <link id="pagestyle" href="<?php echo DIR; ?>assets/css/material-dashboard.css?v=3.0.0" rel="stylesheet" />
</head>

<body class="bg-gray-200">
  <main class="main-content  mt-0">
    <div class="page-header align-items-start min-vh-100" style="background-image: url('https://images.pexels.com/photos/5186869/pexels-photo-5186869.jpeg');">
      <span class="mask bg-gradient-dark opacity-6"></span>
      <div class="container my-auto">
        <div class="row">
          <div class="col-lg-4 col-md-8 col-12 mx-auto">
            <div class="card z-index-0 fadeIn3 fadeInBottom">
              <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                <div class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
                  <h4 class="text-white font-weight-bolder text-center mt-2 mb-0">
                    <img src="assets/img/logo_itsup_2022.png" alt="logo-itsup" style="width: 100px;">
                    <img src="assets/img/logo_eco_itsup.png" alt="logo-itsup" style="width: 100px;">
                  </h4>
                </div>
              </div>
              <div class="card-body">
                <form id="form" role="form" class="text-start" autocomplete="off">
                  <div class="input-group input-group-outline my-3">
                    <label class="form-label">Usuario</label>
                    <input type="text" id="usuario" name="usuario" class="form-control">
                  </div>
                  <div class="input-group input-group-outline mb-3">
                    <label class="form-label">Contrasena</label>
                    <input type="password" id="contrasena" name="contrasena" class="form-control">
                  </div>
                  <div class="text-center">
                    <button type="submit" class="btn bg-gradient-primary w-100 my-4 mb-2">Ingresar</button>
                  </div>
                  <p class="mt-4 text-sm text-center">
                    Olvidaste tu contraseña?
                    <a href="#" class="text-primary text-gradient font-weight-bold">Recuperar</a>
                  </p>
                </form>
                <div id="RespuestaForm"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer position-absolute bottom-2 py-2 w-100">
        <div class="container">
          <div class="row align-items-center justify-content-lg-between">
            <div class="col-12 col-md-6 my-auto">
              <div class="copyright text-center text-sm text-white text-lg-start">
                © <script>
                  document.write(new Date().getFullYear())
                </script>,
                <a href="https://www.itsup.edu.ec" class="font-weight-bold text-white" target="_blank">ITSUP</a>
                Todos los derechos reservados.
              </div>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </main>
  <!--   Core JS Files   -->
  <script src="<?php echo DIR; ?>assets/js/core/popper.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/core/bootstrap.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
  <!-- JQuery -->
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="<?php echo DIR; ?>assets/js/material-dashboard.min.js?v=3.0.0"></script>
  <!-- Validate JS -->
  <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
  <!-- JQuery-Confirm -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
  <!-- Axios -->
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
  <!-- Site JS -->
  <script src="<?php echo DIR; ?>functions/global.js?v=1.0.0"></script>
  <script src="<?php echo DIR; ?>functions/login.js?v=1.0.1"></script>
</body>

</html>