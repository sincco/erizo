<incluir archivo="Header">
<menu>
<div class="container">
<h3>Editar producto</h3>
<div id="errores"></div>
<form id="productos">
	<ciclo producto>
		<label>Clave</label>
		<input type="text" class="form-control" name="clave1" disabled value="{clave}">
		<input type="hidden" class="form-control" name="clave" value="{clave}">
		<input type="hidden" class="form-control" name="unidadMedida" value="{unidadMedida}">
		<input type="hidden" class="form-control" name="iva" value="{iva}">
		<input type="hidden" class="form-control" name="lineaProducto" value="{lineaProducto}">
		<label>Descripcion</label>
		<input type="text" class="form-control" name="descripcion" value="{descripcion}">
		<label>Descripcion Corta</label>
		<input type="text" class="form-control" name="descripcionCorta" value="{descripcionCorta}">
		<label>Costo</label>
		<input type="text" class="form-control" name="costo" value="{costo}">
		<label>Precio (sin IVA)</label>
		<input type="text" class="form-control" name="precio" value="{precio}">
		<label>Mayorista 1(sin IVA)</label>
		<input type="text" class="form-control" name="precio2" value="{precio2}">
		<label>Mayorista 2(sin IVA)</label>
		<input type="text" class="form-control" name="precio3" value="{precio3}">
		<label>Detalle(sin IVA)</label>
		<input type="text" class="form-control" name="precio4" value="{precio4}">
		<label>Unidad de medida</label>
		<select name="unidadMedida" class="form-control">
			<option value="NA">No aplica</option>
			<option value="PZA">Piezas</option>
			<option value="KG">Kilogramos</option>
			<option value="TON">Toneladas</option>
			<option value="LT">Litros</option>
		</select>
		<label>% utilidad</label>
	<input type="text" class="form-control" name="utilidad" disabled>
	</ciclo producto>
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardar()">Guardar</a> <a class="btn btn-danger btn-md" href="#" role="button" onclick="dasactivar()">Borrar</a></p>
</div>
<script type="text/javascript">
$(function() {
	actualizaUtilidad()
})

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
	sincco.consumirAPI('POST','{BASE_URL}productos/apiUpd',$("#productos").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}productos'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}

function dasactivar() {
	sincco.consumirAPI('POST','{BASE_URL}productos/apiDel',$("#productos").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}productos'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}
</script>
<incluir archivo="Footer">