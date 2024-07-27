  <aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3   bg-gradient-dark" id="sidenav-main">
    <div class="sidenav-header">
      <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
      <a class="navbar-brand m-0" href="dashboard">
        <img src="<?php echo DIR; ?>assets/img/logo-ct.png" class="navbar-brand-img h-100" alt="main_logo">
        <span class="ms-1 font-weight-bold text-white">Evaluación</span>
      </a>
    </div>
    <hr class="horizontal light mt-0 mb-2">
    <div class="collapse navbar-collapse  w-auto max-height-vh-100" id="sidenav-collapse-main">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a id="mndashboard" class="nav-link text-white" href="dashboard">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="material-icons opacity-10">dashboard</i>
            </div>
            <span class="nav-link-text ms-1">Dashboard</span>
          </a>
        </li>
        <li class="nav-item">
          <a id="mnheteroevaluacion" class="nav-link text-white" href="heteroevaluacion">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="material-icons opacity-10">school</i>
            </div>
            <span class="nav-link-text ms-1">Evaluación Docentes</span>
          </a>
        </li>
        <li class="nav-item">
          <a id="mnadministrativos" class="nav-link text-white" href="administrativos">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="material-icons opacity-10">badge</i>
            </div>
            <span class="nav-link-text ms-1">Evaluación Administrativos</span>
          </a>
        </li>
        <li class="nav-item">
          <a id="mnsatisfaccionusuario" class="nav-link text-white" href="satisfaccionusuario">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="material-icons opacity-10">verified_user</i>
            </div>
            <span class="nav-link-text ms-1">Satisfacción del Usuario</span>
          </a>
        </li>
      </ul>
    </div>
    <div class="sidenav-footer position-absolute w-100 bottom-0 ">
      <div class="mx-3">
        <a class="btn bg-gradient-primary mt-4 w-100" href="logout" type="button">Cerrar Sesión</a>
      </div>
    </div>
  </aside>