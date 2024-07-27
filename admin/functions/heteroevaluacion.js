//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Heteroevaluación";
document.getElementById("titulo-principal").innerText = "Registro Evaluadores";

//Class for default site
var mndashboard = document.getElementById('mnheteroevaluacion');
mndashboard.classList.add("active", "bg-gradient-primary");

var cmbIdAutoridad = document.getElementById("idautoridad");
cmbIdAutoridad.addEventListener("change", async function(event){
    'use strict';
    const tbody = document.querySelector('#tbLista tbody');
    tbody.innerHTML = '';

    if(cmbIdAutoridad.value==""){
        return;
    }

    let idautoridad = cmbIdAutoridad.value;
    await axios.get(DIR + 'heteroevaluacion/selectautoridaddocente/' + idautoridad)
    .then(function (res) {
        let rows = res.data;
        tbody.innerHTML = rows;
    })
});

var docenteModal = new bootstrap.Modal(document.getElementById('docenteModal'), {
    keyboard: false
})

function lista()
{
    let idautoridad = document.getElementById("idautoridad").value;
    if(idautoridad==''){
        $.alert({ 
            title	: 'Información del Sistema', 
            icon	: 'fas fa-exclamation-circle',
            content	: 'Seleccione una Autoridad',
            type	: 'orange',
            theme	: 'modern'				
        });
        
        return;
    }

    docenteModal.show();
}

async function agregar(iddocente)
{
    let idautoridad = document.getElementById("idautoridad").value;

    $.confirm({
		title: 'Alerta del Sistema',
		icon: 'fa fa-question',
		content: 'Esta seguro que desea realizar esta asignación?',
		type: 'blue',
		theme: 'modern',
		buttons: {
			continuar: async function () {
				await axios.post(DIR + 'heteroevaluacion/insert/', {
                    idautoridad,
                    iddocente
                })
				.then(function (res) {
                    let rows = res.data;

                    'use strict';
                    const tbody = document.querySelector('#tbLista tbody');
                    tbody.innerHTML = '';

		            tbody.innerHTML = rows;
				})
			},
			cancelar: function() {
				
			}
		}
	});
}

async function eliminar(idheteroevaluacion)
{
    let idautoridad = document.getElementById("idautoridad").value;

    $.confirm({
		title: 'Alerta del Sistema',
		icon: 'fa fa-question',
		content: 'Esta seguro que desea eliminar este registro?',
		type: 'blue',
		theme: 'modern',
		buttons: {
			continuar: async function () {
				await axios.post(DIR + 'heteroevaluacion/delete/', {
                    idautoridad,
                    idheteroevaluacion
                })
				.then(function (res) {
                    let rows = res.data;

                    'use strict';
                    const tbody = document.querySelector('#tbLista tbody');
                    tbody.innerHTML = '';
                    
		            tbody.innerHTML = rows;
				})
			},
			cancelar: function() {
				
			}
		}
	});
}