    <div class="container-fluid py-4">
      <div class="row">
        <div class="col-12">
          <div class="card card-frame">
            <div class="card-header bg-dark">
              <h5 class="text-white">Registro de evidencias según criterio de evaluación</h5>
            </div>
            <div class="card-body">
              <div class="row p-3">
                <form id="form" role="form" class="text-start" autocomplete="off">
                  <input type="hidden" id="iddocente" value="<?php echo Main::encryption($_SESSION['iddocente_eval']); ?>">
                  <div class="row">
                    <div class="input-group input-group-static mb-4">
                      <label for="idcriterio" class="ms-0">Criterio de Evaluación</label>
                      <select class="form-control" id="idcriterio" name="idcriterio">
                        <option value="">-- Seleccione un criterio de evaluación --</option>
                        <?php foreach($criterios as $row): ?>
                          <?php if($row->idcriterio!=9){ ?>
                          <option value="<?php echo Main::encryption($row->idcriterio); ?>"><?php echo $row->criterio; ?></option>
                          <?php } ?>
                        <?php endforeach; ?>
                      </select>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-10">
                      <div class="input-group input-group-static mb-4">
                        <input type="file" id="documento" name="documento" class="form-file" accept=".pdf">
                      </div>
                    </div>
                    <div class="col-2 text-end">
                      <button type="submit" class="btn btn-primary"><i class="material-icons opacity-10">upload</i> Agregar</button>
                    </div>
                  </div>
                </form>
              </div>
              <div class="row">
                <div class="table-responsive">
                  <table class="table table-hover table-condensed table-responsive">
                    <thead>
                      <tr class="text-center">
                        <th>Código</th>
                        <th class="w-100">Lista de Criterios</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody>
                    <?php foreach($documentos as $row): ?>
                      <tr>
                        <td class="text-center"><?php echo $row->idcriterio; ?></td>
                        <td><?php echo $row->criterio; ?></td>
                        <td>
                          <?php if($row->idcriterio!=9){ ?>
                            <a href="<?php echo DIR; ?>viewDocument.php?documento=<?php $doc = explode(".", $row->documento); echo $doc[0] ?>" class="btn btn-warning bt-sm" style="height: 30px;" target="_blank"><i class="material-icons opacity-10" style="height: 30px;">visibility</i></a>
                            <button type="button" id="<?php echo Main::encryption($row->idportafolio); ?>" class="btn btn-danger bt-sm" style="height: 30px;" onclick="eliminar(this.id);"><i class="material-icons opacity-10" style="height: 30px;">delete</i></button>
                          <?php } else{ ?>
                            <a href="silabos"><span class="badge bg-gradient-success">Visualiza Sílabos</span></a>
                          <?php } ?>
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
  <script src="<?php echo DIR; ?>functions/portafolio.js"></script>
  
  