<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
<h3>Alta de productos</h3>
<div id="errores"></div>
<form id="productos">
	<label>Clave</label>
	<input type="text" class="form-control" name="clave">
	<label>Línea</label>
	<select name="lineaProducto" id="lineaProducto" class="form-control">
		<option value="0">Selecciona</option>
		<ciclo lineas>
			<option value="{lineaProducto}">{descripcion}</option>
		</ciclo lineas>
	</select>
	<label>Descripcion</label>
	<input type="text" class="form-control" name="descripcion">
	<label>Descripcion Corta</label>
	<input type="text" class="form-control" name="descripcionCorta">
	<label>Precio</label>
	<input type="text" class="form-control" name="precio">
	<label>Unidad de medida</label>
	<select name="unidadMedida" class="form-control">
		<option value="NA">No aplica</option>
		<option value="PZA">Piezas</option>
		<option value="KG">Kilogramos</option>
		<option value="TON">Toneladas</option>
		<option value="LT">Litros</option>
	</select>
	<label>Aplica IVA</label>
	<select name="iva" class="form-control">
		<option value="0">No</option>
		<option value="1">Si</option>
	</select>
	<label>Aplica IEPS</label>
	<select name="ieps" class="form-control">
		<option value="0">No</option>
		<option value="1">Si</option>
	</select>
</form>
<br>
<p><a class="btn btn-primary btn-lg" href="#" role="button" onclick="guardar()">Guardar</a></p>
</div>
<script type="text/javascript">
function guardar() {
	if(parseInt($("#lineaProducto").val()) > 0) {
		sincco.consumirAPI('POST','{BASE_URL}productos/apiPost',$("#productos").serializeJSON())
		.done(function(data) {
			if(data.respuesta)
				window.location = '{BASE_URL}productos'
		}).fail(function(jqXHR, textStatus, errorThrown) {
			console.log(errorThrown)
		})
	} else {
		$("#errores").html('<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span><span class="sr-only">Error:</span>Debes definir la línea de producto</div>')
	}
}
</script>
<incluir archivo="Footer">