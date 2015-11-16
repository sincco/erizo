<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
<h3>Edición de ruta</h3>
<form id="almacenes">
	<label>Descripcion</label>
	<ciclo almacenes>
		<input type="hidden" name="almacen" value="{almacen}">
		<input type="text" class="form-control" name="descripcion" value="{descripcion}">
		<label>almacen principal</label>
		<select id="principal" name="principal" class="form-control">
			<option value="0">No</option>
			<option value="1">Si</option>
		</select>
	</ciclo almacenes>
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardarLinea()">Guardar</a></p>
</div>
<script type="text/javascript">
$(function() {
	<ciclo almacenes>
	var principal = {principal}
	</ciclo almacenes>
	$("#principal").val(principal)
})
function guardarLinea() {
	sincco.consumirAPI('POST','{BASE_URL}almacenes/apiUpd',$("#almacenes").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}almacenes'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}
</script>
<incluir archivo="Footer">