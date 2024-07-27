<div class="container-fluid py-4">
      <div class="row">
        <div class="col-12">
          <div class="card card-frame">
            <div class="card-header bg-dark">
              <h5 class="text-white">Registro de Sílabos de las Asignaturas</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <table class="table table-hover table-striped" style="font-size:12px;">
                        <thead>
                            <tr>
                              <th class="text-center">#</th>
                              <th class="text-center">Semestre</th>
                              <th class="text-center">Paralelo</th>
                              <th class="text-center">Jornada</th>
                              <th class="text-center">Materia</th>
                              <th class="text-center">Archivo</th>
                              <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php 
                          foreach($silabos as $row):
                            $i++; 
                        ?>
                            <form class="form" enctype="multipart/form-data" autocomplete="off">
                                <input type="hidden" id="idsilabo" name="idsilabo" value="<?php echo Main::encryption($row->idsilabo); ?>">
                                <input type="hidden" id="iddocente" name="iddocente" value="<?php echo Main::encryption($_SESSION['iddocente_eval']); ?>">
                                <?php 
                                    switch ($row->idsemestre) {
                                        case 1:
                                            $semestre = 'Primero';
                                            break;
                                        
                                        case 2:
                                            $semestre = 'Segundo';
                                            break;

                                        case 3:
                                            $semestre = 'Tercero';
                                            break;

                                        case 4:
                                            $semestre = 'Cuarto';
                                            break;

                                        case 5:
                                            $semestre = 'Quinto';
                                            break;

                                        case 6:
                                            $semestre = 'Sexto';
                                            break;
                                    }
                                ?>
                                <tr>
                                    <td class="text-center"><?php echo $i; ?></td>
                                    <td class="text-center"><?php echo $semestre; ?></td>
                                    <td class="text-center"><?php echo $row->paralelo; ?></td>
                                    <td class="text-center"><?php echo $row->jornada; ?></td>
                                    <td><?php echo $row->materia; ?></td>
                                    <?php if($row->estado == 0){ ?>
                                    <td>
                                        <input type="file" id="silabo" name="silabo" class="form-file btn" accept=".pdf" required>
                                    </td>
                                    <td class="text-center">
                                        <button type="submit" class="btn btn-primary"><i class="material-icons opacity-10">upload</i></button>
                                    </td>
                                    <?php } else{ ?>
                                        <td class="text-center">
                                          <a href="<?php echo DIR; ?>viewDocument.php?documento=<?php $doc = explode(".", $row->silabo); echo $doc[0] ?>" class="btn btn-warning bt-sm" style="height: 30px;" target="_blank"><i class="material-icons opacity-10" style="height: 30px;">visibility</i></a>
                                        </td>
                                        <td class="text-center"><span class="badge bg-gradient-success">Subido</span></td>
                                    <?php } ?>
                                </tr>
                            </form>
                        <?php endforeach; ?>
                        </tbody>
                    </table>
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
  
  