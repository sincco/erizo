<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
<h3>Alta de almacenes</h3>
<form id="almacenes">
	<label>Descripcion</label>
	<input type="text" class="form-control" name="descripcion">
</form>
<br>
<p><a class="btn btn-primary btn-lg" href="#" role="button" onclick="guardarLinea()">Guardar</a></p>
</div>
<script type="text/javascript">
function guardarLinea() {
	sincco.consumirAPI('POST','{BASE_URL}almacenes/apiPost',$("#almacenes").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}almacenes'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})	
}
</script>
<incluir archivo="Footer">