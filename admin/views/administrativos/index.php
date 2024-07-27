<div class="container-fluid py-4">
      <div class="row">
        <div class="col-12">
          <div class="card card-frame">
            <div class="card-header bg-dark">
                <h5 class="text-white float-start">Personal Administrativo registrado en el Sistema</h5>
                <!-- Button trigger modal -->
                <button type="button" class="btn bg-gradient-primary float-end" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Agregar Administrativo
                </button>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="table-responsive">
                  <table id="tbLista" class="table table-hover table-condensed table-responsive" style="font-size:12px">
                    <thead>
                      <tr>
                        <th class="text-center">NÚMERO ID</th>
                        <th class="text-center">TIPO ID</th>
                        <th class="text-center">APELLIDOS</th>
                        <th class="text-center">NOMBRES</th>
                        <th class="text-center">CORREO</th>
                        <th class="text-center">CONTRASEÑA</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody>
                    <?php foreach($administrativos as $row): ?>
                      <tr>
                        <td class="text-center"><?php echo $row->identificacion; ?></td>
                        <td class="text-center"><?php echo ($row->tipoidentificacion==1)?'Cédula':'Pasaporte'; ?></td>
                        <td><?php echo $row->apellidos; ?></td>
                        <td><?php echo $row->nombres; ?></td>
                        <td><?php echo $row->correo; ?></td>
                        <td class="text-center"><?php echo Main::decryption($row->contrasena); ?></td>
                        <td class="text-center">
                            <a href="javascript:;" id="<?php echo Main::encryption($row->idadministrativo); ?>" onclick="modificar(this.id)" data-bs-toggle="modal" data-bs-target="#exampleModal"><span class="material-icons-round text-warning" title="Modificar">border_color</span>
                            <!-- <a href="javascript:;" id="<?php echo Main::encryption($row->idadministrativo); ?>" onclick="eliminar(this.id)"><span class="material-icons-round text-danger" title="Eliminar">delete</span> -->
                        </td>
                      </tr>
                    <?php endforeach; ?>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <form id="form" autocomplete="off">
                      <input type="hidden" id="idadministrativo" name="idadministrativo" value="<?php echo Main::encryption(0); ?>">
                        <div class="modal-header">
                            <h5 class="modal-title font-weight-normal" id="exampleModalLabel">Agregar Administrativo</h5>
                            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close" onclick="window.location.reload()">
                            <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group input-group-static mb-2">
                                <label for="tipoidentificacion" class="ms-0">Tipo de Identificación</label>
                                <select class="form-control" id="tipoidentificacion" name="tipoidentificacion">
                                <option value="1">Cédula</option>
                                <option value="2">Pasaporte</option>
                                </select>
                            </div>
                            <div class="input-group input-group-static mb-2">
                                <label>Número de Identificación</label>
                                <input type="text" id="identificacion" name="identificacion" class="form-control">
                            </div>
                            <div class="input-group input-group-static mb-2">
                                <label>Nombres</label>
                                <input type="text" id="nombres" name="nombres" class="form-control">
                            </div>
                            <div class="input-group input-group-static mb-2">
                                <label>Apellidos</label>
                                <input type="text" id="apellidos" name="apellidos" class="form-control">
                            </div>
                            <div class="input-group input-group-static mb-2">
                                <label>Email</label>
                                <input type="email" id="correo" name="correo" class="form-control">
                            </div>
                            <div class="input-group input-group-static mb-2">
                                <label for="idarea" class="ms-0">Área</label>
                                <select class="form-control" id="idarea" name="idarea">
                                  <?php 
                                    foreach($areas as $row):
                                      if($row->area == 'Administrativo'){
                                  ?>
                                    <option value="<?php echo $row->idarea; ?>"><?php echo $row->area; ?></option>
                                  <?php
                                      }
                                    endforeach;
                                  ?>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn bg-gradient-secondary" onclick="window.location.reload()" data-bs-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn bg-gradient-primary">Guardar</button>
                        </div>
                    </form>
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
  <!-- DataTables JS -->
  <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/dataTables.buttons.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.bootstrap5.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.html5.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.print.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.colVis.min.js"></script>
  <script src="https://cdn.datatables.net/plug-ins/1.12.1/i18n/es-ES.json"></script>
  <!-- Site JS -->
  <script src="<?php echo DIR; ?>functions/global.js?v=1.0.0"></script>
  <script src="<?php echo DIR; ?>functions/administrativos.js?v=1.0.4"></script>
  
  