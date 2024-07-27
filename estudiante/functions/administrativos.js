//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Heteroevaluación";
document.getElementById("titulo-principal").innerText = "Evaluación Estudiante - Administrativos";

//Class for default site
var mndashboard = document.getElementById('mnadministrativos');
mndashboard.classList.add("active", "bg-gradient-primary");

var idestudiante = document.getElementById("idestudiante").value;
var optcal1 = 0;
var optcal2 = 0;
var optcal3 = 0;
var optcal4 = 0;
var optcal5 = 0;

document.addEventListener('input', (e) => {

  let opcion = e.target.getAttribute('name');

  switch (opcion) {
    case "cal1":
      optcal1 = e.target.value;
      evaluar(idestudiante, e.target.id, optcal1);
      break;

    case "cal2":
      optcal2 = e.target.value;
      evaluar(idestudiante, e.target.id, optcal2);
      break;

    case "cal3":
      optcal3 = e.target.value;
      evaluar(idestudiante, e.target.id, optcal3);
      break;

    case "cal4":
      optcal4 = e.target.value;
      evaluar(idestudiante, e.target.id, optcal4);
      break;

    case "cal5":
      optcal5 = e.target.value;
      evaluar(idestudiante, e.target.id, optcal5);
      break;
  }

});

function evaluar(idestudiante, idadministrativo, calificacion) {
  $.confirm({
    title: 'Alerta del Sistema',
    icon: 'fa fa-question',
    content: 'Desea registrar la calificación?',
    type: 'blue',
    theme: 'modern',
    buttons: {
      continuar: async function () {
        await axios.post('https://evaluacion.itsup.edu.ec/estudiante/administrativos/insert/', {
          idestudiante,
          idadministrativo,
          calificacion
        })
        .then(function (res) {          
          $.alert({
            title: 'Alerta del Sistema',
            icon: 'fa fa-thumbs-o-up',
            content: 'Calificación registrada de forma satisfactoria.',
            type: 'blue',
            theme: 'modern',
            buttons: {
              aceptar: function () {
                window.location.reload();
              }
            }
          });
        })
        .catch(function (error) {
          $.alert({
            title: error.code,
            icon: 'fas fa-exclamation-circle',
            content: error.message,
            type: 'red',
            theme: 'modern',
            buttons: {
              aceptar: function () {

              }
            }
          });
        })
      },
      cancelar: function () {

      }
    }
  });
}
