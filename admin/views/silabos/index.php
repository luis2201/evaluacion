<div class="container-fluid py-4">
      <div class="row">
        <div class="col-12">
          <div class="card card-frame">
            <div class="card-header bg-dark">
              <h5 class="text-white">Evidencias subidas por los docentes según criterio de evaluación</h5>
            </div>
            <div class="card-body">
                <form id="form" autocomplete="off">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="input-group input-group-static mb-2">
                                <label for="iddocente" class="ms-0">Docente</label>
                                <select class="form-control" id="iddocente" name="iddocente">
                                    <option value="">-- Seleccione Docente --</option>
                                    <?php foreach($docentes as $row): ?>
                                    <option value="<?php echo Main::encryption($row->iddocente); ?>"><?php echo $row->apellidos.' '.$row->nombres; ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-group input-group-static mb-4">
                                <label for="idmateria" class="ms-0">Materia</label>
                                <select class="form-control" id="idmateria" name="idmateria">
                                    <option value="">-- Seleccione Materia --</option>
                                    <?php foreach($materias as $row): ?>
                                    <option value="<?php echo Main::encryption($row->idmateria); ?>"><?php echo $row->materia; ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group input-group-static mb-4">
                                <label for="idsemestre" class="ms-0">Semestre</label>
                                <select class="form-control" id="idsemestre" name="idsemestre">
                                    <option value="">-- Seleccione Semestre --</option>
                                    <option value="<?php echo Main::encryption(1); ?>">Primero</option>
                                    <option value="<?php echo Main::encryption(2); ?>">Segundo</option>
                                    <option value="<?php echo Main::encryption(3); ?>">Tercero</option>
                                    <option value="<?php echo Main::encryption(4); ?>">Cuarto</option>
                                    <option value="<?php echo Main::encryption(5); ?>">Quinto</option>
                                    <option value="<?php echo Main::encryption(6); ?>">Sexto</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="input-group input-group-static mb-4">
                                <label for="paralelo" class="ms-0">Paralelo</label>
                                <select class="form-control" id="paralelo" name="paralelo">
                                    <option value="">-- Seleccione Paralelo --</option>
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="input-group input-group-static mb-4">
                                <label for="jornada" class="ms-0">Jornada</label>
                                <select class="form-control" id="jornada" name="jornada">
                                    <option value="">-- Seleccione Jornada --</option>
                                    <option value="Matutino">Matutino</option>
                                    <option value="Vespertino">Vespertino</option>
                                    <option value="Nocturno">Nocturno</option>
                                    <option value="Vesp/Noct">Vesp/Noct</option>
                                    <option value="Intensivo">Intensivo</option>
                                    <option value="En Línea">En Línea</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="input-group input-group-static mb-4">
                                <button type="submit" class="btn btn-primary">Agregar Materia</button>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="row">
                    <div class="table-responsive">
                        <table id="tbLista" class="table table-hover table-condensed table-responsive">
                            <thead>
                                <tr class="text-center">
                                    <th>#</th>
                                    <th>MATERIA</th>
                                    <th>SEMESTRE</th>
                                    <th>PARALELO</th>
                                    <th>JORNADA</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
          </div>
        </div>
      </div>

      <footer class="footer py-4  ">
        <div class="container-fluid">
          <div class="row align-items-center justify-content-lg-between">
            <div class="col-lg-6 mb-lg-0 mb-4">
              <div class="copyright text-center text-sm text-muted text-lg-start">
                © <script>
                  document.write(new Date().getFullYear())
                </script>,
                <a href="https://www.itsup.edu.ec" class="font-weight-bold" target="_blank">ITSUP</a>
                Todos los derechos reservados.
              </div>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </main>
  <!-- JQuery -->
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <!--   Core JS Files   -->
  <script src="<?php echo DIR; ?>assets/js/core/popper.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/core/bootstrap.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script src="<?php echo DIR; ?>assets/js/plugins/chartjs.min.js"></script>
  <!-- Validate JS -->
  <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
  <!-- JQuery-Confirm -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
  <!-- Axios -->
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
  <!-- Site JS -->
  <script src="<?php echo DIR; ?>functions/silabos.js"></script>
  
  