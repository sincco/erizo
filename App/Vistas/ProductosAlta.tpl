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
	<label>Costo</label>
	<input type="text" class="form-control" name="costo">
	<label>Precio (sin IVA)</label>
	<input type="text" class="form-control" name="precio">
	<label>Mayorista 1 (sin IVA)</label>
	<input type="text" class="form-control" name="precio2">
	<label>Mayorista 2(sin IVA)</label>
	<input type="text" class="form-control" name="precio3">
	<label>Detalle(sin IVA)</label>
	<input type="text" class="form-control" name="precio4">
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
	<label>% utilidad</label>
	<input type="text" class="form-control" name="utilidad" disabled>
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardar()">Guardar</a></p>
</div>
<script type="text/javascript">
$("[name='precio']").change(function() {
	actualizaUtilidad()
})
$("[name='costo']").change(function() {
	actualizaUtilidad()
})

function actualizaUtilidad() {
	var utilidad = Math.round(((parseFloat($("[name='precio']").val()) / parseFloat($("[name='costo']").val())) * 100) - 100)
	if(parseFloat($("[name='costo']").val()) === 0)
		utilidad = 100
	$("[name='utilidad']").val(utilidad)
}

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