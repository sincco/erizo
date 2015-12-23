<incluir archivo="Header">
<menu>
<div class="container">
<h3>Editar vendedor</h3>
<form id="vendedores">
	<ciclo vendedores>
		<label>Usuario</label>
		<input type="hidden"name="vendedor" value="{vendedor}">
		<input type="text" value="{nombre}" class="form-control" disabled>
	</ciclo vendedores>
	<label>Almacen</label>
	<select id="almacen" name="almacen" class="form-control">
		<option value="0">Selecciona un almacen</option>
		<ciclo almacenes>
			<option value="{almacen}">{descripcion}</option>
		</ciclo almacenes>
	</select>
	<ciclo vendedores>
		<label>% Comisión</label>
		<input type="text" name="comision" class="form-control" value="{comision}">
	</ciclo vendedores>
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardar()">Guardar</a></p>
</div>
<script type="text/javascript">
$(function() {
	<ciclo vendedores>
	var almacen = {almacen}
	</ciclo vendedores>
	$("#almacen").val(almacen)
})

function guardar() {
	sincco.consumirAPI('POST','{BASE_URL}vendedores/apiUpd',$("#vendedores").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}vendedores'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}
</script>
<incluir archivo="Footer">