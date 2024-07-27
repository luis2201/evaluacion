//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Heteroevaluación";
document.getElementById("titulo-principal").innerText = "Evaluación Administrativo Inmediato Superior";

//Class for default site
var mndashboard = document.getElementById('mnheteroevaluacionadministrativos');
mndashboard.classList.add("active", "bg-gradient-primary");

var myModal = new bootstrap.Modal(document.getElementById('heteroevaluacionModal'), {
    keyboard: false
});

async function evaluar(idheteroevaluacion)
{
    await axios.get('https://evaluacion.itsup.edu.ec/autoridades/heteroevaluacionadministrativos/findheteroevaluacionadministrativo/' + idheteroevaluacion)
    .then(function (res){
       let info = res.data[0];
       document.getElementById("administrativo").innerHTML = "<strong>Administrativo: "+info.apellidos+" "+info.nombres+"</strong>";
    });

    document.getElementById("idheteroevaluacion").value = idheteroevaluacion;
    myModal.show();
}

var optIndicador1 = 0;
var optIndicador2 = 0;
var optIndicador3 = 0;
var optIndicador4 = 0;
var optIndicador5 = 0;
var optIndicador6 = 0;
var optIndicador7 = 0;
var optIndicador8 = 0;
var optIndicador9 = 0;
var optIndicador10 = 0;
var suma = 0;

document.addEventListener('input', (e) => {
    let opcion = e.target.getAttribute('name');
    
    switch (opcion) {
        case "indicador1":
          optIndicador1 = e.target.value; 
          document.getElementById("totalindicador1").value = e.target.value; 
          break;
        
        case "indicador2":
          optIndicador2 = e.target.value; 
          document.getElementById("totalindicador2").value = e.target.value; 
          break;

        case "indicador3":
          optIndicador3 = e.target.value; 
          document.getElementById("totalindicador3").value = e.target.value; 
          break;

        case "indicador4":
          optIndicador4 = e.target.value; 
          document.getElementById("totalindicador4").value = e.target.value; 
          break;

        case "indicador5":
          optIndicador5 = e.target.value; 
          document.getElementById("totalindicador5").value = e.target.value; 
          break;

        case "indicador6":
            optIndicador6 = e.target.value; 
            document.getElementById("totalindicador6").value = e.target.value; 
            break;
        
        case "indicador7":
            optIndicador7 = e.target.value; 
            document.getElementById("totalindicador7").value = e.target.value; 
            break;

        case "indicador8":
            optIndicador8 = e.target.value; 
            document.getElementById("totalindicador8").value = e.target.value; 
            break;

        case "indicador9":
            optIndicador9 = e.target.value; 
            document.getElementById("totalindicador9").value = e.target.value; 
            break;

        case "indicador10":
            optIndicador10 = e.target.value; 
            document.getElementById("totalindicador10").value = e.target.value; 
            break;
    }


    document.getElementById("total").value = (parseInt(optIndicador1) + parseInt(optIndicador2) + parseInt(optIndicador3) + parseInt(optIndicador4) + parseInt(optIndicador5) + parseInt(optIndicador6) + parseInt(optIndicador7) + parseInt(optIndicador8) + parseInt(optIndicador9) + parseInt(optIndicador10))/2;
});

function finalizar()
{
    if(!validate()){
        $.alert({
			title: 'Alerta del Sistema',
			icon: 'fas fa-exclamation-circle',
			content: 'Debe completar la evaluación para poder guardar el puntaje',
			type: 'orange',
			theme: 'modern',
			buttons: {
				aceptar: function () {
					
				}
			}
		});

        return;
    }

    $.confirm({
		title: 'Alerta del Sistema',
		icon: 'fa fa-thumbs-o-up',
		content: 'Desea finalizar el proceso y registrar la calificación del Docente?',
		type: 'blue',
		theme: 'modern',
		buttons: {
			continuar: async function () {
                let idheteroevaluacion = document.getElementById("idheteroevaluacion").value;
                let indicador2 = document.getElementById("totalindicador2").value;
                let indicador1 = document.getElementById("totalindicador1").value;
                let indicador3 = document.getElementById("totalindicador3").value;
                let indicador4 = document.getElementById("totalindicador4").value;
                let indicador5 = document.getElementById("totalindicador5").value;
                let indicador6 = document.getElementById("totalindicador6").value;
                let indicador7 = document.getElementById("totalindicador7").value;
                let indicador8 = document.getElementById("totalindicador8").value;
                let indicador9 = document.getElementById("totalindicador9").value;
                let indicador10 = document.getElementById("totalindicador10").value;
                let total = document.getElementById("total").value;

				await axios.post('https://evaluacion.itsup.edu.ec/autoridades/heteroevaluacionadministrativos/insertar/', {
                    idheteroevaluacion,
                    indicador1,
                    indicador2,
                    indicador3,
                    indicador4,
                    indicador5,
                    indicador6,
                    indicador7,
                    indicador8,
                    indicador9,
                    indicador10,
                    total
                })
				.then(function (res) {
                    $.alert({
                        title: 'Alerta del Sistema',
                        icon: 'fa fa-thumbs-o-up',
                        content: 'Proceso finalizado de forma satisfactoriamente.',
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
			cancelar: function() {
				
			}
		}
	});
}

function validate()
{
    var flag = true; 

    if(document.getElementById("totalindicador1").value == ""){
        flag = false;    
    }

    if(document.getElementById("totalindicador2").value == ""){
        flag = false;    
    }

    if(document.getElementById("totalindicador3").value == ""){
        flag = false;    
    }

    if(document.getElementById("totalindicador4").value == ""){
        flag = false;    
    }

    if(document.getElementById("totalindicador5").value == ""){
        flag = false;    
    }

    return flag;

}