//Texto para las etiquetas de título en la navbar
document.getElementById("titulo-seccion").innerText = "Evaluación";
document.getElementById("titulo-pagina").innerText = "Portafolio Docente";
document.getElementById("titulo-principal").innerText = "Portafolio Docente";

//Class for default site
var mndashboard = document.getElementById('mnportafolio');
mndashboard.classList.add("active", "bg-gradient-primary");

var iddocente = document.getElementById("iddocente")
iddocente.addEventListener("change", function(){
	mostrarDocumentos();
});


var idcriterio = document.getElementById("idcriterio")
idcriterio.addEventListener("change", function(){
	mostrarDocumentos();
});

async function mostrarDocumentos()
{
	let iddocente = document.getElementById("iddocente").value;
	
	'use strict';
	const tbody = document.querySelector('#tbLista tbody');
	tbody.innerHTML = '';

	if(iddocente == ""){
		return;
	}

	await axios.get('https://evaluacion.itsup.edu.ec/admin/portafolio/finddocentecriterio/' + iddocente)
	.then(function (res){
		let rows = res.data;

		tbody.innerHTML = rows;
	});
}