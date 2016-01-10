<incluir archivo="Header">
<menu>
<div class="container">
<h3>Alta de Líneas</h3>
<form id="lineasProductos">
	<label>Descripcion</label>
	<input type="text" class="form-control" name="descripcion">
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardarLinea()">Guardar</a></p>
</div>
<script type="text/javascript">
$(document).ready(function(){ 
	$("#tabs li:eq(0) a").tab('show')
})

function guardarLinea() {
	sincco.consumirAPI('POST','{BASE_URL}lineasproductos/apiPost',$("#lineasProductos").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}lineasproductos'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})	
}
</script>
<incluir archivo="Footer">