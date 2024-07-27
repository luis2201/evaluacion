<?php

    header("Content-type: application/pdf");
    header("Content-Disposition: inline; filename=".$_GET['documento']);
    readfile('/var/www/evaluacion/docente/files/'.$_GET['documento'].'.pdf');

?>