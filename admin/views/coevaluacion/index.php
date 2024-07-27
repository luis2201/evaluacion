    <div class="container-fluid py-4">
      <div class="row">
        <div class="col-12">
          <div class="card card-frame">
            <div class="card-header bg-dark">
              <h5 class="text-white">Registro de Docente Evaluador</h5>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-10">
                    <div class="input-group input-group-static mb-4">
                    <label for="idevaluador" class="ms-0">Inmediato Superior</label>
                    <select class="form-control" id="idevaluador" name="idevaluador">
                        <option value="">-- Seleccione Docente Evaluador --</option>
                        <?php foreach($docentes as $row): ?>
                        <option value="<?php echo Main::encryption($row->iddocente); ?>"><?php echo $row->apellidos.' '.$row->nombres; ?></option>
                        <?php endforeach; ?>
                    </select>
                    </div>
                </div>
                <div class="col-2">
                    <button class="btn btn-primary" onclick="lista()">Agregar Docente</button>
                </div>
              </div>
              <div class="row">
                <div class="table-responsive">
                  <table id="tbLista" class="table table-hover table-condensed table-responsive">
                    <thead>
                      <tr class="text-center">
                        <th class="w-100">NÓMINA DE DOCENTES A EVALUAR</th>
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
      
      <div class="modal fade" id="docenteModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="docenteModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title font-weight-normal" id="docenteModalLabel">Agregar Docente</h5>
                        <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table id="tbListaDocente" class="table table-striped table-hover table-condensed table-responsive table-bordered">
                            <thead>
                                <tr class="text-center">
                                    <th class="w-100">NÓMINA DE DOCENTES A EVALUAR</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach($docentes as $row): ?>
                                    <tr>
                                        <td><?php echo $row->apellidos.' '.$row->nombres; ?></td>
                                        <td><a id="<?php echo Main::encryption($row->iddocente); ?>" href="javascript:;" onclick="agregar(this.id);"><span class="material-icons-round text-info">add_circle</span></a></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Cerrar</button>
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
  <script src="<?php echo DIR; ?>functions/coevaluacion.js"></script>
  
  