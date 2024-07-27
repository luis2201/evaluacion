//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Sílabos actualizados y firmados";
document.getElementById("titulo-principal").innerText = "Sílabos actualizados y firmados";

//Class for default site
var mndashboard = document.getElementById('mnsilabos');
mndashboard.classList.add("active", "bg-gradient-primary");

$('.form').submit(async function(event){	
	event.preventDefault();

    var formData = new FormData(this);

    await axios.post('https://evaluacion.itsup.edu.ec/docente/silabos/upload/', formData)
	.then(function (res){
        if (res.data) {
			$.alert({
				title: 'Alerta del Sistema',
				icon: 'fa fa-thumbs-o-up',
				content: 'Documento guardado satisfactoriamente.',
				type: 'blue',
				theme: 'modern',
				buttons: {
					aceptar: function () {
						window.location.reload();
					}
				}
			});
		} else {
			$.alert({
				title: 'Alerta del Sistema',
				icon: 'fas fa-exclamation-circle',
				content: 'Ocurrió un error al intentar guardar el archivo. Intente nuevamente.',
				type: 'orange',
				theme: 'modern',
				buttons: {
					aceptar: function () {

					}
				}
			});
		}
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

});